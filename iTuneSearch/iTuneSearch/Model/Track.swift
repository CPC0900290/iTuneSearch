//
//  Track.swift
//  iTuneSearch
//
//  Created by Pin Chen on 2024/7/10.
//

import Foundation

struct TrackResult: Codable {
  let results: [Track]
}

struct Track: Codable {
  let trackName: String
  var trackTimeMillis: Float
  let longDescription: String?
  let artworkUrl100: String
}

extension Track {
  var formattedTrackTime: String {
    let totalSeconds = Int(trackTimeMillis / 1000)
    let hours = totalSeconds / 3600
    let minutes = (totalSeconds % 3600) / 60
    let seconds = totalSeconds % 60
    return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
  }
}
