//
//  MainTabBarController.swift
//  CatApp
//
//  Created by Serkan on 18.04.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor       = .systemGray
        UITabBar.appearance().backgroundColor = .systemGray6
        viewControllers = [createCatCollectionListNC(),createCatListNC(),createCatFavoriteNC()]
    }
    
    func createCatCollectionListNC() -> UINavigationController {
        let catListNC = CatCollectionListViewController()
        catListNC.title      = "Cats Collection"
        catListNC.tabBarItem = UITabBarItem(title: "CatsCollection", image: UIImage(systemName: "book.circle"), selectedImage: UIImage(systemName: "book.circle.fill"))
        return UINavigationController(rootViewController: catListNC)
    }
    
    func createCatListNC() -> UINavigationController {
        let catListNC = CatListViewController()
        catListNC.title      = "Cats"
        catListNC.tabBarItem = UITabBarItem(title: "Cats", image: UIImage(systemName: "book"), selectedImage: UIImage(systemName: "book.fill"))
        return UINavigationController(rootViewController: catListNC)
    }
    
    func createCatFavoriteNC() -> UINavigationController {
        let favoriteListNC = CatFavoriteViewController()
        favoriteListNC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))        
        return UINavigationController(rootViewController: favoriteListNC)
    }

}
