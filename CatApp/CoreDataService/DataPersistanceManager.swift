//
//  DataPersistanceManager.swift
//  CatApp
//
//  Created by Serkan on 19.04.2022.
//

import Foundation
import UIKit
import CoreData


protocol DataPersistanceManagerProtocol {
    func downloadCatWith(model: Cats, completion: @escaping (Result<Void, NetworkError>) -> Void)
    func fetchFavoritesFromDataBase(completion: @escaping (Result<[CatsItem], NetworkError>) -> Void)
    func deleteCatWith(model: CatsItem, completion: @escaping (Result<Void, NetworkError>) -> Void)
}


struct DataPersistanceManager: DataPersistanceManagerProtocol {
    
    static let shared = DataPersistanceManager()
    
    func downloadCatWith(model: Cats, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return  }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = CatsItem(context: context)
        
        item.name           = model.name
        item.temperament    = model.temperament
        item.origin         = model.origin
        item.imageUrl       = model.image?.imageUrl
        item.descriptionn   = model.description
        item.wikipediaUrl   = model.wikipediaUrl
                
        do{
            try context.save()
            completion(.success(()))
        }catch{
            completion(.failure(.failedToSaveData))
        }
    }
    
    func fetchFavoritesFromDataBase(completion: @escaping (Result<[CatsItem], NetworkError>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<CatsItem>
        
        request = CatsItem.fetchRequest()
        
        do{
            let titles = try context.fetch(request)
            completion(.success(titles))
        }catch {
            completion(.failure(.failedToFetchData))
        }
    }

    func deleteCatWith(model: CatsItem, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model)
        
        do{
            try context.save()
            completion(.success(()))
        }catch {
            completion(.failure(.failedToDeleteData))
        }
    }
}

