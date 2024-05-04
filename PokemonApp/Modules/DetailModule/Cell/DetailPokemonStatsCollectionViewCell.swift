//
//  DetailPokemonStatsCollectionViewCell.swift
//  PokemonApp
//
//  Created by Güven Boydak on 4.05.2024.
//

import UIKit

final class DetailPokemonStatsCollectionViewCell: UICollectionViewCell {
    static let identifier = "DetailPokemonStatsCollectionViewCell"
    
    // MARK: - UIElements
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    private let pointLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    // MARK: - Properties
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Helpers
extension DetailPokemonStatsCollectionViewCell {
    private func setup() {
        addConstraint()
    }
    private func addConstraint() {
        addSubview(nameLabel)
        addSubview(pointLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.center.equalTo(snp.center).offset(-8)
        }
        pointLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.centerX.equalTo(nameLabel.snp.centerX)
        }
    }
    func configure(name: String,point: Int) {
        nameLabel.text = name.uppercased()
        pointLabel.text = String(point)
        pointLabel.textColor = randomColor()
    }
    
    private func randomColor() -> UIColor {
           let red = CGFloat.random(in: 0...1)
           let green = CGFloat.random(in: 0...1)
           let blue = CGFloat.random(in: 0...1)
           
           return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
       }
}
