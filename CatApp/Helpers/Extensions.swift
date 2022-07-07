//
//  UIViewController+Ext.swift
//  CatApp
//
//  Created by Serkan on 20.04.2022.
//

import Foundation
import UIKit
import SafariServices


extension UIViewController {
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    
    func presentAlert(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC                     = AlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}


extension UIButton {
    func buttonAnimate() {
        UIView.animate(withDuration: 0.8, animations: {
            self.transform = CGAffineTransform.identity.scaledBy(x: 0.5, y: 0.5)
               }, completion: { (finish) in
                   UIView.animate(withDuration: 0.5, animations: {
                       self.transform = CGAffineTransform.identity
                   })
           })
    }
}


extension Notification.Name {
    static let notifyDownloaded = Notification.Name("catsDownloaded")
    static let notifyDeleted    = Notification.Name("catsDeleted")
}

