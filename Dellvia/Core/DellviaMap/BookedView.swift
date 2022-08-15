//
//  BookedView.swift
//  Uber Clone
//
//  Created by Balaji on 29/04/20.
//  Copyright © 2020 Balaji. All rights reserved.
//

import SwiftUI
import Firebase

struct Booked : View {
    
    @Binding var data : Data
    @Binding var doc : String
    @Binding var loading : Bool
    @Binding var book : Bool
    
    var body: some View{
        
            
            VStack(spacing: 25){
                
                Image(uiImage: UIImage(data: self.data)!)
                    .resizable()
                    .frame(width: 200, height: 200)
                
                Button(action: {
                    
                    self.loading.toggle()
                    self.book.toggle()
                    
                    let db = Firestore.firestore()
                    
                    db.collection("Booking").document(self.doc).delete { (err) in
                        
                        if err != nil{
                            
                            print((err?.localizedDescription)!)
                            return
                        }
                        
                        self.loading.toggle()
                    }
                    
                }) {
                    
                    Text("Cancel")
                        .foregroundColor(Color("main2"))
                        .padding(.vertical,10)
                        .frame(width: UIScreen.main.bounds.width / 2)
                    
                    
                }
                .background(Color("main2").opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))            }
            .padding()
            .background(Color.white, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        
            
        
    }
}
