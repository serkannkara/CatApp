//
//  CatFavoiteDetailViewController.swift
//  CatApp
//
//  Created by Serkan on 20.04.2022.
//

import UIKit
import SafariServices



class CatFavoriteDetailViewController: UIViewController {

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
        ctDescrip.font                                      = UIFont.systemFont(ofSize: 15, weight: .medium)
        ctDescrip.textColor                                 = .systemGray
        return ctDescrip
    }()
    
    var learnMoreButton: UIButton = {
       let lrnButton = UIButton()
        lrnButton.translatesAutoresizingMaskIntoConstraints = false
        lrnButton.layer.shadowRadius                        = 5
        lrnButton.layer.shadowColor                         = UIColor.systemGray.cgColor
        lrnButton.layer.shadowOpacity                       = 0.5
        lrnButton.layer.cornerRadius                        = 10
        lrnButton.layer.borderWidth                         = 1
        lrnButton.layer.borderColor                         = UIColor.systemGray5.cgColor
        lrnButton.backgroundColor                           = .systemPink
        lrnButton.setTitle("Learn More About Cat", for: .normal)
        lrnButton.setTitleColor(.white, for: .normal)
        lrnButton.addTarget(self, action: #selector(learnMoreButtonTapped), for: .touchUpInside)
        return lrnButton
    }()
    
    init(cat: CatsItem){
        super.init(nibName: nil, bundle: nil)
        self.cat = cat
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var cat: CatsItem!
    var indexPath: IndexPath?
    
    weak var safariDelegate: FavoriteSafariServiceDelegateProtocol?
    weak var favoriteDelegate: CatFavoriteProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureImageView()
        configureNameLabel()
        configureCatTemperament()
        configureOrigin()
        configureCatDescription()
        configureLearnMoreButton()
        configureNavigationBar()
    }
    // Configuration Navigation Bar
    private func configureNavigationBar(){
        let deleteNavButton = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .done, target: self, action: #selector(deleteNavButtonTapped))
        title                                                   = "About Cat"
        navigationController?.navigationBar.prefersLargeTitles  = true
        deleteNavButton.tintColor                               = .systemRed
        navigationItem.rightBarButtonItem                       = deleteNavButton
    }
    
    func configureImageView(){
        view.addSubview(detailImageView)
        detailImageView.layer.cornerRadius = 50
        
        NSLayoutConstraint.activate([
            detailImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
            detailImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
            detailImageView.heightAnchor.constraint(equalTo: view.widthAnchor, constant: -100)
        ])
    }
    
    func configureNameLabel(){
        view.addSubview(catNameLabel)
        
        NSLayoutConstraint.activate([
            catNameLabel.topAnchor.constraint(equalTo: detailImageView.bottomAnchor, constant: 20),
            catNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            catNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            catNameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureCatTemperament(){
        view.addSubview(catTemperament)
        
        NSLayoutConstraint.activate([
            catTemperament.topAnchor.constraint(equalTo: catNameLabel.bottomAnchor,constant: 5),
            catTemperament.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            catTemperament.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            catTemperament.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureOrigin() {
        view.addSubview(catOrigin)
        
        NSLayoutConstraint.activate([
            catOrigin.topAnchor.constraint(equalTo: catTemperament.bottomAnchor,constant: 5),
            catOrigin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            catOrigin.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            catOrigin.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    
    func configureCatDescription(){
        view.addSubview(catDescription)
        
        NSLayoutConstraint.activate([
            catDescription.topAnchor.constraint(equalTo: catOrigin.bottomAnchor,constant: 5),
            catDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            catDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            catDescription.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
        ])
    }
    
    func configureLearnMoreButton(){
        view.addSubview(learnMoreButton)
        
        NSLayoutConstraint.activate([
            learnMoreButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10),
            learnMoreButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            learnMoreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            learnMoreButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// Delete Detail and Safari Protocol
extension CatFavoriteDetailViewController {
    
    @objc func deleteNavButtonTapped() {
        favoriteDelegate?.clickDeleteCatFavoriteDetail(indextPath: indexPath!)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func learnMoreButtonTapped() {
        safariDelegate?.goFavoriteLearnAboutCat(for: cat)
    }
}
