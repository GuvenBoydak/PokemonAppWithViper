//
//  HomeRouter.swift
//  PokemonApp
//
//  Created by Güven Boydak on 3.05.2024.
//

import Foundation



final class HomeRouter: HomeRouterProtocol {
   static func build() -> HomeViewController {
        let view = HomeViewController()
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
       
       view.presenter = presenter
       view.presenter?.view = view
       view.presenter?.viewOutput = view
       view.presenter?.interactor = interactor
       view.presenter?.interactor?.presenter = presenter
       
       return view
    }
}
