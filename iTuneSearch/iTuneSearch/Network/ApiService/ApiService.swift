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
  func getTracks(searchInput: String) -> Observable<Result<[Track], NetworkError>>
}

class ApiService: ApiServiceActions, Request {
  
  private let dataLoader: DataLoader
  
  // MARK: Request parameters
  var host: String
  var path: String
  var queryItems: [URLQueryItem]
  
  static let shared = ApiService()
  
  // MARK: Initialization
  init() {
    dataLoader = DataLoader()
    
    self.host = ApiURL.baseURL
    self.path = ""
    self.queryItems = []
  }
}

extension ApiService {
  
  func getTracks(searchInput: String) -> Observable<Result<[Track], NetworkError>> {
    return Observable.create { observer in
      self.path = "/search"
      self.queryItems = []
      let searchText = URLQueryItem(name: "term", value: searchInput)
      self.queryItems = [searchText]
      
      self.dataLoader.request(self, decodable: TrackResult.self) { response in
        switch response {
        case .success(let data):
          observer.onNext(.success(data.results))
        case .failure(_):
          observer.onNext(.failure(.decodingFailed))
        }
        observer.onCompleted()
      }
      return Disposables.create()
    }
  }
}
