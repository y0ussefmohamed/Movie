//
//  CustomHeartButton.swift
//  Movie
//
//  Created by Youssef Mohamed on 20/03/2024.
//

import SwiftUI

struct CustomHeartButton: View {
    @State var isFavorite = false
    var body: some View {
        Button(action: {
            isFavorite.toggle()
        }) {
            Image(systemName: "heart.fill")
                .foregroundStyle( isFavorite ? .red : Color(.systemGray))
                .padding()
        }
    }
}

#Preview {
    CustomHeartButton()
}
