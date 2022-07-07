//
//  CatCollectionDetailViewController.swift
//  CatApp
//
//  Created by Serkan on 30.06.2022.
//

import Foundation
import UIKit


class CatCollectionDetailViewController: UIViewController, CatDetailViewModelDelegate {
    
    var detailImageView = CImageView(frame: .zero)
    
    var catNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font                                      = UIFont.systemFont(ofSize: 50, weight: .semibold)
        nameLabel.numberOfLines                             = 0
        nameLabel.textColor                                 = .label
        nameLabel.adjustsFontSizeToFitWidth                 = true
        return nameLabel
    }()
    
    
    var catTemperament: UILabel = {
        let tempeName = UILabel()
        tempeName.translatesAutoresizingMaskIntoConstraints = false
        tempeName.font                                      = UIFont.systemFont(ofSize: 18, weight: .regular)
        tempeName.textColor                                 = .label
        tempeName.numberOfLines                             = 0
        tempeName.adjustsFontSizeToFitWidth                 = true
        return tempeName
    }()
    
    var catOrigin: UILabel = {
       let originName = UILabel()
        originName.translatesAutoresizingMaskIntoConstraints = false
        originName.font                                      = UIFont.systemFont(ofSize: 15, weight: .regular)
        originName.textColor                                 = .label
        originName.numberOfLines                             = 0
        return originName
    }()
    
    var catDescription: UITextView = {
        let ctDescrip = UITextView()
        ctDescrip.translatesAutoresizingMaskIntoConstraints = false
        ctDescrip.font                                      = UIFont.systemFont(ofSize: 13, weight: .medium)
        ctDescrip.textColor                                 = .systemGray
        return ctDescrip
    }()
    
    var viewModel: CatDetailViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel.delegate = self
        viewModel.Load()
        setupUI()
    }
    
    func showDetail(_ cats: Cats) {
        detailImageView.downloadImage(from: cats.image?.imageUrl ?? "")
        catNameLabel.text = cats.name
        catTemperament.text = cats.temperament
        catOrigin.text = cats.origin
        catDescription.text = cats.description
    }
    
    func setupUI(){
        view.addSubview(detailImageView)
        view.addSubview(catNameLabel)
        view.addSubview(catTemperament)
        view.addSubview(catOrigin)
        view.addSubview(catDescription)
        detailImageView.layer.cornerRadius = 50
        
        NSLayoutConstraint.activate([
            detailImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
            detailImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
            detailImageView.heightAnchor.constraint(equalTo: view.widthAnchor, constant: -100),

            catNameLabel.topAnchor.constraint(equalTo: detailImageView.bottomAnchor, constant: 20),
            catNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            catNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            catNameLabel.heightAnchor.constraint(equalToConstant: 40),

            catTemperament.topAnchor.constraint(equalTo: catNameLabel.bottomAnchor,constant: 5),
            catTemperament.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            catTemperament.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            catTemperament.heightAnchor.constraint(equalToConstant: 50),

            catOrigin.topAnchor.constraint(equalTo: catTemperament.bottomAnchor,constant: 5),
            catOrigin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            catOrigin.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            catOrigin.heightAnchor.constraint(equalToConstant: 30),

            catDescription.topAnchor.constraint(equalTo: catOrigin.bottomAnchor,constant: 5),
            catDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            catDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            catDescription.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
        ])
        
    }
}
