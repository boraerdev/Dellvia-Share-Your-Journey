//
//  SettingView.swift
//  Dellvia
//
//  Created by Bora Erdem on 15.08.2022.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var authVm : AuthViewModel
    var body: some View {
        ZStack{
            Color("bg").ignoresSafeArea()
            VStack{
                Text("Çıkış Yap")
                    .foregroundColor(Color("main2"))
                    .padding()
                    .padding(.horizontal)
                    .onTapGesture {
                        authVm.logOut()
                    }
            }
        }
    }
}

