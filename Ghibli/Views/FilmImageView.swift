//
//  FilmImageView.swift
//  Ghibli
//
//  Created by Sasha Jaroshevskii on 11/6/25.
//

import SwiftUI

struct FilmImageView: View {
  private let imageURL: URL?
  
  init(urlPath: String) {
    self.imageURL = URL(string: urlPath)
  }
  
  init(url: URL?) {
    self.imageURL = url
  }
  
  var body: some View {
    AsyncImage(url: imageURL) { phase in
      switch phase {
      case .empty:
        Color(white: 0.8)
          .overlay {
            ProgressView()
          }
      case let .success(image):
        image
          .resizable()
          .scaledToFill()
      case .failure:
        Text("Could not get image")
      @unknown default:
        EmptyView()
      }
    }
  }
}

#Preview("Poster") {
  let url = AssetExtractor.createLocalUrl(forImageNamed: "FilmPoster")
  FilmImageView(url: url)
    .frame(height: 150)
}

#Preview("Banner") {
  let url = AssetExtractor.createLocalUrl(forImageNamed: "FilmBanner")
  FilmImageView(url: url)
    .frame(height: 200)
}
