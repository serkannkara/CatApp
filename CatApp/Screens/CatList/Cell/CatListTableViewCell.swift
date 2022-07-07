//
//  CatListTableViewCell.swift
//  CatApp
//
//  Created by Serkan on 18.04.2022.
//

import UIKit


class CatListTableViewCell: UITableViewCell {
    
    static let reuseIdList  = "catListCell"
    var catImageView        = CImageView(frame: .zero)
    
    var catNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font                                      = UIFont.systemFont(ofSize: 20, weight: .semibold)
        nameLabel.numberOfLines                             = 0
        nameLabel.textColor                                 = .label
        nameLabel.adjustsFontSizeToFitWidth                 = true
        return nameLabel
    }()
    
    var addButton: UIButton = {
        let adButton = UIButton(type: .system)
        adButton.translatesAutoresizingMaskIntoConstraints  = false
        adButton.tintColor                                  = .systemYellow
        adButton.setImage(UIImage(named: "star"), for: .normal)
        adButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        adButton.buttonAnimate()
        return adButton
    }()
    
    weak var delegate: TableViewCellAddProtocol?
    var indexPath: IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(cats: Cats){
        catImageView.downloadImage(from: cats.image?.imageUrl ?? "")
        catNameLabel.text = cats.name
        configure()
    }
    
    private func configure() {
        addSubview(catImageView)
        addSubview(catNameLabel)
        contentView.addSubview(addButton)
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            catImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            catImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding*2),
            catImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            catImageView.widthAnchor.constraint(equalTo: catImageView.heightAnchor),
            
            catNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            catNameLabel.leadingAnchor.constraint(equalTo: catImageView.trailingAnchor, constant: padding),
            catNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            catNameLabel.heightAnchor.constraint(equalToConstant: padding*4),
            
            addButton.topAnchor.constraint(equalTo: topAnchor, constant: padding*4),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding*4),
            addButton.widthAnchor.constraint(equalTo: addButton.heightAnchor),
        ])
    }
}

extension CatListTableViewCell {
    @objc func addButtonTapped(_ sender: Any) {
        delegate?.onCellAdd(indexPath: indexPath!)
    }
}
