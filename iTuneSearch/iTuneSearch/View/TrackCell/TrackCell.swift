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
  
  @IBOutlet weak var longDescription: UILabel!
  @IBOutlet weak var trackTimeMillis: UILabel!
  @IBOutlet weak var trackName: UILabel!
  @IBOutlet weak var trackImage: UIImageView!
}
