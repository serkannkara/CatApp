//
//  CatCollectionViewModel.swift
//  CatApp
//
//  Created by Serkan on 30.06.2022.
//

import Foundation
import UIKit

protocol CatCollectionListViewModelProtocol {
    var delegate: CatCollectionListViewModelDelegate? { get set }
    func load()
    func selectCat(index: Int)
    var page: Int { get set}
    var limit: Int { get set }
}

protocol CatCollectionListViewModelDelegate: AnyObject {
    func viewModelOutPut(output: CatCollectionListViewModelOutput)
    func navigate(to route: CatListViewRoute)
}

enum CatCollectionListViewModelOutput {
    case setLoading(Bool)
    case catCollectionList([Cats])
}

enum CatListViewRoute {
    case detail(CatDetailViewModelProtocol)
}

class CatCollectionListViewModel: CatCollectionListViewModelProtocol  {
    
    weak var delegate: CatCollectionListViewModelDelegate?
    private let service: CatsColectionListServiceProtocol
    
    var cats = [Cats]()
    
    var page = 1
    var limit = 12
    
    init(service: CatsColectionListServiceProtocol = CatCollectionListService()) {
        self.service = service
    }
    
    
    func load() {
        notify(output: .setLoading(true))
        service.getCats(limit: limit, with: page) { [weak self] (result) in
            guard let self = self else { return }
            self.notify(output: .setLoading(false))
            switch result {
            case .success(let response):
                self.cats = response
                self.notify(output: .catCollectionList(response))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func selectCat(index: Int) {
        let cat = cats[index]
        let viewModel = CatCollectionDetailViewModel(cats: cat)
        delegate?.navigate(to: .detail(viewModel))
    }
    
    private func notify(output: CatCollectionListViewModelOutput){
        delegate?.viewModelOutPut(output: output)
    }
}






















