//
//  Home.swift
//  Uber Clone
//
//  Created by Balaji on 29/04/20.
//  Copyright © 2020 Balaji. All rights reserved.
//

import SwiftUI
import MapKit
import CoreLocation
import Firebase

struct Home : View {
    
    @State var map = MKMapView()
    @State var manager = CLLocationManager()
    @State var alert = false
    @State var source : CLLocationCoordinate2D!
    @State var destination : CLLocationCoordinate2D!
    @State var name = ""
    @State var distance = ""
    @State var time = ""
    @State var show = false
    @State var loading = false
    @State var book = false
    @State var doc = ""
    @State var data : Data = .init(count: 0)
    @State var search = false
    @Environment (\.presentationMode) var presentationMode
    @EnvironmentObject var authVm : AuthViewModel
    
    var body: some View{
        
        ZStack{
            
            ZStack(alignment: .bottom){
                
                
                
                VStack(spacing: 0){
                    
                    
                    
                    MapView(map: self.$map, manager: self.$manager, alert: self.$alert, source: self.$source, destination: self.$destination, name: self.$name,distance: self.$distance,time: self.$time, show: self.$show)
                    .onAppear {
                    
                        self.manager.requestAlwaysAuthorization()
                        

                    }
                }
                
                VStack{
                    HStack{
                        
                            
                        
                        HStack(spacing: 10){
                            
                            Image(systemName:"chevron.left")
                                .font(.title2)
                                .foregroundColor(Color("main2"))
                                .padding(8)
                                .background(Color("main2").opacity(0.2), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                                .onTapGesture {
                                    presentationMode.wrappedValue.dismiss()
                                }
                            
                                                    
                            VStack(alignment: .leading, spacing: 15) {
                                
                                Text(self.destination != nil ? "Hedef" : "Bir Konum Seç")
                                    .font(.title2)
                                
                                if self.destination != nil{
                                    
                                    Text(self.name)
                                        .fontWeight(.bold)
                                }
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                
                                self.search.toggle()
                                
                            }) {
                                
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.black)
                            }
                        }
                        .padding()
                        //.padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .padding()
                        .padding(.top,30)
                    }
                    
                    
                    Spacer()
                    
                    
                    if self.destination != nil && self.show{
                        
                        ZStack(alignment: .topTrailing){
                            
                            VStack(spacing: 20){
                                
                                HStack{
                                    
                                    VStack(alignment: .leading,spacing: 15){
                                        
                                        Text("Hedef")
                                            .fontWeight(.bold)
                                        Text(self.name)
                                        
                                        Text("Mesafe - "+self.distance+" KM")
                                        
                                        Text("Tahmini Varış - "+self.time + " Dk")
                                    }
                                    
                                    Spacer()
                                }
                                
                                Button(action: {
                                    
                                    self.loading.toggle()
                                    
                                    self.Book()
                                    
                                }) {
                                    
                                    Text("Çağır")
                                        .foregroundColor(Color("main2"))
                                        .padding(.vertical, 10)
                                        .frame(width: UIScreen.main.bounds.width / 2)
                                }
                                .background(Color("main2").opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                .padding([.horizontal, .bottom])
                            
                            }
                            
                            Button(action: {
                                
                                self.map.removeOverlays(self.map.overlays)
                                self.map.removeAnnotations(self.map.annotations)
                                self.destination = nil
                                
                                self.show.toggle()
                                
                            }) {
                                
                                Image(systemName: "xmark")
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        //.padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .padding([.horizontal,.bottom])
                        
                    }
                }
                
                
            }
            
            if self.loading{
                
                Loader()
            }
            
            if self.book{
                
                Booked(data: self.$data, doc: self.$doc, loading: self.$loading, book: self.$book)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.black.opacity(0.2))

            }
            
            if self.search{
                
                SearchView(show: self.$search, map: self.$map, source: self.$source, destination: self.$destination, name: self.$name, distance: self.$distance, time: self.$time,detail: self.$show)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
        }
        .edgesIgnoringSafeArea(.all)
        .alert(isPresented: self.$alert) { () -> Alert in
            
            Alert(title: Text("Error"), message: Text("Please Enable Location In Settings !!!"), dismissButton: .destructive(Text("Ok")))
        }
    }
    
    func Book(){
        
        let db = Firestore.firestore()
        let doc = db.collection("Booking").document()
        self.doc = doc.documentID
        
        let from = GeoPoint(latitude: self.source.latitude, longitude: self.source.longitude)
        let to = GeoPoint(latitude: self.destination.latitude, longitude: self.destination.longitude)
        var userInfo: String = ""
        guard let user = authVm.currentUser else {
            return
        }
        userInfo = "\(user.ad) \(user.soyad)"
        doc.setData(["name":userInfo,"from":from,"authorUid": user.id ,"to":to,"distance":self.distance,"fair": (self.distance as NSString).floatValue * 1.2]) { (err) in
            
            if err != nil{
                
                print((err?.localizedDescription)!)
                return
            }
            
            
            let filter = CIFilter(name: "CIQRCodeGenerator")
            filter?.setValue(self.doc.data(using: .ascii), forKey: "inputMessage")
            
            let image = UIImage(ciImage: (filter?.outputImage?.transformed(by: CGAffineTransform(scaleX: 5, y: 5)))!)
            
            self.data = image.pngData()!
            
            
            self.loading.toggle()
            self.book.toggle()
            
        }
    }
}
