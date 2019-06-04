//
//  APIService.swift
//  AppStore
//
//  Created by Derrick Park on 2019-04-29.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import Foundation

class APIService {
  static let shared = APIService()
  private init() {}
  
  func fetchSearchResultApps(searchTerm: String, completion: @escaping ([ResultApp], Error?) -> ()) {
    // 1. get url
    let urlStr = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software&limit=12"
    guard let url = URL(string: urlStr) else { return }
    // 2. send a request
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      
      if let err = error {
        print("Failed to fetch apps: ", err)
        completion([], err)
        return
      }
      
      guard let data = data else { return }
      do {
        // 3. parse response
        let searchResult = try JSONDecoder().decode(SearchResultApp.self, from: data)
        // success
        completion(searchResult.results, nil)
        
      } catch let jsonError {
        print("Failed to decode JSON:", jsonError)
        completion([], jsonError)
      }
    }.resume() // fires!
  }

  enum AppGroupAPIEndPoint: String {
    case popularAppsGames = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/25/explicit.json"
    case topFreeApps = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/25/explicit.json"
    case topPaidApps = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-paid/all/25/explicit.json"
  }

  func fetchAppGroup<T: Decodable>(url: AppGroupAPIEndPoint, completion: @escaping (T?, Error?) -> ()) {
    let url = URL(string: url.rawValue)!
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let err = error {
        completion(nil, err)
        return
      }
      do {
        guard let data = data else { return }
        let appGroup = try JSONDecoder().decode(T.self, from: data)
        completion(appGroup, nil)
      } catch {
        completion(nil, error)
      }
    }.resume()
  }
}

