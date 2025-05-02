//
//  CustomBackButtonView.swift
//  Movie
//
//  Created by Youssef Mohamed on 20/03/2024.
//

import SwiftUI

struct CustomBackButtonView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            // You can add custom behavior here, like navigating to a specific view.
        }) {
            Image(systemName: "chevron.left")
                .foregroundStyle(.white)
                .padding()
        }
    }
}

#Preview {
    CustomBackButtonView()
}
