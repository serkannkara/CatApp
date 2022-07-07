//
//  UIHelper.swift
//  CatApp
//
//  Created by Serkan on 30.06.2022.
//

import UIKit


struct UIHelper {
    static func collectionViewFlowLayout(numberofColumn: CGFloat, view: UIView) -> UICollectionViewFlowLayout {
        let flowLayout                  = UICollectionViewFlowLayout()
        let width                       = view.bounds.width
        let padding: CGFloat            = 5
        let minimumItemSpacing: CGFloat = 5
        let availableWidth              = width - (padding * numberofColumn) - (minimumItemSpacing * numberofColumn)
        let itemWidth                   = availableWidth / CGFloat(numberofColumn)
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth*1.1)
        if numberofColumn == 1 {
            flowLayout.itemSize = CGSize(width: itemWidth, height: 300)
        }else if numberofColumn == 2 {
            flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth*2)
        }else {
            flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth*2.5)
        }
        return flowLayout
    }
}
