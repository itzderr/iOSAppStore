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
  
  func fetchSearchResultApps(searchTerm: String, completion: @escaping (SearchResultApp?, Error?) -> ()) {
    fetchAppGroup(url: APIEndPoint.searchApps(searchTerm: searchTerm), completion: completion)
  }

  func fetchAppGroup<T: Decodable>(url: String, completion: @escaping (T?, Error?) -> ()) {
    let url = URL(string: url)!
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

// We could have used enum with String rawValue

struct APIEndPoint {
  @inline(__always) static func searchApps(searchTerm: String) -> String {
    return "https://itunes.apple.com/search?term=\(searchTerm)&entity=software&limit=12"
  }
  static let popularAppsGames = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/25/explicit.json"
  static let topFreeApps = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/25/explicit.json"
  static let topPaidApps = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-paid/all/25/explicit.json"
}

