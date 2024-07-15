//
//  SearchMusicViewModel.swift
//  iTuneSearch
//
//  Created by Pin Chen on 2024/7/10.
//

import Foundation
import RxSwift
import RxRelay
import AVFoundation
// 訂閱 button 觸及事件

protocol SearchMusicViewModelActions: AnyObject {
  func fetchTracks(for query: String) -> Observable<[Track]>
  
  var searchText: PublishSubject<String> { get }
  var searchResults: PublishRelay<[Track]> { get }
  var currentlyPlaying: BehaviorSubject<Track?> { get }
}

class SearchMusicViewModel: SearchMusicViewModelActions {
  private let disposeBag = DisposeBag()
  var searchText = PublishSubject<String>()
  var searchResults = PublishRelay<[Track]>()
  var currentlyPlaying: BehaviorSubject<Track?> = BehaviorSubject(value: nil)
  let player = AVPlayer()
  
  init() {
    searchText
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .distinctUntilChanged()
      .flatMapLatest { query in
        self.fetchTracks(for: query)
      }
      .bind(to: searchResults)
      .disposed(by: disposeBag)
  }
  
  internal func fetchTracks(for query: String) -> Observable<[Track]> {
    return ApiService.shared.getTracks(searchInput: query)
      .flatMap { result -> Observable<[Track]> in
        switch result {
        case .success(let tracks):
          return .just(tracks)
        case .failure(let error):
          print("Error: \(error.localizedDescription)")
          return .empty()
        }
      }
  }
  
  func search(for text: String) {
    searchText.onNext(text)
  }
  
  private func playMusic(from music: String) {
    guard let musicUrl = URL(string: music) else { return }
    let playerItem = AVPlayerItem(url: musicUrl)
    player.replaceCurrentItem(with: playerItem)
    player.play()
  }
  
  private func playPause() {
    if player.timeControlStatus == .playing{
      player.pause()
    }else{
      player.play()
    }
  }
  
  private func updatePlayingStatus() {
    if player.timeControlStatus == .paused {
      currentlyPlaying.onNext(nil)
    }
  }
  
  func togglePlay(for track: Track) {
    if (try? currentlyPlaying.value()) == track {
      playPause()
    } else {
      playMusic(from: track.previewUrl)
      currentlyPlaying.onNext(track)
    }
    updatePlayingStatus()
  }
}
