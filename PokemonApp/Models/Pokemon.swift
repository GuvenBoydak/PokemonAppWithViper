//
//  Pokemon.swift
//  PokemonApp
//
//  Created by Güven Boydak on 3.05.2024.
//

import Foundation

// MARK: - Pokemon
struct Pokemon: Codable {
    let id: Int
    let name: String
    let sprites: Sprites
    let stats: [Stat]
    let types: [TypeElement]
}

class Sprites: Codable {
    let other: Other?
}

struct Other: Codable {
    let officialArtwork: OfficialArtwork

    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}
struct OfficialArtwork: Codable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
struct Stat: Codable {
    let baseStat: Int
    let stat: StatClass

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
}
struct TypeElement: Codable {
    let slot: Int
    let type: StatClass
}
struct StatClass: Codable {
    let name: String
    let url: String
}
