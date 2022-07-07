//
//  CatAPI.swift
//  CatApp
//
//  Created by Serkan on 21.04.2022.
//

import Foundation


enum CatAPI {
    case fetchCat
}

extension CatAPI: APISetting {
   
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "api.thecatapi.com"
    }
    
    var path: String {
        return "/v1/breeds"
    }
    var parameterLimit: String {
        return "limit="
    }
    var parameterPage: String {
        return "&page="
    }
    
    var search: String {
        return "search?q="
    }
    
    var apiKey: String {
        return "api_key=a082b2da-698c-4e91-b5c2-2690fca7e144"
    }
    
    func urlString(limit: Int, page: Int) -> String {
        return "\(scheme)://\(host)\(path)?\(parameterLimit)\(limit)\(parameterPage)\(page)\(apiKey)"
    }
}


