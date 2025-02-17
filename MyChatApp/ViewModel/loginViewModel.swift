//
//  loginViewModel.swift
//  MyChatApp
//
//  Created by Mürşide Gökçe on 17.02.2025.
//
import Foundation
import UIKit

struct loginViewModel {
    var emailTextField : String?
    var passwordTextField : String?
    var status : Bool{
        return emailTextField?.isEmpty == false && passwordTextField?.isEmpty == false
    }
}
