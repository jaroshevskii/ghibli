//
//  FilmsList.swift
//  Ghibli
//
//  Created by Sasha Jaroshevskii on 11/9/25.
//

import ComposableArchitecture
import SwiftUI
import NukeUI

@Reducer
struct FilmsList {
  @ObservableState
  struct State: Equatable {
    @Shared(.films) var films: IdentifiedArrayOf<Film>
    @Shared(.favoritesIDs) var favorites: Set<Film.ID>
  }
  
  enum Action {
    case task
    case filmsResponse(Result<IdentifiedArrayOf<Film>, any Error>)
    case toggleFavorite(Film.ID)
  }
  
  @Dependency(\.ghibli) var ghibli
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .task:
        return .run { send in
          await send(.filmsResponse(Result { try await ghibli.films() }))
        }
        
      case let .filmsResponse(.success(films)):
        state.$films.withLock { $0 = films }
        return .none
      
      case .filmsResponse:
        return .none
        
      case let .toggleFavorite(filmID):
        state.$favorites.withLock {
          if $0.contains(filmID) {
            $0.remove(filmID)
          } else {
            $0.insert(filmID)
          }
        }
        return .none
      }
    }
  }
}

struct FilmsListView: View {
  let store: StoreOf<FilmsList>
  
  var body: some View {
    List(store.films) { film in
      NavigationLink(state: Films.Path.State.detail) {
        FilmCardView(
          film: film,
          isFavorite: store.favorites.contains(film.id),
          onToggleFavorite: { store.send(.toggleFavorite(film.id)) }
        )
      }
    }
    .task { await store.send(.task).finish() }
    .navigationTitle("Ghibli Films")
  }
}

#Preview {
  NavigationStack {
    FilmsListView(
      store: Store(initialState: FilmsList.State()) {
        FilmsList()
      }
    )
  }
}

fileprivate struct FilmCardView: View {
  let film: Film
  let isFavorite: Bool
  let onToggleFavorite: () -> Void
  
  var body: some View {
    HStack(alignment: .top) {
      FilmImageView(imageURL: film.imageURL)
        .frame(width: 100, height: 150)
      
      VStack(alignment: .leading) {
        HStack {
          Text(film.title)
            .bold()
          
          Spacer()
          
          Button {
            onToggleFavorite()
          } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
              .foregroundStyle(isFavorite ? .pink : .gray)
          }
          .buttonStyle(.plain)
        }
        .padding(.bottom, 4)
        
        Text("Directed by \(film.director)")
          .font(.subheadline)
          .foregroundColor(.secondary)
        
        Text("Released \(film.releaseDate)")
          .font(.caption)
          .foregroundColor(.secondary)
      }
      .padding(.vertical)
    }
  }
}

fileprivate struct FilmImageView: View {
  let imageURL: URL?
  
  var body: some View {
    LazyImage(url: imageURL, transaction: Transaction(animation: .default)) { state in
      if let image = state.image {
        image.resizable()
      } else {
        Color.gray
      }
    }
  }
}

extension SharedReaderKey where Self == InMemoryKey<IdentifiedArrayOf<Film>>.Default {
  static var films: Self {
    Self[.inMemory("Films"), default: []]
  }
}

extension SharedReaderKey where Self == AppStorageKey<Set<Film.ID>>.Default {
  static var favoritesIDs: Self {
    Self[.appStorage("FavoritesIDs"), default: []]
  }
}
