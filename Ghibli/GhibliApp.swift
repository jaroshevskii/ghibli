//
//  GhibliApp.swift
//  Ghibli
//
//  Created by Sasha Jaroshevskii on 11/9/25.
//

import ComposableArchitecture
import SwiftUI

@main
struct GhibliApp: App {
  static let store = Store(initialState: FilmsList.State()) {
    FilmsList()
  }
  
  var body: some Scene {
    WindowGroup {
      NavigationStack {
        FilmsListView(store: Self.store)
      }
    }
  }
}
