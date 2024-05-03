//
//  HomeViewController.swift
//  PokemonApp
//
//  Created by Güven Boydak on 3.05.2024.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {
    // MARK: - UIElements
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    private var indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        return indicator
    }()
    
    // MARK: - Properties
    var pokemons: [String] = []
    var presenter: HomePresenterProtocol?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
        presenter?.fetchPokemons()
    }
}

// MARK: - Helper
extension HomeViewController {
    private func setup() {
        addConstraint()
    }
    private func addConstraint() {
        view.addSubview(collectionView)
        view.addSubview(indicatorView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        indicatorView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
    }
}
// MARK: - HomeViewInput
extension HomeViewController: HomeViewProtocol {
    func showIndicator() {
        indicatorView.startAnimating()
    }
    
    func closeIndicator() {
        indicatorView.stopAnimating()
    }
}
// MARK: - HomeViewOutput
extension HomeViewController: HomeViewOutput {
    func showPokemons(pokemons: [String]) {
        self.pokemons = pokemons
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pokemons.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widths = (collectionView.frame.width - 20) / 2
        return .init(width: widths, height: widths * 1.2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 5, left: 5, bottom: 5, right: 5)
    }
}
