//
//  LiveGhibliClient.swift
//  Ghibli
//
//  Created by Sasha Jaroshevskii on 11/9/25.
//

import Dependencies
import Foundation
import IdentifiedCollections

extension GhibliClient: DependencyKey {
  static let liveValue = {
    let jsonDecoder = JSONDecoder()
    return Self(
      films: {
        guard let url = URL(string: "https://ghibliapi.vercel.app/films") else {
          throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let films = try jsonDecoder.decode(IdentifiedArrayOf<Film>.self, from: data)
        return films
      }
    )
  }()
}
