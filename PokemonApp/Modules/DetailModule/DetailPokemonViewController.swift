//
//  DetailPokemonViewController.swift
//  PokemonApp
//
//  Created by Güven Boydak on 4.05.2024.
//

import UIKit

final class DetailPokemonViewController: UIViewController,Viewable {
    // MARK: - UIElements
    private var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.tertiarySystemFill.cgColor
        image.layer.cornerRadius = 10
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    private let statTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Stats"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DetailPokemonStatsCollectionViewCell.self, forCellWithReuseIdentifier: DetailPokemonStatsCollectionViewCell.identifier)
        collectionView.backgroundColor = .tertiarySystemBackground
        return collectionView
    }()
    
    // MARK: - Properties
    var presenter: DetailPokemonPresenterProtocol?
    var pokemon: Pokemon?
    var url: String?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        if let url  {
           presenter?.fechPokemonDetail(url: url)
        }
        setup()
    }
}
// MARK: - Helpers
extension DetailPokemonViewController {
    private func setup() {
        addContraint()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    private func addContraint() {
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(typeLabel)
        view.addSubview(statTitleLabel)
        view.addSubview(collectionView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(4)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.centerX.equalTo(view.snp.centerX)
        }
        typeLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.centerX.equalTo(view.snp.centerX)
        }
        statTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(typeLabel.snp.bottom).offset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(8)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(statTitleLabel.snp.bottom)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(8)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-8)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    func configure() {
        if let pokemon {
            guard let url = URL(string: pokemon.sprites.other?.officialArtwork.frontDefault ?? "") else {
                return
            }
            URLSession.shared.dataTask(with: url ) { (data, response, error) in
                guard let data = data, let image = UIImage(data: data) else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }.resume()
            nameLabel.text = pokemon.name.uppercased()
            let types = pokemon.types.map { $0.type.name }
            typeLabel.text = "TYPE: \(types)"
        }
    }
}
// MARK: - DetailPokemonViewProtocol,DetailPokemonViewOutput
extension DetailPokemonViewController: DetailPokemonViewProtocol,DetailPokemonViewOutput {
    func getPokemonDetail(pokemon: Pokemon) {
        DispatchQueue.main.async {
           self.pokemon = pokemon
            self.configure()
            self.collectionView.reloadData()
        }
    }
}
// MARK: - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
extension DetailPokemonViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pokemon?.stats.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailPokemonStatsCollectionViewCell.identifier, for: indexPath) as! DetailPokemonStatsCollectionViewCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.tertiarySystemFill.cgColor
        cell.layer.cornerRadius = 10
        let stat = pokemon?.stats[indexPath.item]
        cell.configure(name: stat?.stat.name ?? "", point: stat?.baseStat ?? 0)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widths = (collectionView.frame.width - 20) / 2
        return .init(width: widths, height: 65)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 5, left: 5, bottom: 5, right: 5)
    }
}

