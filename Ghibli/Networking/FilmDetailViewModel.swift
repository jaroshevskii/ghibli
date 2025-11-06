//
//  FilmDetailViewModel.swift
//  Ghibli
//
//  Created by Sasha Jaroshevskii on 10/29/25.
//

import Foundation
import Observation
import Playgrounds

@Observable
final class FilmDetailViewModel {
  enum State: Equatable {
    case idle, loading, loaded([Person]), error(String)
  }
  
  private(set) var state = State.idle
  
  private let service: GhibliService
  
  init(service: GhibliService = DefaultGhibliService()) {
    self.service = service
  }
  
  func fetch(for film: Film) async {
    guard state != .loading else { return }
    state = .loading
    do {
      let people = try await withThrowingTaskGroup(of: (Int, Person).self) { group in
        for (index, personInfoURL) in film.people.enumerated() {
          group.addTask {
            let person = try await self.service.fetchPerson(from: personInfoURL)
            return (index, person)
          }
        }
        
        var results: [(Int, Person)] = []
        for try await result in group {
          results.append(result)
        }
        
        return results.sorted { $0.0 < $1.0 }.map { $0.1 }
      }
      state = .loaded(people)
    } catch let error as APIError {
      state = .error(error.errorDescription ?? "Unknown error")
    } catch {
      state = .error("Unknown error")
    }
  }
}

#Playground {
  let service = MockGhibliService()
  let vm = FilmDetailViewModel(service: service)
  let film = service.fetchFilm()
  await vm.fetch(for: film)
  switch vm.state {
  case .idle:
    print("Idle")
  case .loading:
    print("Loading...")
  case .loaded(let people):
    for person in people {
      print(person)
    }
  case .error(let message):
    print("Error: \(message)")
  }
}
