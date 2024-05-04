//
//  DetailPokemonRouter.swift
//  PokemonApp
//
//  Created by Güven Boydak on 4.05.2024.
//

import Foundation
import UIKit

final class DetailPokemonRouter {
}

// MARK: - DetailPokemonRouterProtocol
extension DetailPokemonRouter: DetailPokemonRouterProtocol {
    static func build() -> DetailPokemonViewController {
        let view = DetailPokemonViewController()
        let presenter = DetailPokemonPresenter()
        let interactor = DetailPokemonInteractor(networkService: NetworkService.shared)
        
        view.presenter = presenter
        view.presenter?.view = view
        view.presenter?.interactor = interactor
        view.presenter?.interactor?.presenter = presenter
        
        return view
    }
    
    func present(from: Viewable,url: String) {
        let detailPokemonVC = DetailPokemonRouter.build()
        detailPokemonVC.url = url
        let navigationController = UINavigationController(rootViewController: detailPokemonVC)
        from.present(navigationController)
    }
}
