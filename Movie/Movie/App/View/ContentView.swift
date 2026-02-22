//
//  ContentView.swift
//  Movie
//
//  Created by Youssef Mohamed on 19/03/2024.
//

import SwiftUI

struct ContentView: View 
{
    @ObservedObject var authService = AuthService.shared
    
    var body: some View {
        Group {
            if authService.currentUser != nil {
                TabBar()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
