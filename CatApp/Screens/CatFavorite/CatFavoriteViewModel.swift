//
//  CatFavoriteViewModel.swift
//  CatApp
//
//  Created by Serkan on 27.04.2022.
//

import Foundation

protocol CatFavoriteViewModelProtocol {
    var service: DataPersistanceManagerProtocol { get set }
    func changeLoading()
    var cats: [CatsItem] { get set }
    var catsOutput: FavoriteCatsOutPut? { get }
    func setDelegate(output: FavoriteCatsOutPut)
    func fetchCatsFromDatabase()
    func deleteCatsFromDatabase(indexPath: IndexPath)
}


protocol FavoriteCatsOutPut {
    func changeLoading(isLoad: Bool)
    func fetchCatDatabase(cats: [CatsItem])
    func deleteCatDatabase(cats: [CatsItem])
}


final class CatFavoriteViewModel: CatFavoriteViewModelProtocol {
    
    private var isLoading   = false
    var cats: [CatsItem]    = []
    
    var service: DataPersistanceManagerProtocol
    var catsOutput: FavoriteCatsOutPut?
    
    init(service: DataPersistanceManagerProtocol = DataPersistanceManager()) {
        self.service = service
    }
    
    func fetchCatsFromDatabase() {
        changeLoading()
        service.fetchFavoritesFromDataBase { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let cats):
                self.changeLoading()
                self.cats = cats
                self.catsOutput?.fetchCatDatabase(cats: cats)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func deleteCatsFromDatabase(indexPath: IndexPath) {
        changeLoading()
        service.deleteCatWith(model: cats[indexPath.row]) { (result) in
            switch result {
            case .success():
                self.changeLoading()
                NotificationCenter.default.post(name: .notifyDeleted, object: nil)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func changeLoading() {
        isLoading = !isLoading
        catsOutput?.changeLoading(isLoad: isLoading)
    }
    
    func setDelegate(output: FavoriteCatsOutPut) {
        catsOutput = output
    }
}
