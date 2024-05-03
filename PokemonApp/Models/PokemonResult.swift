//
//  PokemonResult.swift
//  PokemonApp
//
//  Created by Güven Boydak on 3.05.2024.
//

import Foundation

struct PokemonResult: Codable {
    let count: Int
    let next: String
    let results: [Info]
}

// MARK: - Result
struct Info: Codable {
    let name: String
    let url: String
}
