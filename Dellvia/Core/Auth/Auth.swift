//
//  Auth.swift
//  YemekTarifi
//
//  Created by Bora Erdem on 12.08.2022.
//

import Foundation
import Firebase
import FirebaseAuth

class AuthViewModel: ObservableObject {
    
    @Published var userSession : FirebaseAuth.User?
    @Published var currentUser : User?
    @Published var errorMessage : String?
    @Published var showError : Bool = false
    
    init(){
        DispatchQueue.main.async {
            self.userSession = Auth.auth().currentUser
            self.fetchUser()
            
        }
        
    }
    
    func fetchUser(){
        guard let user = userSession else {return}
        UserServces.shared.getUser(uid: user.uid) { returned in
            self.currentUser = returned
        }
    }
    
    func register(ad: String, soyad: String, mail: String, pass: String){
        let data = ["ad": ad, "soyad": soyad, "mail": mail] as [String: Any]
        Auth.auth().createUser(withEmail: mail, password: pass) { result, error in
            guard error == nil else {
                self.errorMessage = error?.localizedDescription
                self.showError.toggle()
                return
            }
            self.fetchUser()
            guard let user = result?.user else {return}
            self.userSession = user
            Firestore.firestore().collection("users").document((self.userSession?.uid)!).setData(data) { error in
                guard error == nil else {return}
            }
        }
    }
    
    func login(mail: String, pass: String) {
        Auth.auth().signIn(withEmail: mail, password: pass) { result, error in
            guard error == nil else {
                self.errorMessage = error?.localizedDescription
                self.showError.toggle()
                return
            }
            self.fetchUser()
            guard let resultFinish = result else {
                return
            }
            self.userSession = resultFinish.user

        }
    }
    
    
    func logOut(){
        try? Auth.auth().signOut()
        self.currentUser = nil
        self.userSession = nil
    }
    
    
    
}
