//
//  CatPaginationFooter.swift
//  CatApp
//
//  Created by Serkan on 1.07.2022.
//

import Foundation
import UIKit


class CatPaginationFooter: UICollectionReusableView {
    
    let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        indicator.color = .darkGray
        indicator.startAnimating()
        addSubview(indicator)
        indicator.centerInSuperview(size: .init(width: 200, height: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
