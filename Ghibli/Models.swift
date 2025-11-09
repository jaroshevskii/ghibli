//
//  Models.swift
//  Ghibli
//
//  Created by Sasha Jaroshevskii on 11/9/25.
//

import Foundation
import Tagged
import IdentifiedCollections

struct Film: Identifiable, Equatable, Decodable {
  let id: ID
  let title: String
  let description: String
  let imageURL: URL
  let director: String
  let releaseDate: String
        
  typealias ID = Tagged<Self, UUID>
  
  enum CodingKeys: String, CodingKey {
    case id, title, description, director
    case imageURL = "image"
    case releaseDate = "release_date"
  }
}

extension Film {
  static let mock = Self(
    id: Film.ID(UUID()),
    title: "Castle in the Sky",
    description: "The orphan Sheeta inherited a mysterious crystal that links her to the mythical sky-kingdom of Laputa. With the help of resourceful Pazu and a rollicking band of sky pirates, she makes her way to the ruins of the once-great civilization. Sheeta and Pazu must outwit the evil Muska, who plans to use Laputa's science to make himself ruler of the world.",
    imageURL: URL(string: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/npOnzAbLh6VOIu3naU5QaEcTepo.jpg")!,
    director: "Hayao Miyazaki",
    releaseDate: "1986"
  )
  static let mocks: IdentifiedArray = [
    mock,
    Self(
      id: Film.ID(UUID()),
      title: "My Neighbor Totoro",
      description: "Two sisters move to the country with their father in order to be closer to their hospitalized mother, and discover the surrounding trees are inhabited by Totoros, magical spirits of the forest. When the youngest runs away from home, the older sister seeks help from the spirits to find her.",
      imageURL: URL(string: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/rtGDOeG9LzoerkDGZF9dnVeLppL.jpg")!,
      director: "Hayao Miyazaki",
      releaseDate: "1988"
    ),
    Self(
      id: Film.ID(UUID()),
      title: "Grave of the Fireflies",
      description: "In the latter part of World War II, a boy and his sister, orphaned when their mother is killed in the firebombing of Tokyo, are left to survive on their own in what remains of civilian life in Japan. The plot follows this boy and his sister as they do their best to survive in the Japanese countryside, battling hunger, prejudice, and pride in their own quiet, personal battle.",
      imageURL: URL(string: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/qG3RYlIVpTYclR9TYIsy8p7m7AT.jpg")!,
      director: "Isao Takahata",
      releaseDate: "1988"
    )
  ]
}
