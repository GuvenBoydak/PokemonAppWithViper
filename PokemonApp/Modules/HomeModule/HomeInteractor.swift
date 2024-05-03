//
//  HomeIntrector.swift
//  PokemonApp
//
//  Created by Güven Boydak on 3.05.2024.
//

import Foundation


final class HomeInteractor: HomeInteractorProtocol {
    var presenter: HomeInteractorOutput?
    
    func fetchPokemons() {
            self.presenter?.fetchPokemonsOutput(pokemons: ["a","b","c","d","f","d","s","i","c"])
    }
}

