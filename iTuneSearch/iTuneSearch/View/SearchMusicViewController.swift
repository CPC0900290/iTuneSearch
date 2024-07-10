//
//  SearchMusicViewController.swift
//  iTuneSearch
//
//  Created by Pin Chen on 2024/7/10.
//

import UIKit

class SearchMusicViewController: UIViewController {
  
  // MARK: Property var
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var searchButton: UIButton!
  @IBOutlet weak var searchTextField: UITextField!
  private var viewModel = SearchMusicViewModel()
  
  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.setupTestData()
    setupCollectionView()
    // Do any additional setup after loading the view.
  }
  
  // MARK: UI setup
  private func setupCollectionView() {
    collectionView.register(UINib(nibName: "TrackCell", bundle: nil), forCellWithReuseIdentifier: "TrackCell")
    collectionView.collectionViewLayout = setupCVLayout()
    collectionView.dataSource = self
  }
  
  private func setupCVLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout { sectionNum, _ in
      let heightDimension = NSCollectionLayoutDimension.estimated(200)
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                            heightDimension: heightDimension)
      let item = NSCollectionLayoutItem(layoutSize: itemSize) // Whithout badge
      item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
      
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                             heightDimension: heightDimension)
      let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                   repeatingSubitem: item,
                                                   count: 1)
      group.interItemSpacing = .fixed(CGFloat(10))
      let section = NSCollectionLayoutSection(group: group)
      return section
    }
  }
}

extension SearchMusicViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    viewModel.testDatas.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackCell.identifier, for: indexPath) as! TrackCell
    cell.trackName.text = viewModel.testDatas[indexPath.item].trackName
    cell.trackTimeMillis.text = viewModel.testDatas[indexPath.item].formattedTrackTime
    cell.longDescription.text = viewModel.testDatas[indexPath.item].longDescription
    cell.trackImage.image = UIImage(named: viewModel.testDatas[indexPath.item].trackImage)
    return cell
  }
}

extension SearchMusicViewController: UICollectionViewDelegate {
  
}

