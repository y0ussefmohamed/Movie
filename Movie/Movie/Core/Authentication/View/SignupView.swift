//
//  LoginView.swift
//  Movie
//
//  Created by Youssef Mohamed on 19/03/2024.
//

import SwiftUI

struct SignupView: View
{
    @Environment(\.presentationMode) var presentationMode
    
    @State var email = ""
    @State var password = ""
    @State var fullname = ""
    
    @State private var isPasswordVisible = false
    
    @StateObject var viewModel = SignupViewModel()
    var body: some View {
        ZStack {
            Color(red: 0.15, green: 0.16, blue: 0.24).ignoresSafeArea(edges: .all)
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Signup")
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
                    
                }.padding(40).padding(.top,80)
                
                Spacer()
                ZStack {

                    
                    VStack {
                        HStack {
                            Image(systemName: "person")
                                .foregroundStyle(.gray)
                            TextField("Enter your full name", text: $viewModel.fullname)
                                .foregroundStyle(.black)
                            Spacer()
                        }.padding().background(.white)
                            .cornerRadius(25)
                            .padding([.bottom,.horizontal],40)
                        
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
                                   
                            } else {
                                SecureField("Enter your Password", text: $viewModel.password)
                                    
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
                        
                        Spacer()
                    }.padding(.top,30)
                    
                    VStack {
                        Spacer()
                        Button {
                            Task {
                                try await viewModel.createUser()
                            }
                        } label: {
                            HStack {
                                Spacer()
                                Text("Signup")
                                    .font(.title2)
                                    .foregroundStyle(Color(red: 0.15, green: 0.16, blue: 0.24))
                                    .fontWeight(.semibold)
                                Spacer()
                            }.padding().background(Color(red: 0.83, green: 0.83, blue: 0.95)).cornerRadius(25).padding(.horizontal , 40)
                        }
                        
                        HStack {
                            Text("Already Have an Account?")
                                .foregroundStyle(.white)
                            
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Text("Login")
                                    .fontWeight(.bold)
                            }
                        }
                        
                    }
                    
                    
                }
                
            }
        }.navigationBarBackButtonHidden()
        
    }
}


#Preview {
    SignupView()
}
