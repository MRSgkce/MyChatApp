//
//  AuthenticationService.swift
//  MyChatApp
//
//  Created by Mürşide Gökçe on 23.02.2025.
//
import Foundation
import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseCore
import FirebaseFirestore
import Firebase

struct AuthenticationServiceUser {
    var emailText: String
    var passwordText: String
    var nameText: String
    var usernameText: String
    
}

struct AuthenticationService {
    
    static func login(withEmail email: String, password: String,completion: @escaping(AuthDataResult?, Error?)->Void){
        Auth.auth().signIn(withEmail: email, password: password,completion: completion)
    }
    
    static func register(withUser user: AuthenticationServiceUser, image: UIImage, completion: @escaping (Error?) -> Void) {
        
        
        let photoName = UUID().uuidString
        guard let profileData = image.jpegData(compressionQuality: 0.5) else{ return }
        let referance = Storage.storage().reference(withPath: "media/profile_image/\(photoName).png")
        referance.putData(profileData) { StorageMeta, error in
            if let error = error {
                completion(error)
            }
            referance.downloadURL() { url, error in
                if let error = error {
                    print(error.localizedDescription)
                }
                guard let profileUrl = url?.absoluteString else{ return }
                Auth.auth().createUser(withEmail: user.emailText, password: user.passwordText){ result, error in
                    if let error = error {
                        completion(error)
                    }
                    guard let userUid = result?.user.uid else {return}
                    let data = [
                        "email": user.emailText,
                        "name": user.nameText,
                        "username": user.usernameText,
                        "photoURL": profileUrl,
                        "uid": userUid
                    ] as [String : Any]
                    Firestore.firestore().collection("users").document(userUid).setData(data,completion: completion)                }
                
            }
            
        }
    }
}
