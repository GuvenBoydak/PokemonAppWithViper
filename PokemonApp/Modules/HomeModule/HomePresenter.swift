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
    var shouldShowLoadMoreIndicator: Bool = false
    var isLoadingMorePokemon: Bool = false
    
    func fetchPokemons() {
         interactor?.fetchPokemons()
    }
    
    func fetchAdditionalPokemons(url: String) {
        guard !isLoadingMorePokemon else { return }
        isLoadingMorePokemon = true
        
        interactor?.fetchAdditionalPokemons(url: url)

    }
}
// MARK: - HomeInteractorOutput
extension HomePresenter: HomeInteractorOutput {   
    func setIsLoadingMorePokemon(value: Bool) {
        isLoadingMorePokemon = value
    }
    
    func fetchPokemonsOutput(pokemonResult: PokemonResult,isAdditional: Bool) {
        if pokemonResult.results.isEmpty {
            view?.showIndicator()
        }
        shouldShowLoadMoreIndicator = pokemonResult.next != ""
        view?.closeIndicator()      
        
        viewOutput?.showPokemons(pokemonResult: pokemonResult,isAdditional: isAdditional)
    }
}
