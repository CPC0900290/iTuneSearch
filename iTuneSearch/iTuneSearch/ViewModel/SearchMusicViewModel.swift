//
//  SearchMusicViewModel.swift
//  iTuneSearch
//
//  Created by Pin Chen on 2024/7/10.
//

import Foundation

class SearchMusicViewModel {
  let testData = Track(trackName: "longTrackName1 longlonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglong",
                       trackTimeMillis: 3750000,
                       longDescription: "longDescription: here is description pretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty long",
                       trackImage: "music")
  let testDataA = Track(trackName: "longTrackName2 longlonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglong",
                        trackTimeMillis: 3750000,
                        longDescription: "longDescription: here is description pretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty long",
                        trackImage: "music")
  let testDataB = Track(trackName: "longTrackName3 longlonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglong",
                        trackTimeMillis: 3750000,
                        longDescription: "longDescription: here is description pretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty longpretty long",
                        trackImage: "music")
  var testDatas: [Track] = []
  
  func setupTestData() {
    testDatas.append(testData)
    testDatas.append(testDataA)
    testDatas.append(testDataB)
  }
}
