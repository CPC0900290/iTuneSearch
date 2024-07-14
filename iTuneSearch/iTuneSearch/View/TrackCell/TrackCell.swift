//
//  TrackCell.swift
//  iTuneSearch
//
//  Created by Pin Chen on 2024/7/10.
//

import Foundation
import UIKit

class TrackCell: UICollectionViewCell {
  static let identifier = String(describing: TrackCell.self)
  
  @IBOutlet weak var longDescriptionLabel: UILabel!
  @IBOutlet weak var trackTimeMillisLabel: UILabel!
  @IBOutlet weak var trackNameLabel: UILabel!
  @IBOutlet weak var trackImage: UIImageView!
  
  func update(model: Track) {
    print("====== model in cell: \(model) ========")
    trackNameLabel.text = model.trackName
    trackTimeMillisLabel.text = model.formattedTrackTime
    longDescriptionLabel.text = model.longDescription
    // set image by kingfisher
  }
}
