//
//  MainView.swift
//  Dellvia
//
//  Created by Bora Erdem on 15.08.2022.
//

import SwiftUI

struct MainView: View {
    @State var goMap: Bool = false
    var h = Home()
    var body: some View {
        ZStack{
            Color("bg").ignoresSafeArea()
                VStack{
                    Text("dellvia")
                        .foregroundColor(Color("main"))
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.light)
                    mapView
                    
                    Text("Aktif Çağrılarım").font(.system(.body, design: .rounded))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical,32)
                    
                    Spacer()
                    
                    
                        
                        
                }
                .fullScreenCover(isPresented: $goMap, content: {
                    Home()
                })
                .padding([.horizontal, .top], 32)
                .navigationBarHidden(true)
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

extension MainView{
    private var mapView: some View {
       
        ZStack{
            MapView(map: h.$map, manager: h.$manager, alert: h.$alert, source: h.$source, destination: h.$destination, name: h.$name, distance: h.$distance, time: h.$time, show: h.$show)
                .onAppear {
                    h.manager.requestAlwaysAuthorization()
                }
            Color("main").opacity(0.0)
        }
        .frame(maxHeight: 175)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .onTapGesture {
            goMap.toggle()
        }
        .shadow(color: .black.opacity(0.1), radius: 50, x: 0, y: 4)
      

                
    }
}
