//
//  CatListViewModel.swift
//  CatApp
//
//  Created by Serkan on 27.04.2022.
//

import Foundation
import UIKit


protocol CatListViewModelProtocol {
    func changeLoading()
    var cats: [Cats] { get set }
    var service: CatsColectionListServiceProtocol? {get set}
    var catsOutput: ListCatsOutPut? { get }
    func setDelegate(_ output: ListCatsOutPut)
    func uploadCatCoreData(indexPath: IndexPath)
    func fetchCats(limit: Int, page: Int)
}

protocol ListCatsOutPut {
    func changeLoading(isLoad: Bool)
    func saveDatas(values: [Cats])
}

final class CatListViewModel: CatListViewModelProtocol {
    var delegate: CatListViewModelProtocol?
    
    var cats: [Cats]            = []
    private var isLoading       = false
    
    var service: CatsColectionListServiceProtocol?
    var catsOutput: ListCatsOutPut?
    
    var refreshControl = UIRefreshControl()
    
    init(service: CatsColectionListServiceProtocol = CatCollectionListService()) {
        self.service = service
    }
    
    func fetchCats(limit: Int, page: Int) {
        changeLoading()
        service?.getCats(limit: limit, with: page) {  (result) in
            switch result {
            case .success(let response):
                self.changeLoading()
                self.cats = response
                self.catsOutput?.saveDatas(values: self.cats)
            case .failure(let error):
                print(error.rawValue)
            }
            
        }
    }
    
    func changeLoading() {
        isLoading = !isLoading
        catsOutput?.changeLoading(isLoad: isLoading)
    }
    func setDelegate(_ output: ListCatsOutPut) {
        catsOutput = output
    }
    
}

extension CatListViewModel {
    func uploadCatCoreData(indexPath: IndexPath) {
        DataPersistanceManager.shared.downloadCatWith(model: cats[indexPath.row]) { (result) in
            switch result {
            case .success():
                NotificationCenter.default.post(name: .notifyDownloaded, object: nil)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
}
