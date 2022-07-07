//
//  AlertVC.swift
//  CatApp
//
//  Created by Serkan on 20.04.2022.
//

import UIKit

class AlertVC: UIViewController {
    
    let containerView: UIView = {
       let cntView = UIView()
        cntView.translatesAutoresizingMaskIntoConstraints = false
        cntView.backgroundColor                           = .systemBackground
        cntView.layer.borderColor                         = UIColor.systemGray.cgColor
        cntView.layer.cornerRadius                        = 16
        cntView.layer.borderWidth                         = 2
        
        return cntView
    }()
    
    let titleLabel: UILabel = {
        let ttlLabel = UILabel()
        
        ttlLabel.translatesAutoresizingMaskIntoConstraints  = false
        ttlLabel.font                                       = UIFont.systemFont(ofSize: 20, weight: .semibold)
        ttlLabel.adjustsFontSizeToFitWidth                  = true
        ttlLabel.textAlignment                              = .center
        ttlLabel.numberOfLines                              = 0
        ttlLabel.textColor                                  = .label
        return ttlLabel
    }()
    
    let messageLabel: UILabel = {
        let msgLabel = UILabel()
        msgLabel.translatesAutoresizingMaskIntoConstraints  = false
        msgLabel.font                                       = UIFont.systemFont(ofSize: 15, weight: .semibold)
        msgLabel.adjustsFontSizeToFitWidth                  = true
        msgLabel.textAlignment                              = .center
        msgLabel.numberOfLines                              = 4
        msgLabel.textColor                                  = .systemGray
        return msgLabel
    }()
    
    let actionButton: UIButton = {
        let actButton = UIButton()
        actButton.translatesAutoresizingMaskIntoConstraints = false
        actButton.titleLabel?.font                          = UIFont.preferredFont(forTextStyle: .headline)
        actButton.layer.cornerRadius                        = 10
        actButton.backgroundColor                           = .systemPink
        actButton.setTitleColor(.white, for: .normal)
        actButton.setTitle("Ok", for: .normal)
        actButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        return actButton
    }()
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle     = title
        self.message        = message
        self.buttonTitle    = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0, alpha: 0.75)
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
    }

    func configureContainerView() {
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configureActionButton(){
        containerView.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func configureMessageLabel(){
        containerView.addSubview(messageLabel)
        messageLabel.text = message ?? ""
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
    }
    
    @objc func dismissVC(){
        dismiss(animated: true, completion: nil)
    }
}
