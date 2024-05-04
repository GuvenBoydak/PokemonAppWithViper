//
//  NetworkService.swift
//  PokemonApp
//
//  Created by Güven Boydak on 3.05.2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData<T: Codable>(url: String,type: T.Type) async throws -> Result<T?, Error>
}

struct NetworkService: NetworkServiceProtocol {
    static var shared = NetworkService()
    
    func fetchData<T: Codable>(url: String,type: T.Type) async throws -> Result<T?, Error> {
        guard let url = URL(string: url) else {
            print(NetworkError.UrlError)
            return .failure(NetworkError.UrlError)
        }
        do {
            let response = try await URLSession.shared.data(from: url)
            let data = try JSONDecoder().decode(T.self, from: response.0)
            return .success(data)
        } catch {
            print(NetworkError.DecoderError)
            return .failure(NetworkError.DecoderError)
        }
    }
}
