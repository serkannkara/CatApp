//
//  CatFavoriteTableViewCell.swift
//  CatApp
//
//  Created by Serkan on 18.04.2022.
//

import UIKit



class CatFavoriteTableViewCell: UITableViewCell {

    static let reuseIdFavorite  = "favoriteListCell"
    
    var favoriteImageView       = CImageView(frame: .zero)
    
    var favoriteNameLabel: UILabel = {
        var nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font                                      = UIFont.systemFont(ofSize: 20, weight: .semibold)
        nameLabel.numberOfLines                             = 0
        nameLabel.textColor                                 = .label
        nameLabel.adjustsFontSizeToFitWidth                 = true
        return nameLabel
    }()
    
    var deleteButton: UIButton = {
        let dButton = UIButton(type: .system)
        dButton.translatesAutoresizingMaskIntoConstraints   = false
        dButton.tintColor                                   = .systemRed
        dButton.setImage(UIImage(named: "star"), for: .normal)
        dButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        dButton.buttonAnimate()
        return dButton
    }()
    
    weak var delegate: TableViewCellDeleteProtocol?
    var indexPath: IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCats()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(cats: CatsItem){
        favoriteImageView.downloadImage(from: cats.imageUrl ?? "")
        favoriteNameLabel.text = cats.name
        configureCats()
    }
    
    
    private func configureCats() {
        addSubview(favoriteImageView)
        addSubview(favoriteNameLabel)        
        contentView.addSubview(deleteButton)
                
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            favoriteImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            favoriteImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding*2),
            favoriteImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            favoriteImageView.widthAnchor.constraint(equalTo: favoriteImageView.heightAnchor),
            
            favoriteNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            favoriteNameLabel.leadingAnchor.constraint(equalTo: favoriteImageView.trailingAnchor, constant: padding),
            favoriteNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            favoriteNameLabel.heightAnchor.constraint(equalToConstant: padding*4),
            
            deleteButton.topAnchor.constraint(equalTo: topAnchor, constant: padding*4),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            deleteButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding*4),
            deleteButton.widthAnchor.constraint(equalTo: deleteButton.heightAnchor),
        ])
    }
}

extension CatFavoriteTableViewCell {
    @objc func deleteButtonTapped(_ sender: Any) {
        delegate?.onCellDelete(indexPath: indexPath!)
    }
}
