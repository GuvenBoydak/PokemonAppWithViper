//
//  HomeRouter.swift
//  PokemonApp
//
//  Created by Güven Boydak on 3.05.2024.
//

import Foundation
import UIKit



final class HomeRouter: HomeRouterProtocol {
    let viewController: Viewable
    
    init(viewController: Viewable) {
        self.viewController = viewController
    }
    
   static func build() -> HomeViewController {
        let view = HomeViewController()
        let presenter = HomePresenter()
        let interactor = HomeInteractor(networkService: NetworkService.shared)
        let router = HomeRouter(viewController: view)
       
       view.presenter = presenter
       view.presenter?.view = view
       view.presenter?.viewOutput = view
       view.presenter?.interactor = interactor
       view.presenter?.router = router
       view.presenter?.interactor?.presenter = presenter
       
       return view
    }
    
    func pushToDetailPokemon(url: String) {
        DetailPokemonRouter().present(from: viewController,url: url)
    }
}


