//
//  User.swift
//  MyChatApp
//
//  Created by Mürşide Gökçe on 24.02.2025.
//

import Foundation
import UIKit

struct User {
    let uid: String
    let name: String
    let username: String
    let email: String
    let profileImageURL: String
    
    init(data: [String: Any]) {
        self.uid = data["uid"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.username = data["username"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.profileImageURL = data["profileImageURL"] as? String ?? ""
    }
}
