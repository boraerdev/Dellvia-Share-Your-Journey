//
//  DetailView.swift
//  Dellvia
//
//  Created by Bora Erdem on 15.08.2022.
//

import SwiftUI
import Kingfisher
import Firebase

struct DetailView: View {
    var call: Call
    @Environment (\.presentationMode) var presentationMode
    var body: some View {
        ZStack{
            Color("bg").ignoresSafeArea()
            
            ScrollView{
                VStack(spacing:20){
                    KFImage(URL(string: call.qrUrl)!)
                        .resizable()
                        .frame(width: 250, height: 250)
                        .padding()
                        .background(.white, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .shadow(color: .black.opacity(0.1), radius: 50, x: 0, y: 4)
                        .padding(.top,40)
                    
                    VStack{
                        
                        Text("\(String(format: "%.2f", call.fair))₺")
                            .font(.largeTitle)
                            .foregroundColor(Color("main"))
                            .padding()
                        
                        VStack{
                            HStack(alignment: .bottom){
                                Text("Nereye:")
                                Text("\(call.distance) KM").bold()
                            }
                            .font(.system(.footnote, design: .rounded))
                            .foregroundColor(Color("secondary"))

                            Text(call.destinationName)
                                .font(.system(.title2, design: .rounded))
                                .multilineTextAlignment(.center)
                        }
                        VStack{
                            Text(call.authorName)
                            Text(call.timestamp.formatted(date: .abbreviated, time: .shortened))
                        }
                            .font(.system(.footnote, design: .rounded))
                            .foregroundColor(Color("secondary"))
                    }
                    
                    HStack{
                        Button(action: {
                                                    
                            let db = Firestore.firestore()
                            ImageServices.shared.delImage(url: call.qrUrl)
                            db.collection("Booking").document(call.doc).delete { (err) in
                                
                                if err != nil{
                                    
                                    print((err?.localizedDescription)!)
                                    return
                                }
                                
                            }
                            
                        }) {
                            
                            Text("İptal")
                                .foregroundColor(Color("main2"))
                                .padding(.vertical,10)
                                .frame(width: UIScreen.main.bounds.width / 2)
                            
                            
                        }
                        .background(Color("main2").opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        
                    }
                    
                    VStack(spacing:20){
                        HStack{
                            Image(systemName: "person.badge.clock")
                                .foregroundColor(Color("main"))
                            Text("Yolculuk teklifin güzargaha yakın sürücülere iletildi. Kabul eden olduğunda bir bildirim alacaksın.")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(.footnote, design: .rounded))
                                .padding()
                        }
                        .padding()
                        .background(.white, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                        
                        HStack{
                            Image(systemName: "info")
                                .foregroundColor(Color("main"))
                            Text("Yukarıdaki QR kod ödemeni tamamlanmak için kullanılacak. Yolculuğun sona erdiğinde hizmetverenin telefonuna QR kodu okutmayı unutma, yukarıda belirtilen ücret otomatik olarak kayıtlı kredi kartından tahsil edilerek hizmetverene aktarılacak.")
                                .font(.system(.footnote, design: .rounded))
                                .padding()
                        }
                        .padding()
                        .background(.white, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                    }
                    
                    Spacer()
                }
                .padding(32)

            }
            
            
            VStack{
                HStack{
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(Color("main"))
                        .padding(8)
                        .background(Color("main").opacity(0.2), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                    Spacer()

                }
                Spacer()
            }
            .padding()
        }
        
    }
}

