//
//  Protocols.swift
//  CatApp
//
//  Created by Serkan on 21.04.2022.
//

import Foundation


protocol CatListDetailProtocol: AnyObject {
    func clickAddCatListDetail(indexPath: IndexPath)
}

protocol CatFavoriteProtocol: AnyObject {
    func clickDeleteCatFavoriteDetail(indextPath: IndexPath)
}

protocol TableViewCellAddProtocol: AnyObject {
    func onCellAdd(indexPath: IndexPath)
}

protocol TableViewCellDeleteProtocol: AnyObject {
    func onCellDelete(indexPath: IndexPath)
}

protocol ListSafariServiceDelegateProtocol: AnyObject {
    func goListLearnAboutCat(for cat: Cats)
}

protocol FavoriteSafariServiceDelegateProtocol: AnyObject {
    func goFavoriteLearnAboutCat(for cat: CatsItem)
}
