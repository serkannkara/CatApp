//
//  CatFavoriteViewController.swift
//  CatApp
//
//  Created by Serkan on 18.04.2022.
//

import UIKit
import SafariServices
import CoreData

class CatFavoriteViewController: UIViewController {
    
    let favoriteTableView: UITableView = {
        let fTableView = UITableView()
        fTableView.translatesAutoresizingMaskIntoConstraints = false
        fTableView.rowHeight                                 = 120
        fTableView.register(CatFavoriteTableViewCell.self, forCellReuseIdentifier: CatFavoriteTableViewCell.reuseIdFavorite)
        return fTableView
    }()
    
    var favorites           = [CatsItem]()
    private let indicator   = UIActivityIndicatorView()
    
    private lazy var viewModel: CatFavoriteViewModelProtocol = CatFavoriteViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel.setDelegate(output: self)
        configureNavigationController()
        configureFavoriteTableView()
        Notify()
        fetchLocalStorageForDownlaod()
    }
    
    private func configureNavigationController() {
        title                                                   = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles  = true
    }
    // Configuration TableView
    func configureFavoriteTableView(){
        view.addSubview(favoriteTableView)
        favoriteTableView.delegate      = self
        favoriteTableView.dataSource    = self
        favoriteTableView.frame         = view.bounds
    }
    // NotificationCenter
    func Notify(){
        NotificationCenter.default.addObserver(forName: .notifyDownloaded, object: nil, queue: nil) { _ in
            self.fetchLocalStorageForDownlaod()
        }
        
        NotificationCenter.default.addObserver(forName: .notifyDeleted, object: nil, queue: nil) { _ in
            self.fetchLocalStorageForDownlaod()
        }
    }
    
    func fetchLocalStorageForDownlaod(){
        viewModel.fetchCatsFromDatabase()
    }
        
    private func deleteCatAt(indexPath: IndexPath){
        viewModel.deleteCatsFromDatabase(indexPath: indexPath)
    }
}

// TableView Delegate
extension CatFavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite                 = favorites[indexPath.row]
        let destVC                   = CatFavoriteDetailViewController(cat: favorite)
        destVC.catNameLabel.text     = favorite.name
        destVC.catTemperament.text   = "Temperamanet:  \(favorite.temperament ?? "")"
        destVC.catOrigin.text        = "Origin:  \(favorite.origin ?? "")"
        destVC.catDescription.text   = "Description:  \(favorite.descriptionn ?? "")"
        destVC.safariDelegate        = self
        destVC.favoriteDelegate      = self
        destVC.indexPath             = indexPath
        destVC.detailImageView.downloadImage(from: favorite.imageUrl ?? "")
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            viewModel.deleteCatsFromDatabase(indexPath: indexPath)
        default:
            break
        }
    }
}

// View Model Protocol Delegate
extension CatFavoriteViewController: FavoriteCatsOutPut {
    func changeLoading(isLoad: Bool) {
        DispatchQueue.main.async { isLoad ? self.indicator.startAnimating() : self.indicator.stopAnimating() }
    }
    
    func fetchCatDatabase(cats: [CatsItem]) {
        self.favorites = cats
        DispatchQueue.main.async { self.favoriteTableView.reloadData() }
    }
    
    func deleteCatDatabase(cats: [CatsItem]) {
        self.favorites = cats
        DispatchQueue.main.async { self.favoriteTableView.reloadData() }
    }
    
    
}

// TableView DataSource
extension CatFavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteTableView.dequeueReusableCell(withIdentifier: CatFavoriteTableViewCell.reuseIdFavorite, for: indexPath) as! CatFavoriteTableViewCell
        let cat             = favorites[indexPath.row]
        cell.delegate       = self
        cell.indexPath      = indexPath
        cell.set(cats: cat)
        return cell
    }
}

// Safari & Cell & Detail Protocol Delegate
extension CatFavoriteViewController: FavoriteSafariServiceDelegateProtocol,TableViewCellDeleteProtocol,CatFavoriteProtocol {
    func clickDeleteCatFavoriteDetail(indextPath: IndexPath) {
        viewModel.deleteCatsFromDatabase(indexPath: indextPath)
        self.presentAlert(title: "Removed From Favorites ❌", message: "Chosen cat was removed from favorites.", buttonTitle: "Ok")
    }
    
    func goFavoriteLearnAboutCat(for cat: CatsItem) {
        guard let url = URL(string: cat.wikipediaUrl ?? "") else {
            return
        }
        self.presentSafariVC(with: url)
    }
    
    func onCellDelete(indexPath: IndexPath) {
        viewModel.deleteCatsFromDatabase(indexPath: indexPath)
        self.presentAlert(title: "Removed From Favorites ❌", message: "Chosen cat was removed from favorites.", buttonTitle: "Ok")
    }
}
