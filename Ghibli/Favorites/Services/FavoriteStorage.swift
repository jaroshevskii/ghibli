//
//  FavoriteStorage.swift
//  Ghibli
//
//  Created by Sasha Jaroshevskii on 11/7/25.
//

import Foundation

protocol FavoriteStorage {
    func load() -> Set<String>
    func save(favoriteIDs: Set<String>)
}
