//
//  APISettings.swift
//  CatApp
//
//  Created by Serkan on 21.04.2022.
//

import Foundation


protocol APISetting {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var parameterLimit: String { get }
    var parameterPage: String { get }
    var apiKey: String { get }
    var search: String { get }
    func urlString(limit: Int,page: Int) -> String
}
