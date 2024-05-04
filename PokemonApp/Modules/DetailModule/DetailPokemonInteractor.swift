//
//  DetailPokemonInteractor.swift
//  PokemonApp
//
//  Created by Güven Boydak on 4.05.2024.
//

import Foundation

final class DetailPokemonInteractor {
    var presenter: DetailPokemonInteractorOutput?
    var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

// MARK: - DetailPokemonInteractorProtocol
extension DetailPokemonInteractor: DetailPokemonInteractorProtocol {
    func fechPokemonDetail(url: String) {
        Task {
            do {
                let result = try await networkService.fetchData(url: url, type: Pokemon.self)
                switch result {
                case .success(let pokemon):
                    if let pokemon {
                        presenter?.fetchPokemonDetailOutput(pokemon: pokemon)
                    }
                case .failure:
                    break
                }
            } catch {
            }
        }
    }
}

