//
//  CatCollectionListWorker.swift
//  CatApp
//
//  Created by Serkan on 4.07.2022.
//

import Foundation


protocol CatsColectionListServiceProtocol {
    func getCats(limit: Int, with page: Int,completion: @escaping (Result<[Cats], NetworkError>) -> Void)
}


class CatCollectionListService: CatsColectionListServiceProtocol {
    
    private let catCollectionRequest: CatRequestProtocol
    
    init(catCollectionRequest: CatRequestProtocol = CatService()){
        self.catCollectionRequest = catCollectionRequest
    }
    
    func getCats(limit: Int, with page: Int, completion: @escaping (Result<[Cats], NetworkError>) -> Void) {
        catCollectionRequest.request(urlString: CatAPI.fetchCat.urlString(limit: limit, page: page), completion: completion)
    }
}
