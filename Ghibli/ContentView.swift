//
//  ContentView.swift
//  Ghibli
//
//  Created by Sasha Jaroshevskii on 10/29/25.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      Tab("Movies", systemImage: "movieclapper") {
        FilmsView()
      }
      Tab("Favorites", systemImage: "heart") {
        FavoritesView()
      }
      Tab("Settings", systemImage: "gear") {
        SettingsView()
      }
    }
  }
}

#Preview {
  ContentView()
}

