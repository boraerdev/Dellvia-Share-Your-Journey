//
//  MainViewModel.swift
//  Dellvia
//
//  Created by Bora Erdem on 15.08.2022.
//

import Foundation
import Firebase

class MainViewModel: ObservableObject {
    
    @Published var activeCalls: [Call] = []
    @Published var goDetail: Bool = false
    
    init(){
        DispatchQueue.main.async {
            self.fetchMyActivaCalls()
        }
    }
    
    func fetchMyActivaCalls(){
        guard let userUid = Auth.auth().currentUser?.uid else {
            print("user gelmedi")
            return
        }
        Firestore.firestore().collection("Booking").whereField("authorUid", isEqualTo: "\(userUid)")
            .addSnapshotListener { querySnapshot, error in
                guard let docs = querySnapshot?.documents else {
                    print("dosyalar alınamadı")
                    return
                }
                var tempList : [Call]  = []
                for doc in docs {
                    guard let gelen = try? doc.data(as: Call.self) else {
                        print("çevrilemedi")
                        return
                    }
                    tempList.append(gelen)
                    
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.activeCalls = tempList
                    self.activeCalls.sort(by: {$0.timestamp > $1.timestamp})
                }
            }
}

    
}
