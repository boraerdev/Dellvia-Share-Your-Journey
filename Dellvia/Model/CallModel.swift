//
//  CallModel.swift
//  Dellvia
//
//  Created by Bora Erdem on 15.08.2022.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct Call: Identifiable, Codable, Equatable {
    @DocumentID var id: String?
    var authorName: String
    var qrUrl: String
    var from: GeoPoint
    var authorUid: String
    var distance: String
    var fair: Float
    var to: GeoPoint
    var doc: String
    var timestamp: Date
    var destinationName: String
    
}
