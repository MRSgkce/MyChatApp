//
//  Extension.swift
//  MyChatApp
//
//  Created by Mürşide Gökçe on 15.02.2025.
//
import UIKit
extension UIViewController {
    func configureGradientLayer(){
        let gradient = CAGradientLayer()
        gradient.locations = [0,1]
        gradient.colors = [UIColor.systemBlue.cgColor,UIColor.systemPurple.cgColor]
        gradient.frame = view.bounds
        view.layer.insertSublayer(gradient, at: 0)
    }
}
