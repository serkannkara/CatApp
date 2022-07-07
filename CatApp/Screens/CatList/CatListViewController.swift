//
//  CatListViewController.swift
//  CatApp
//
//  Created by Serkan on 18.04.2022.
//

import UIKit
import SafariServices


class CatListViewController: UIViewController {
    
    var catListTableView: UITableView = {
       let clTableView = UITableView()
        clTableView.translatesAutoresizingMaskIntoConstraints = false
        clTableView.rowHeight                                 = 120
        clTableView.register(CatListTableViewCell.self, forCellReuseIdentifier: CatListTableViewCell.reuseIdList)
        return clTableView
    }()
    
    
    var cats            = [Cats]()
    var page            = 1
    var limit           = 11
    var moreCats        = true
    var refreshControl    = UIRefreshControl()
    
    let indicator = UIActivityIndicatorView(style:  UIActivityIndicatorView.Style.large)
    lazy var viewModel: CatListViewModelProtocol = CatListViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel.setDelegate(self)
        viewModel.fetchCats(limit: limit, page: page)
        configureNavigationController()
        configureTableView()
        view.addSubview(indicator)
        indicator.fillSuperview()
    }
    
    // Configuration TableView
    func configureTableView() {
        view.addSubview(catListTableView)
        catListTableView.delegate   = self
        catListTableView.dataSource = self
        catListTableView.prefetchDataSource = self
        catListTableView.frame      = view.bounds
        catListTableView.refreshControl = refreshControl
        
    }
    
    //Configuration Navigation
    private func configureNavigationController(){
        let favoriteButton = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .done, target: self, action: #selector(favoriteButtonTapped))
        favoriteButton.tintColor                               = .systemPink
        navigationItem.rightBarButtonItem                      = favoriteButton
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc func favoriteButtonTapped(){
        self.navigationController?.pushViewController(CatFavoriteViewController(), animated: true)
    }
    
}

// View Model Protocol Delegate
extension CatListViewController: ListCatsOutPut {
    func changeLoading(isLoad: Bool) {
        DispatchQueue.main.async { isLoad ? self.indicator.startAnimating() : self.indicator.stopAnimating() }
        
    }
    
    func saveDatas(values: [Cats]) {
        cats = values
        DispatchQueue.main.async {
            self.catListTableView.reloadData()
        }
    }
}

// Safari & Cell & Detail Protocol Delegate
extension CatListViewController: TableViewCellAddProtocol, ListSafariServiceDelegateProtocol, CatListDetailProtocol {
    func clickAddCatListDetail(indexPath: IndexPath) {
        viewModel.uploadCatCoreData(indexPath: indexPath)
    }
    
    func onCellAdd(indexPath: IndexPath) {
        viewModel.uploadCatCoreData(indexPath: indexPath)
        self.presentAlert(title: "Added to Favorite ✅", message: "Chosen cat was added to favorite.", buttonTitle: "Ok")
    }
    
    func goListLearnAboutCat(for cat: Cats) {
        guard let url = URL(string: cat.wikipediaUrl ?? "") else { return }
        self.presentSafariVC(with: url)
    }
}


// TableView Delegate
extension CatListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cat                     = cats[indexPath.row]
        let destVC                  = CatListDetailViewController()
        destVC.catNameLabel.text    = cat.name
        destVC.catTemperament.text  = "Temperament:  \(cat.temperament)"
        destVC.catOrigin.text       = "Origin:  \(cat.origin)"
        destVC.catDescription.text  = "Description:  \(cat.description)"
        destVC.safariDelegate       = self
        destVC.detailDelegate       = self
        destVC.indexPath            = indexPath
        destVC.detailImageView.downloadImage(from: cat.image?.imageUrl ?? "")
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//
//        let offsetY         = scrollView.contentOffset.y
//        let contentHeight   = scrollView.contentSize.height
//        let height          = scrollView.frame.size.height
//
//        if offsetY > contentHeight - height {
//            guard moreCats else { return }
//            page    += 1
//            limit   += 12
//            viewModel.fetchCats(limit: limit, page: page)
//        }
//    }
}

// TableView DataSource
extension CatListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cat         = cats[indexPath.row]
        let cell        = tableView.dequeueReusableCell(withIdentifier: CatListTableViewCell.reuseIdList, for: indexPath) as! CatListTableViewCell
        cell.delegate   = self
        cell.indexPath  = indexPath
        cell.set(cats: cat)
        return cell
    }
}


extension CatListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.first == indexPaths.last {
            page    += 1
            limit   += 12
            viewModel.fetchCats(limit: limit, page: page)
        }
    }
}
