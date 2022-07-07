//
//  CatCollectionListViewController.swift
//  CatApp
//
//  Created by Serkan on 29.06.2022.
//

import Foundation
import UIKit



class CatCollectionListViewController: UIViewController {
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var segmentedControl: UISegmentedControl = {
        let types = [
            Section.One.rawValue,
            Section.Two.rawValue,
            Section.Three.rawValue
        ]
        let sgControl = UISegmentedControl(items: types)
        sgControl.selectedSegmentIndex = 0
        sgControl.translatesAutoresizingMaskIntoConstraints = false
        return sgControl
    }()
    
    lazy var viewModel: CatCollectionListViewModelProtocol = CatCollectionListViewModel()
    
    var cats = [Cats]()
    
    private var indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    private var isPagination = false
    private var isFinishPagination = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
//        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.collectionViewFlowLayout(numberofColumn: 1, view: view))
        setupSegmentedControl()
        setupCollectionView()
        viewModel.delegate = self
        viewModel.load()
    }
    
    private func setupCollectionView(){
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView)
        collectionView.register(CatCollectionCell.self, forCellWithReuseIdentifier: Constants.catCollectionCellOne)
        collectionView.register(CatPaginationFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Constants.catPaginationFooterId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 65, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))
    }
    
    private func setupSegmentedControl(){
        view.addSubview(segmentedControl)
        segmentedControl.addTarget(self, action: #selector(handleSegmented), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func handleSegmented(){
        setupCollectionView()
//        if segmentedControl.selectedSegmentIndex == 0 {
//            collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.collectionViewFlowLayout(numberofColumn: 1, view: view))
//            setupCollectionView()
//            collectionView.register(CatCollectionCell.self, forCellWithReuseIdentifier: Constants.catCollectionCellOne)
//            collectionView.register(CatPaginationFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Constants.catPaginationFooterId)
//        }else if segmentedControl.selectedSegmentIndex == 1 {
//            collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.collectionViewFlowLayout(numberofColumn: 2, view: view))
//            setupCollectionView()
//            collectionView.register(CatCollectionCell.self, forCellWithReuseIdentifier: Constants.catCollectionCellOne)
//            collectionView.register(CatPaginationFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Constants.catPaginationFooterId)
//        }else {
//            collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.collectionViewFlowLayout(numberofColumn: 3, view: view))
//            setupCollectionView()
//            collectionView.register(CatCollectionCell.self, forCellWithReuseIdentifier: Constants.catCollectionCellOne)
//            collectionView.register(CatPaginationFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Constants.catPaginationFooterId)
//        }
    }
}


extension CatCollectionListViewController: CatCollectionListViewModelDelegate {
    func viewModelOutPut(output: CatCollectionListViewModelOutput) {
        switch output {
        case .setLoading(let isLoading):
            DispatchQueue.main.async { isLoading ? self.indicator.startAnimating() : self.indicator.stopAnimating() }
        case .catCollectionList(let cats):
            DispatchQueue.main.async {
                self.cats = cats
                self.collectionView.reloadData()
            }
        }
    }
    
    func navigate(to route: CatListViewRoute) {
        switch route {
        case .detail(let viewModel):
            let viewController = CatCollectionDetailViewController()
            viewController.viewModel = viewModel
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension CatCollectionListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.catCollectionCellOne, for: indexPath) as! CatCollectionCell
        let cat = cats[indexPath.row]
        cell.cats = cat
        return cell
    }
}

extension CatCollectionListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.selectCat(index: indexPath.row)
    }
}

extension CatCollectionListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.catPaginationFooterId, for: indexPath)
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .init(width: view.bounds.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var heightItem: CGFloat = 300
        var widthItem: CGFloat = view.bounds.width

        if segmentedControl.selectedSegmentIndex == 0 {
            let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
            let dummyCell = CatCollectionCell(frame: frame)
            dummyCell.cats = cats[indexPath.item]
            dummyCell.layoutIfNeeded()
            let targetSize = CGSize(width: view.frame.width, height: 1000)
            let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize)
            heightItem = estimatedSize.height
            widthItem = view.bounds.width - 10
        }else if segmentedControl.selectedSegmentIndex == 1 {
            let availableWidth              = view.frame.width - 20
            let itemWidth                   = availableWidth / 2
            widthItem = itemWidth
            heightItem = itemWidth * 2
        }else if segmentedControl.selectedSegmentIndex == 2 {
            let availableWidth              = view.frame.width - 30
            let itemWidth                   = availableWidth / 3
            widthItem = itemWidth
            heightItem = itemWidth * 2.5
        }
        return CGSize(width: widthItem, height: heightItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

}

// CollectionView PrefetchingDataSource
extension CatCollectionListViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.item >= cats.count - 2 && !isPagination {
                isPagination = true
                viewModel.page    += 1
                viewModel.limit   += 12
                viewModel.load()
                isPagination = false
            }
        }
    }
}


