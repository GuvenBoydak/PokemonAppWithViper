//
//  HomeIntrector.swift
//  PokemonApp
//
//  Created by Güven Boydak on 3.05.2024.
//

import Foundation


final class HomeInteractor: HomeInteractorProtocol {
    
    var presenter: HomeInteractorOutput?
    var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchPokemons() {
        Task {
            var infos: [Info] = []
            do {
                let result = try await networkService.fetchData(url: NetworkConfig().baseURL, type: PokemonResult.self)
                switch result {
                case .success(let datas):
                    if let datas {
                        for data in datas.results {
                            if let info = await fetchPokemon(info: data) {
                                infos.append(info)
                            }
                        }
                        let pokemonResult = PokemonResult(count: datas.count, next: datas.next, results: infos)
                        presenter?.fetchPokemonsOutput(pokemonResult: pokemonResult,isAdditional: false)
                    }
                case .failure(_):
                    break
                }
            } catch {
                
            }
        }
    }
    
    private func fetchPokemon(info: Info) async -> Info? {
        do {
            let pokemon = try await networkService.fetchData(url: info.url, type: Pokemon.self)
            switch pokemon {
            case .success(let poke):
                return Info(name: poke?.name ?? "",
                             url: info.url,
                            imageUrl: poke?.sprites.other?.officialArtwork.frontDefault ?? "")
            case .failure(_):
                break
            }
        } catch  {
        }
        return nil
    }
    
    func fetchAdditionalPokemons(url: String) {
        Task {
            var infos: [Info] = []
            do {
                let result = try await networkService.fetchData(url: url, type: PokemonResult.self)
                switch result {
                case .success(let datas):
                    if let datas {
                        for data in datas.results {
                            if let info = await fetchPokemon(info: data) {
                                infos.append(info)
                            }
                        }
                        let pokemonResult = PokemonResult(count: datas.count, next: datas.next, results: infos)
                        presenter?.fetchPokemonsOutput(pokemonResult: pokemonResult,isAdditional: true)
                        presenter?.setIsLoadingMorePokemon(value: false)
                    }
                case .failure(_):
                    break
                }
            } catch {
            }
        }
    }
}

