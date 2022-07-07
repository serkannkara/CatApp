//
//  CatService.swift
//  CatApp
//
//  Created by Serkan on 18.04.2022.
//

import Foundation
import UIKit


protocol CatRequestProtocol {
    func request<T: Decodable>(urlString: String, completion: @escaping (Result<T, NetworkError>) -> Void)
}

class CatService: CatRequestProtocol {

    func request<T: Decodable>(urlString: String, completion: @escaping (Result<T, NetworkError>) -> Void){
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completion(.failure(.unableComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidReponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do{
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            }catch {
                completion(.failure(.invalidData))
            }
        }.resume()
    }
    
}



