//
//  BaseLoading.swift
//  base-swift
//
//  Created by ThiemJason on 4/25/23.
//  Copyright © 2023 BaseSwift. All rights reserved.
//

import Foundation
import UIKit

class BaseLoading {
    
    var containerView = UIView()
    var progressView = UIView()
    var messageView = UILabel()
    var activityIndicator = UIActivityIndicatorView()
    
    static let shared: BaseLoading = BaseLoading()
    
    func show(forView view: UIView? = nil, message: String? = BaseText.loading) {
        guard let window = view ?? UIApplication.shared.keyWindow else {
            return
        }
        containerView.backgroundColor = "0x191F26".colorWithHexString(alpha: 0.5)
        
        //        progressView.backgroundColor = "0x444444".colorWithHexString(alpha: 0.7)
        //        progressView.clipsToBounds = true
        //        progressView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = .whiteLarge
        activityIndicator.transform = CGAffineTransform(scaleX: 64 / 40, y: 64 / 40)
        
        messageView.font = .systemFont(ofSize: 14)
        messageView.textColor = .white
        messageView.textAlignment = .center
        messageView.numberOfLines = 0
        messageView.text = message ?? BaseText.loading
        
        progressView.addSubview(activityIndicator)
        progressView.addSubview(messageView)
        containerView.addSubview(progressView)
        window.addSubview(containerView)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        messageView.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.widthAnchor.constraint(equalToConstant: 64),
            activityIndicator.widthAnchor.constraint(equalToConstant: 64),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: progressView.topAnchor, constant: 24)
        ])
        
        NSLayoutConstraint.activate([
            messageView.leftAnchor.constraint(equalTo: progressView.leftAnchor, constant: 24),
            messageView.rightAnchor.constraint(equalTo: progressView.rightAnchor, constant: -24),
            messageView.bottomAnchor.constraint(equalTo: progressView.bottomAnchor, constant: -24),
            messageView.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 24)
        ])
        
        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            progressView.widthAnchor.constraint(greaterThanOrEqualToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: window.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: window.rightAnchor),
            containerView.topAnchor.constraint(equalTo: window.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: window.bottomAnchor),
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismiss() {
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
}
