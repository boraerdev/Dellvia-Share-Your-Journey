//
//  UserServices.swift
//  YemekTarifi
//
//  Created by Bora Erdem on 12.08.2022.
//

import Foundation
import Firebase

struct UserServces {
    
    static let shared = UserServces()
    
    func getUser(uid: String, completion: @escaping (User)-> Void)  {
        Firestore.firestore().collection("users").document(uid)
            .getDocument { snapshot, error in
                guard error == nil else {return}
                guard let snapshot = snapshot else {return}
                guard let user = try? snapshot.data(as: User.self) else {return}
                completion(user)
            }
    }
    
}
