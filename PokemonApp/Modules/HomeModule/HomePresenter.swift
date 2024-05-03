//
//  HomePresenter.swift
//  PokemonApp
//
//  Created by Güven Boydak on 3.05.2024.
//

import Foundation

final class HomePresenter: HomePresenterProtocol {
    var view: HomeViewProtocol?
    var viewOutput: HomeViewOutput?
    var interactor: HomeInteractorProtocol?
    
    func fetchPokemons() {
        interactor?.fetchPokemons()
    }
}
// MARK: - HomeInteractorOutput
extension HomePresenter: HomeInteractorOutput {
    func fetchPokemonsOutput(pokemons: [String]) {
        if pokemons.isEmpty {
            view?.showIndicator()
        }
        view?.closeIndicator()
        viewOutput?.showPokemons(pokemons: pokemons)
    }
}
