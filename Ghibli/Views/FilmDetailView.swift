//
//  FilmDetailView.swift
//  Ghibli
//
//  Created by Sasha Jaroshevskii on 11/6/25.
//

import SwiftUI

struct FilmDetailView: View {
  let film: Film
  
  @State private var viewModel = FilmDetailViewModel()
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {
        FilmImageView(urlPath: film.bannerImage)
          
        Text(film.title)
        Divider()
        Text("Characters")
          .font(.title3)
        
        switch viewModel.state {
        case .idle:
          EmptyView()
          
        case .loading:
          ProgressView {
            Text("Loading...")
          }
          
        case let .loaded(people):
          ForEach(people) { person in
            Text(person.name)
          }
          
        case let .error(error):
          Text(error)
            .foregroundStyle(.pink)
        }
      }
      .padding()
      .task { await viewModel.fetch(for: film) }
    }
  }
}

#Preview {
  FilmDetailView(film: .mock)
}
