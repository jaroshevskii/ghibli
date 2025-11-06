//
//  FilmsViewModel.swift
//  Ghibli
//
//  Created by Sasha Jaroshevskii on 10/29/25.
//

import Foundation
import Observation

@Observable
final class FilmsViewModel {
  enum State: Equatable {
    case idle, loading, loaded([Film]), error(String)
  }
  
  var state = State.idle
  
  var films: [Film] = []
  
  private let service: GhibliService
  
  init(service: GhibliService = DefaultGhibliService()) {
    self.service = service
  }
  
  func fetch() async {
    guard case .idle = state else { return }
    state = .loading
    do {
      state = .loaded(try await service.fetchFilms())
    } catch let error as APIError {
      state = .error(error.errorDescription ?? "Unknown error")
    } catch {
      state = .error("Unknown error")
    }
  }
}
