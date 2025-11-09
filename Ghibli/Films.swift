//
//  Films.swift
//  Ghibli
//
//  Created by Sasha Jaroshevskii on 11/9/25.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct Films {
  @ObservableState
  struct State: Equatable {
    var path = StackState<Path.State>()
    var filmsList = FilmsList.State()
  }
  
  @Reducer
  enum Path {
    case detail
  }
  
  enum Action {
    case filmsList(FilmsList.Action)
    case path(StackActionOf<Path>)
  }
  
  var body: some ReducerOf<Self> {
    Scope(state: \.filmsList, action: \.filmsList) {
      FilmsList()
    }
    Reduce { state, action in
      switch action {
      case .filmsList:
        return .none
        
      case .path:
        return .none
      }
    }
    .forEach(\.path, action: \.path)
  }
}

struct FilmsView: View {
  @Bindable var store: StoreOf<Films>
  
  var body: some View {
    NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
      FilmsListView(store: store.scope(state: \.filmsList, action: \.filmsList))
    } destination: { store in
      switch store.case {
      case .detail:
        EmptyView()
      }
    }
  }
}

#Preview {
  @Shared(.films) var films = Film.mocks
  FilmsView(
    store: Store( initialState: Films.State()) {
      Films()
    }
  )
}
