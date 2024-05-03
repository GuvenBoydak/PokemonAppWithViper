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
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        collectionView.backgroundColor = .tertiarySystemBackground
        return collectionView
    }()
    private var indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        return indicator
    }()
    
    // MARK: - Properties
    var pokemonResult: PokemonResult?
    var presenter: HomePresenterProtocol?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter?.fetchPokemons()
    }
}

// MARK: - Helper
extension HomeViewController {
    private func setup() {
        addConstraint()
        view.backgroundColor = .systemBackground
        title = "Pokemons"
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
        DispatchQueue.main.async {
            self.indicatorView.stopAnimating()
        }
    }
}
// MARK: - HomeViewOutput
extension HomeViewController: HomeViewOutput {
    func showPokemons(pokemonResult: PokemonResult,isAdditional: Bool) {
        if !isAdditional {
            self.pokemonResult = pokemonResult
        }
                
        var results = self.pokemonResult?.results
        results?.append(contentsOf: pokemonResult.results)
        let newPokeResult = PokemonResult(count: pokemonResult.count, next: pokemonResult.next, results: results ?? [] )
        self.pokemonResult = newPokeResult
        

        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pokemonResult?.results.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
        if let info = pokemonResult?.results[indexPath.row] {
            cell.configure(info: info)
        }
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.tertiarySystemFill.cgColor
        cell.layer.cornerRadius = 10
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widths = (collectionView.frame.width - 20) / 2
        return .init(width: widths, height: widths * 1.2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 5, left: 5, bottom: 5, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard presenter?.shouldShowLoadMoreIndicator ?? false else {
            return .zero
        }
        return .init(width: collectionView.frame.width, height: 100)
    }}

// MARK: - UIScrollViewDelegate
extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard let shouldShowLoadMoreIndicator = presenter?.shouldShowLoadMoreIndicator,
              shouldShowLoadMoreIndicator,
              let isLoading = presenter?.isLoadingMorePokemon,
              !isLoading else {
            return
        }

        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] timer in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                self?.presenter?.fetchAdditionalPokemons(url: self?.pokemonResult?.next ?? "")
            }
            timer.invalidate()
        }
    }
}
