//
//  MockGhibliService.swift
//  Ghibli
//
//  Created by Sasha Jaroshevskii on 10/29/25.
//

import Foundation

struct MockGhibliService: GhibliService {
  private struct SampleData: Decodable {
    let films: [Film]
    let people: Person
  }
  
  private func loadSampleData() throws -> SampleData {
    guard let url = Bundle.main.url(forResource: "SampleData", withExtension: "json") else {
      throw APIError.invalidURL
    }
    do {
      let data = try Data(contentsOf: url)
      return try JSONDecoder().decode(SampleData.self, from: data)
    } catch let error as DecodingError {
      print(error)
      throw APIError.decoding(error)
    } catch {
      throw APIError.network(error)
    }
  }
  
  func fetchPerson(from urlString: String) async throws -> Person {
    let data = try loadSampleData()
    return data.people
  }
  
  func fetchFilms() async throws -> [Film] {
    let data = try loadSampleData()
    return data.films
  }
  
  /// Only for preview or testing.
  func fetchFilm() -> Film {
    let data = try! loadSampleData()
    return data.films.first!
  }
}
