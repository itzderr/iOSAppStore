//
//  SearchResultApp.swift
//  AppStore
//
//  Created by Derrick Park on 2019-04-29.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import Foundation

struct SearchResultApp: Decodable {
  let resultCount: Int
  let results: [ResultApp]
}

struct ResultApp: Decodable {
  let trackName: String
  let primaryGenreName: String
  let averageUserRating: Float? // some result does not have rating field
  let screenshotUrls: [String]
  let artworkUrl100: String // icon
  
}
