//
//  DownloadsView.swift
//  Movie
//
//  Created by Youssef Mohamed on 20/03/2024.
//

import SwiftUI

struct DownloadsView: View {
    @ObservedObject var viewModel = DownloadsViewModel()
    
    var body: some View {
        ZStack {
            Color(red: 0.15, green: 0.16, blue: 0.24).ignoresSafeArea(edges: .all)
            
            VStack {
                HStack {
                    Text("Downloads 🍿")
                        .font(.title)
                        .fontWeight(.heavy)
                    
                    Spacer()
                }.bold().foregroundStyle(.white).padding()
                
                ScrollView {
                    // get array from view model but can append data in the array from service
                    ForEach(viewModel.downloadedMovies) { movie in
                            LongMovieView(movie: movie)
                    }.onDelete(perform: viewModel.removeFromDownloads )
                    .background(Color(red: 0.15, green: 0.16, blue: 0.24).ignoresSafeArea())
                    

                    Spacer()
                }.scrollIndicators(.never)
            }
        }
    }
}

#Preview {
    DownloadsView()
}
