//
//  DetailPokemonProtocols.swift
//  PokemonApp
//
//  Created by Güven Boydak on 4.05.2024.
//

import Foundation


// MARK: - View
protocol DetailPokemonViewProtocol {
    var presenter: DetailPokemonPresenterProtocol? { get set}
}

protocol DetailPokemonViewOutput {
    func getPokemonDetail(pokemon: Pokemon)
}

// MARK: - Presenter
protocol DetailPokemonPresenterProtocol {
    var view: DetailPokemonViewOutput? { get set }
    var interactor: DetailPokemonInteractorProtocol? { get set }
    
    func fechPokemonDetail(url: String)
}

// MARK: - Interactor
protocol DetailPokemonInteractorProtocol {
    var presenter: DetailPokemonInteractorOutput? { get set }
    var networkService: NetworkServiceProtocol { get set}
    
    func fechPokemonDetail(url: String)
}

protocol DetailPokemonInteractorOutput {
    func fetchPokemonDetailOutput(pokemon: Pokemon)
}

// MARK: - Router
protocol DetailPokemonRouterProtocol {
   static func build() -> DetailPokemonViewController
   func present(from: Viewable,url: String)
}

