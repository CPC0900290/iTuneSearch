//
//  NetworkError.swift
//  iTuneSearch
//
//  Created by Pin Chen on 2024/7/11.
//

import Foundation

public enum NetworkError: Error {
  case invalidURL
  case decodingFailed
  case unknown
  case canNotGetData
}
