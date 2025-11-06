//
//  FilmListView.swift
//  Ghibli
//
//  Created by Sasha Jaroshevskii on 10/29/25.
//

import SwiftUI

struct FilmListView: View {
  var filmsViewModel = FilmsViewModel()
  
  var body: some View {
    NavigationStack {
      switch filmsViewModel.state {
      case .idle:
        Text("No films yer")
      case .loading:
        ProgressView {
          Text("Loading...")
        }
      case let .loaded(films):
        List(films) { film in
          NavigationLink(value: film) {
            HStack {
              FilmImageView(urlPath: film.image)
                .frame(width: 100, height: 150)
              Text(film.title)
            }
          }
        }
        .navigationDestination(for: Film.self) { film in
          FilmDetailView(film: film)
        }
      case let .error(error):
        Text(error)
          .foregroundStyle(.pink)
      }
    }
    .task { await filmsViewModel.fetch() }
  }
}

#Preview {
  @State @Previewable var vm = FilmsViewModel(
    service: MockGhibliService()
  )
  
  FilmListView(filmsViewModel: vm)
}
