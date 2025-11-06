//
//  Person.swift
//  Ghibli
//
//  Created by Sasha Jaroshevskii on 10/29/25.
//

import Foundation
import Playgrounds

struct Person: Identifiable, Decodable, Equatable {
  let id: String
  let name: String
  let gender: String
  let age: String
  let eyeColor: String
  let hairColor: String
  let films: [String]
  let species: String
  let url: String
  
  enum CodingKeys: String, CodingKey {
    case id, name, gender, age, films, species, url
    case eyeColor = "eye_color"
    case hairColor = "hair_color"
  }
}

#Playground {
  let url = URL(string: "https://ghibliapi.vercel.app/people/2a1dad70-802a-459d-8cc2-4ebd8821248b")!
  do {
    let (data, _) = try await URLSession.shared.data(from: url)
    _ = try JSONDecoder().decode(Person.self, from: data)
  } catch {
    print(error)
  }
}
