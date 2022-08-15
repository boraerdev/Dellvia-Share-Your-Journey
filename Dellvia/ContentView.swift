//
//  ContentView.swift
//  Dellvia
//
//  Created by Bora Erdem on 15.08.2022.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject var authVm : AuthViewModel
    var body: some View {
        if authVm.userSession != nil {
            TabView()
                .environmentObject(authVm)
        }else {
            LoginPage()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabView()
            .environmentObject(AuthViewModel())
    }
}
