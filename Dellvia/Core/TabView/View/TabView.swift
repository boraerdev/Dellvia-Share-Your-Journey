//
//  MainView.swift
//  Dellvia
//
//  Created by Bora Erdem on 15.08.2022.
//

import SwiftUI
import MapKit


struct TabView: View {
    @State var selectedTab: tabCases = .home
    @State var goMapView: Bool = false
    
    var body: some View {
        ZStack{
            
            switch selectedTab {
            case .home:
                MainView()
            case .add:
                EmptyView()
            case .gear:
                SettingView()
            }
            
            tabBarView
        }
        .fullScreenCover(isPresented: $goMapView) {
            Home()
        }
    }
}

enum tabCases: String, CaseIterable {
    case home = "house"
    case add = "plus"
    case gear = "gear"
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView()
            .environmentObject(AuthViewModel())
    }
}

extension TabView {
    

    
    
    
    private var tabBarView: some View {
        VStack{
            Spacer()
            HStack{
                ForEach(tabCases.allCases, id: \.self) { tab in
                    Image(systemName: tab.rawValue)
                        .padding()
                        .offset(y: tab.rawValue == "plus" ? -20: 0)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(selectedTab == tab ? Color("main"): Color("secondary"))
                        .font(tab.rawValue == "plus" ? .largeTitle : .title2)
                        .onTapGesture {
                            selectedTab = tab
                            if tab == .add {
                                goMapView.toggle()
                                selectedTab = .home
                            }
                        }
                }
            }
            .background(.white, in: tabBar())
            .shadow(color: .black.opacity(0.1), radius: 50, x: 0, y: 4)
        }
        .padding()
    }
}


