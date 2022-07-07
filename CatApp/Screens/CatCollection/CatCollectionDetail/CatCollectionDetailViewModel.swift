//
//  CatCollectionDetailViewModel.swift
//  CatApp
//
//  Created by Serkan on 30.06.2022.
//

import Foundation

protocol CatDetailViewModelProtocol {
    var delegate: CatDetailViewModelDelegate? { get set }
    func Load()
}

protocol CatDetailViewModelDelegate: AnyObject {
    func showDetail(_ cats: Cats)
}

class CatCollectionDetailViewModel: CatDetailViewModelProtocol {
    
    weak var delegate: CatDetailViewModelDelegate?
    private var cats: Cats
    
    init(cats: Cats) {
        self.cats = cats
    }
    
    func Load(){
        delegate?.showDetail(cats)
    }
}
