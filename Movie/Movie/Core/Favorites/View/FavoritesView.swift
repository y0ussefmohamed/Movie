//
//  FavoritesView.swift
//  Movie
//
//  Created by Youssef Mohamed on 20/03/2024.
//

import SwiftUI

struct FavoritesView: View 
{
    @EnvironmentObject var viewModel: FavoriteMoviesViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.15, green: 0.16, blue: 0.24).ignoresSafeArea(edges: .all)
                VStack {
                    HStack {
                        HStack {
                            Text("Favorites")
                                .font(.title)
                                .fontWeight(.heavy)
                            Image(systemName: "heart.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(.red)
                        }
                        
                        
                        Spacer()
                    }.bold().foregroundStyle(.white).padding()
                    
                    ScrollView {
                        ForEach(viewModel.favoriteMovies) { movie in
                            NavigationLink(destination: MovieDetailView(movie: movie,isFavorite: true)) {
                                LongMovieView(movie: movie)
                            }
                        }.onDelete(perform: viewModel.removeFromFavorites )
                        .background(Color(red: 0.15, green: 0.16, blue: 0.24).ignoresSafeArea())
                        

                        Spacer()
                    }.scrollIndicators(.never)
                }
            }
        }
    }
}



#Preview {
    FavoritesView()
        .environmentObject(FavoriteMoviesViewModel())
}
