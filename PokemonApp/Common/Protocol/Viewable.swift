//
//  Viewable.swift
//  PokemonApp
//
//  Created by Güven Boydak on 4.05.2024.
//

import Foundation
import UIKit


protocol Viewable {
    func present(_ viewController: UIViewController)
    func dismiss()
}

extension Viewable where Self: UIViewController {
    func present(_ viewController: UIViewController) {
        self.present(viewController, animated: true)
    }

    func dismiss() {
        self.dismiss()
    }
}
