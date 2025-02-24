//
//  RegisterViewModel.swift
//  MyChatApp
//
//  Created by Mürşide Gökçe on 18.02.2025.
//

import UIKit

class RegisterViewModel {
    
    var email: String?
    var name: String?
    var username: String?
    var password: String?
    
    var status: Bool{
        return email?.isEmpty==false && name?.isEmpty==false && username?.isEmpty==false && password?.isEmpty==false
    }
}
