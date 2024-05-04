//
//  NetworkConfig.swift
//  PokemonApp
//
//  Created by Güven Boydak on 3.05.2024.
//

import Foundation

struct NetworkConfig {
    var baseURL = "https://pokeapi.co/api/v2/pokemon"
}

enum NetworkError: Error {
    case UrlError
    case DecoderError
}
