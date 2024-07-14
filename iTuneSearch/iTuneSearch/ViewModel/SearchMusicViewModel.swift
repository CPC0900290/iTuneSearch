//
//  SearchMusicViewModel.swift
//  iTuneSearch
//
//  Created by Pin Chen on 2024/7/10.
//

import Foundation
import RxSwift
import RxRelay
// 訂閱 button 觸及事件

protocol SearchMusicViewModelActions: AnyObject {
  func fetchTracks(for query: String) -> Observable<[Track]>
  
  var searchText: PublishSubject<String> { get }
  var searchResults: PublishRelay<[Track]> { get }
}

class SearchMusicViewModel: SearchMusicViewModelActions {
  private let disposeBag = DisposeBag()
  var searchText = PublishSubject<String>()
  var searchResults = PublishRelay<[Track]>()
  
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
}
