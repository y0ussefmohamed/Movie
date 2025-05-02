//
//  ContentView.swift
//  Movie
//
//  Created by Youssef Mohamed on 19/03/2024.
//

import SwiftUI

struct ContentView: View 
{
    
    var body: some View {
        Group {
//            if AuthService.shared.isUserLoggedIn == false || AuthService.shared.isUserLoggedIn == nil {
//                LoginView()
//            } else {
                TabBar()
//            }
        }
    }
}

#Preview {
    ContentView()
}
