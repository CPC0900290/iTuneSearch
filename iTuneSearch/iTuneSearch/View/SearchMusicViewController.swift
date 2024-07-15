//
//  SearchMusicViewController.swift
//  iTuneSearch
//
//  Created by Pin Chen on 2024/7/10.
//

import UIKit
import RxSwift
import RxCocoa

class SearchMusicViewController: UIViewController {
  
  // MARK: Property var
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var searchButton: UIButton!
  @IBOutlet weak var searchTextField: UITextField!
  private var viewModel = SearchMusicViewModel()
  private let disposeBag = DisposeBag()
  
  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    setupBinding()
    bindingCell()
    // Do any additional setup after loading the view.
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    searchButton.layer.cornerRadius = searchButton.frame.width / 30
  }
  
  // MARK: UI setup
  private func setupCollectionView() {
    collectionView.register(UINib(nibName: "TrackCell", bundle: nil), forCellWithReuseIdentifier: "TrackCell")
    collectionView.collectionViewLayout = setupCVLayout()
  }
  
  private func setupCVLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout { sectionNum, _ in
      let heightDimension = NSCollectionLayoutDimension.estimated(200)
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                            heightDimension: heightDimension)
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
      
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                             heightDimension: heightDimension)
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                   repeatingSubitem: item,
                                                   count: 1)
      group.interItemSpacing = .fixed(CGFloat(10))
      let section = NSCollectionLayoutSection(group: group)
      return section
    }
  }
  
  // MARK: setup binding
  private func setupBinding() {
    searchButton.rx.tap
      .withLatestFrom(searchTextField.rx.text)
      .bind {[weak self] text in
        self?.viewModel.search(for: text ?? "")
      }
      .disposed(by: disposeBag)
    
    searchTextField.rx.text
      .orEmpty
      .bind(to: viewModel.searchText)
      .disposed(by: disposeBag)
    
    viewModel.searchResults
      .observe(on: MainScheduler.instance)
      .bind(to: collectionView.rx.items(cellIdentifier: "TrackCell", cellType: TrackCell.self)) {[weak self] index, model, cell in
        let isPlaying = (try? self?.viewModel.currentlyPlaying.value()) == model
        cell.update(model: model, isPlaying: isPlaying)
      }
      .disposed(by: disposeBag)
    
    viewModel.currentlyPlaying
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] _ in
        self?.collectionView.reloadData()
      })
      .disposed(by: disposeBag)
  }
  
  private func bindingCell() {
    collectionView.rx
      .modelSelected(Track.self)
      .subscribe(onNext: { [weak self] track in
        self?.viewModel.togglePlay(for: track)
      })
      .disposed(by: disposeBag)
  }
}
