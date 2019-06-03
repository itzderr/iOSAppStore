//
//  AppGroup.swift
//  AppStore
//
//  Created by Derrick Park on 2019-05-31.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import Foundation

struct AppGroup: Decodable {
  let feed: Feed
}

struct Feed: Decodable {
  let title: String
  let results: [AppResult]
}

struct AppResult: Decodable {
  let artistName: String
  let name: String
  let artworkUrl100: String
}
