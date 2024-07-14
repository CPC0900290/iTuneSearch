//
//  ApiService.swift
//  iTuneSearch
//
//  Created by Pin Chen on 2024/7/11.
//

import Foundation
import RxSwift

typealias GetTracksType = Result<[Track], NetworkError>

protocol ApiServiceActions: AnyObject {
//    func getTracks(searchInput: String,
//                   completion: @escaping (GetTracksType) -> Void)
  func getTracks(searchInput: String) -> Observable<Result<[Track], NetworkError>>
}

class ApiService: ApiServiceActions, Request {
  
  private let dataLoader: DataLoader
  
  // MARK: Request parameters
  var host: String
  var path: String
  var queryItems: [URLQueryItem]
//  var headers: [String : String]
  
  static let shared = ApiService()
  
  // MARK: Initialization
  init() {
    dataLoader = DataLoader()
    
    self.host = ApiURL.baseURL
    self.path = ""
    self.queryItems = []
//    self.headers = [:]
  }
}

extension ApiService {
  /// gets images from api
  /// - Parameter completion: completion handler for function
  /// - Parameter searchInput: represent user input for search
//  func getTracks(searchInput: String,
//                 completion: @escaping (Result<[Track], NetworkError>) -> Void) {
//    self.path = "/search"
//    
//    self.queryItems = []
//    let searchText = URLQueryItem(name: "term", value: searchInput)
//    self.queryItems = [searchText]
//    
//    dataLoader.request(self, decodable: [Track].self) { response in
//      completion(response)
//    }
//  }
  
  func getTracks(searchInput: String) -> Observable<Result<[Track], NetworkError>> {
    // Simulate a network request
    return Observable.create { observer in
      self.path = "/search"
      self.queryItems = []
      let searchText = URLQueryItem(name: "term", value: searchInput)
      self.queryItems = [searchText]
      
      self.dataLoader.request(self, decodable: TrackResult.self) { response in
        switch response {
        case .success(let data):
          observer.onNext(.success(data.results))
        case .failure(let error):
          observer.onNext(.failure(NetworkError.decodingFailed))
        }
        observer.onCompleted()
      }
      //              let delayTime = DispatchTime.now() + 2 // Simulate network delay
      //              DispatchQueue.global().asyncAfter(deadline: delayTime) {
      //                  if Bool.random() { // Randomly simulate success or failure
      //                      let tracks = [Track(name: "Track A", description: "Description A"), Track(name: "Track B", description: "Description B")]
      //                      observer.onNext(.success(tracks))
      //                  } else {
      //                      observer.onNext(.failure(NetworkError.serverError("Failed to fetch tracks")))
      //                  }
      //                  observer.onCompleted()
      //              }
      return Disposables.create()
    }
  }
}
