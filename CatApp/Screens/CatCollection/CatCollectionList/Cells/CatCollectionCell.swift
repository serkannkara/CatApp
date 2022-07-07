//
//  CatCollectionCell.swift
//  CatApp
//
//  Created by Serkan on 30.06.2022.
//

import Foundation
import UIKit


class CatCollectionCell: UICollectionViewCell {
    
    var cats: Cats! {
        didSet {
            catImageView.downloadImage(from: cats?.image?.imageUrl ?? "")
            catNameLabel.text = cats?.name
            catDescriptionLabel.text = cats?.description
        }
    }
    
    var catImageView = CImageView(frame: .zero)
    
    var catNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font                                      = UIFont.systemFont(ofSize: 20, weight: .semibold)
        nameLabel.numberOfLines                             = 1
        nameLabel.textColor                                 = .label
        nameLabel.adjustsFontSizeToFitWidth                 = true
        return nameLabel
    }()
    
    var catDescriptionLabel: UILabel = {
        let dcLabel = UILabel()
        dcLabel.translatesAutoresizingMaskIntoConstraints = false
        dcLabel.font                                      = UIFont.systemFont(ofSize: 15, weight: .regular)
        dcLabel.numberOfLines                             = 0
        dcLabel.textColor                                 = .label
        return dcLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 16
        layer.borderWidth = 0.7
        layer.borderColor = UIColor.systemGray3.cgColor
        
        setupUI()
    }
    
    private func setupUI() {
        catImageView.heightAnchor.constraint(equalToConstant: 180).isActive = true

        let hStackView = UIStackView(arrangedSubviews: [
            catImageView, catNameLabel, catDescriptionLabel
        ])

        hStackView.spacing = 10
        hStackView.axis = .vertical
        hStackView.alignment = .leading
        addSubview(hStackView)
        hStackView.fillSuperview(padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
