//
//  Extension.swift
//  MyChatApp
//
//  Created by Mürşide Gökçe on 15.02.2025.
//
import UIKit
import JGProgressHUD

extension UIViewController {
    func configureGradientLayer(){
        let gradient = CAGradientLayer()
        gradient.locations = [0,1]
        gradient.colors = [UIColor.systemBlue.cgColor,UIColor.systemPurple.cgColor]
        gradient.frame = view.bounds
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    func showProgressHUD(showProgress: Bool){
        let progressHUD = JGProgressHUD(style: .dark)
        progressHUD.textLabel.text = "Yükleniyor..."
        showProgress ? progressHUD.show(in: view) : progressHUD.dismiss()
        
    }
    
    func add(_ child: UIViewController){
        addChild(child)
        self.view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove(){
        willMove(toParent: self)
        self.view.removeFromSuperview()
        removeFromParent()
    }
}
