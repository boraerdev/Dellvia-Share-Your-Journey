//
//  UserModel.swift
//  YemekTarifi
//
//  Created by Bora Erdem on 12.08.2022.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
    @DocumentID var id : String?
     var ad : String
     var soyad: String
     var mail: String
}
