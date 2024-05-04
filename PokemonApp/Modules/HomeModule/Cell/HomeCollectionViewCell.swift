//
//  HomeCollectionViewCell.swift
//  PokemonApp
//
//  Created by Güven Boydak on 3.05.2024.
//

import UIKit

final class HomeCollectionViewCell: UICollectionViewCell {
    static let identifier = "HomeCollectionViewCell"
    
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
extension HomeCollectionViewCell {
    private func setup() {
        addConsraint()
    }
    private func addConsraint() {
        addSubview(imageView)
        addSubview(nameLabel)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(frame.width)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.centerX.equalTo(imageView.snp.centerX)
        }
    }
    func configure(info: Info) {
        guard let url = URL(string: info.imageUrl ?? "") else {
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
        
        nameLabel.text = info.name.uppercased()
    }
}
