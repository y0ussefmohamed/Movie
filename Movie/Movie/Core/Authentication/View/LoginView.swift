//
//  LoginView.swift
//  Movie
//
//  Created by Youssef Mohamed on 19/03/2024.
//

import SwiftUI

struct LoginView: View 
{
    @State private var showAlert = false
    
    @StateObject var viewModel = LoginViewModel()
    
    @State private var isPasswordVisible = false
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.15, green: 0.16, blue: 0.24).ignoresSafeArea(edges: .all)
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Login")
                                .foregroundStyle(.white)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            
                            Text("Best Movie Database App")
                                .foregroundStyle(.gray)
                                .italic()
                            Text("Option")
                                .foregroundStyle(.gray)
                                .italic()
                        }
                        Spacer()
                        
                    }.padding(40).padding(.top,100)
                    
                    Spacer()
                    ZStack {

                        
                        VStack {
                            
                            HStack {
                                Image(systemName: "envelope")
                                    .foregroundStyle(.gray)
                                TextField("Enter your Email", text: $viewModel.email)
                                    .foregroundStyle(.black)
                                Spacer()
                            }.padding().background(.white)
                                .cornerRadius(25)
                                .padding([.bottom,.horizontal],40)
                                
                            
                            HStack {
                                Image(systemName: "lock")
                                    .foregroundStyle(.gray)
                                if isPasswordVisible {
                                    TextField("Enter your Password", text: $viewModel.password)
                                        .foregroundStyle(.black)
                                } else {
                                    SecureField("Enter your Password", text: $viewModel.password)
                                        .foregroundStyle(.black)
                                }
                                
                                Spacer()
                                Button {
                                    isPasswordVisible.toggle()
                                } label: {
                                    Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                                        .foregroundStyle(.gray)
                                }
                                
                            }.padding().background(.white)
                                .cornerRadius(25)
                                .padding([.horizontal],40)
                            HStack {
                                Spacer()
                                Button {
                                    showAlert = true
                                } label: {
                                    Text("Forget Password?")
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.blue)
                                        .underline()
                                }
                                
                            }.padding(.horizontal,40)
                            Spacer()
                        }.padding(.top,30)
                        
                        VStack {
                            Spacer()
                            Button{
                                Task {
                                    try await viewModel.login()
                                }
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("Login")
                                        .font(.title2)
                                        .foregroundStyle(Color(red: 0.15, green: 0.16, blue: 0.24))
                                        .fontWeight(.semibold)
                                    Spacer()
                                }.padding().background(Color(red: 0.83, green: 0.83, blue: 0.95)).cornerRadius(25).padding(.horizontal , 40)
                            }
                            
                            HStack {
                                Text("New User?")
                                    .foregroundStyle(.white)
                                
                                NavigationLink(destination: SignupView()) {
                                    Text("Signup")
                                        .foregroundStyle(.blue)
                                        .fontWeight(.bold)
                                }
                                
                            }
                            
                        }
                        
                        
                    }
                    
                }.alert(isPresented: $showAlert) {
                    Alert(title: Text("Check your Mail ✉️"))
                }
            }.navigationBarBackButtonHidden()
        }
       
        
    }
}


#Preview {
    LoginView()
}
