//
//  TrackCell.swift
//  iTuneSearch
//
//  Created by Pin Chen on 2024/7/10.
//

import Foundation
import UIKit
import Kingfisher

class TrackCell: UICollectionViewCell {
  static let identifier = String(describing: TrackCell.self)
  
  @IBOutlet weak var playPauseIcon: UIImageView!
  @IBOutlet weak var longDescriptionLabel: UILabel!
  @IBOutlet weak var trackTimeMillisLabel: UILabel!
  @IBOutlet weak var trackNameLabel: UILabel!
  @IBOutlet weak var trackImage: UIImageView!
  
  func update(model: Track, isPlaying: Bool) {
    playPauseIcon.image = isPlaying ? UIImage(systemName: "pause.rectangle.fill") : UIImage(systemName: "play.square.fill")
    self.playPauseIcon.isHidden = !isPlaying
    trackNameLabel.text = model.trackName
    trackTimeMillisLabel.text = model.formattedTrackTime
    longDescriptionLabel.text = model.longDescription
    trackImage.kf.setImage(with: URL(string: model.artworkUrl100))
    trackImage.layer.cornerRadius = trackImage.frame.width / 10
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
  }
  
  private func setupViews() {
    contentView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150)
    ])
  }
}
