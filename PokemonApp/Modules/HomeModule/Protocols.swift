//
//  Protocols.swift
//  PokemonApp
//
//  Created by Güven Boydak on 3.05.2024.
//

import Foundation

// MARK: - View
protocol HomeViewProtocol {
    var presenter: HomePresenterProtocol? {get set}
    
    func showIndicator()
    func closeIndicator()
}

protocol HomeViewOutput {
    func showPokemons(pokemonResult: PokemonResult,isAdditional: Bool)
}

// MARK: - Presenter
protocol HomePresenterProtocol {
    var view: HomeViewProtocol? { get set }
    var viewOutput: HomeViewOutput? { get set }
    var interactor: HomeInteractorProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
    var shouldShowLoadMoreIndicator: Bool { get set }
    var isLoadingMorePokemon: Bool { get set }
    
    func fetchPokemons() 
    func fetchAdditionalPokemons(url: String)
    func didSelectPokemon(url: String)
}

// MARK: - Interactor
protocol HomeInteractorProtocol {
    var presenter: HomeInteractorOutput? { get set }
    var networkService: NetworkServiceProtocol { get set}
    
    func fetchPokemons()
    func fetchAdditionalPokemons(url: String)
}

protocol HomeInteractorOutput {
    func fetchPokemonsOutput(pokemonResult: PokemonResult,isAdditional: Bool)
    func setIsLoadingMorePokemon(value: Bool)
}

// MARK: - Router
protocol HomeRouterProtocol {
   static func build() -> HomeViewController
   func pushToDetailPokemon(url: String)
}
