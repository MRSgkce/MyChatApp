//
//  service.swift
//  MyChatApp
//
//  Created by Mürşide Gökçe on 24.02.2025.
//

import Foundation
import Firebase
import FirebaseFirestore

struct service {
    
    static func fetchUsers(completion: @escaping ([User]) -> Void){
        var users = [User]()
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            }
            users = snapshot?.documents.map({User(data : $0.data())}) ?? []
            
            completion(users)
        }
    }
}
