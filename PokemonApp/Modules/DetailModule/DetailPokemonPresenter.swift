//
//  DetailPokemonPresenter.swift
//  PokemonApp
//
//  Created by Güven Boydak on 4.05.2024.
//

import Foundation

final class DetailPokemonPresenter {
    var view: DetailPokemonViewOutput?
    var interactor: DetailPokemonInteractorProtocol?
    
}

// MARK: - DetailPokemonPresenterProtocol
extension DetailPokemonPresenter: DetailPokemonPresenterProtocol {   
    func fechPokemonDetail(url: String) {
        interactor?.fechPokemonDetail(url: url)
    }
}

// MARK: - DetailPokemonInteractorOutput
extension DetailPokemonPresenter: DetailPokemonInteractorOutput {
    func fetchPokemonDetailOutput(pokemon: Pokemon) {
        view?.getPokemonDetail(pokemon: pokemon)
    }
}

