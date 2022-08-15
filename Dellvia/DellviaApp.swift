//
//  DellviaApp.swift
//  Dellvia
//
//  Created by Bora Erdem on 15.08.2022.
//

import SwiftUI
import FirebaseCore

@main
struct DellviaApp: App {
    
    @StateObject var authVm = AuthViewModel()
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authVm)
        }
    }
}
