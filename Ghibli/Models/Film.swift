//
//  Film.swift
//  Ghibli
//
//  Created by Sasha Jaroshevskii on 10/29/25.
//

import Foundation
import Playgrounds

struct Film: Decodable, Identifiable, Equatable, Hashable {
  let id: String
  let title: String
  let image: String
  let bannerImage: String
  let description: String
  let director: String
  let producer: String
  let releaseDate: String
  let duration: String
  let score: String
  let people: [String]
  
  enum CodingKeys: String, CodingKey {
    case id, title, image, description, director, producer, people
    case bannerImage = "movie_banner"
    case releaseDate = "release_date"
    case duration = "running_time"
    case score = "rt_score"
  }
}

extension Film {
  static let mock = {
    let posterURL = AssetExtractor.createLocalUrl(forImageNamed: "FilmPoster")
    let bannerURL = AssetExtractor.createLocalUrl(forImageNamed: "FilmBanner")
    return Self(
      id: "2baf70d1-42bb-4437-b551-e5fed5a87abe",
      title: "Castle in the Sky",
      image: posterURL?.absoluteString ?? "",
      bannerImage: bannerURL?.absoluteString ?? "",
      description: "The orphan Sheeta inherited a mysterious crystal that links her to the mythical sky-kingdom of Laputa.",
      director: "Hayao Miyazaki",
      producer: "Isao Takahata",
      releaseDate: "1986",
      duration: "124",
      score: "95",
      people: [
        "https://ghibliapi.vercel.app/people/598f7048-74ff-41e0-92ef-87dc1ad980a9",
        "https://ghibliapi.vercel.app/people/fe93adf2-2f3a-4ec4-9f68-5422f1b87c01",
        "https://ghibliapi.vercel.app/people/3bc0b41e-3569-4d20-ae73-2da329bf0786",
        "https://ghibliapi.vercel.app/people/40c005ce-3725-4f15-8409-3e1b1b14b583",
        "https://ghibliapi.vercel.app/people/5c83c12a-62d5-4e92-8672-33ac76ae1fa0",
        "https://ghibliapi.vercel.app/people/e08880d0-6938-44f3-b179-81947e7873fc",
        "https://ghibliapi.vercel.app/people/2a1dad70-802a-459d-8cc2-4ebd8821248b",
      ]
    )
  }()
}

#Playground {
  let url = URL(string: "https://ghibliapi.vercel.app/films")!
  
  do {
    let (data, _) = try await URLSession.shared.data(from: url)
    _ = try JSONDecoder().decode([Film].self, from: data)
  } catch {
    print(error)
  }
}
