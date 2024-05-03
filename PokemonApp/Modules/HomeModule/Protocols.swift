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
    func showPokemons(pokemonResult: PokemonResult)
}

// MARK: - Presenter
protocol HomePresenterProtocol {
    var view: HomeViewProtocol? { get set }
    var viewOutput: HomeViewOutput? { get set }
    var interactor: HomeInteractorProtocol? { get set }
    
    func fetchPokemons() 
}

// MARK: - Interactor
protocol HomeInteractorProtocol {
    var presenter: HomeInteractorOutput? { get set }
    var networkService: NetworkServiceProtocol { get set}
    
    func fetchPokemons()
}

protocol HomeInteractorOutput {
    func fetchPokemonsOutput(pokemonResult: PokemonResult)
}

// MARK: - Router
protocol HomeRouterProtocol {
   static func build() -> HomeViewController
}
