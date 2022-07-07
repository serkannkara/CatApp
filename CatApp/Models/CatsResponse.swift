//
//  CatsResponse.swift
//  CatApp
//
//  Created by Serkan on 27.04.2022.
//

import Foundation


public struct CatsResponse: Decodable {
    var result: [Cats]
    init(result: [Cats]){
        self.result = result
    }
}
