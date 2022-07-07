//
//  NetworkError.swift
//  CatApp
//
//  Created by Serkan on 18.04.2022.
//

import Foundation


enum NetworkError: String, Error {
    case unableComplete     = "Please check your internet"
    case invalidReponse     = "Invalid response from server"
    case invalidData        = "Invalid data from Server"
    case failedToSaveData   = "Failed to save data"
    case failedToFetchData  = "Failed to fetch data"
    case failedToDeleteData = "Failed to delete data"
}
