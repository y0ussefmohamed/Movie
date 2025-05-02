//
//  SmallMovieCard.swift
//  Movie
//
//  Created by Youssef Mohamed on 19/03/2024.
//

import SwiftUI

struct SmallMovieCard: View
{
    @State var isFavorite = false
    @EnvironmentObject var viewModel: FavoriteMoviesViewModel
    let movie: Movie
    var body: some View {
        
        
        VStack(spacing: 0) {
            
            if let moviePoster = movie.backdrop_path {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w780/\(moviePoster)" )) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200,height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                } placeholder: {
                    ZStack {
                        Rectangle()
                            .foregroundStyle(Color(.systemGray3))
                            .frame(width: 200,height: 200)
                            .cornerRadius(20)
                        ProgressView()
                    }
                }
                  
            } else {
                ZStack {
                    Rectangle()
                        .foregroundStyle(Color(.systemGray3))
                        .frame(width: 200,height: 200)
                        .cornerRadius(20)
                    ProgressView()
                }
            }
              
            
            ZStack {
                Rectangle()
                    .frame(width: 200,height: 70)
                    .cornerRadius(20)
                    .foregroundStyle(Color(red: 0.24, green: 0.25, blue: 0.35))
                
                VStack{
                    HStack {
                        Text(movie.original_title ?? movie.title ?? "X")
                            .bold()
                        Spacer()
                        Button {
                            isFavorite.toggle()
                            if isFavorite {
                                viewModel.addToFavorites(movie: movie)
                            } else {
                                viewModel.removeFromFavorites(movie: movie)
                            }
                        } label: {
                            Image(systemName: "heart.fill")
                                .foregroundStyle( isFavorite ? .red : Color(.systemGray))
                        }
                        
                    }.padding(5).padding(.top,7).padding(.horizontal,8)
                        .frame(width: 200)
                    
                    HStack {
                        HStack{
                            Image(systemName: "hand.thumbsup.fill")
                            Text(String(format: "%.1f" , movie.vote_average ?? 0.0 ))
                                .font(.footnote)
                                .bold()
                        }.foregroundStyle(.yellow)
                        Spacer()
                        HStack {
                            Image(systemName: "calendar")
                            Text(movie.release_date ?? " - - -")
                            
                        }.foregroundStyle(Color(.systemGray)).font(.footnote)
                        
                    }.padding(5).padding(.bottom,5).padding(.horizontal,8)
                        .frame(width: 200)
                }.frame(height: 70)
                
            }
            
        }
        
        
    }
}

#Preview {
    SmallMovieCard(movie: Movie(id: 1, title: "Dummy Movie 1", original_title: "Original Dummy", backdrop_path: "dummy_poster_1.jpg", overview: "This is a dummy overview for Dummy Movie 1", vote_count: 100, release_date: "2023-01-01", vote_average: 7.5, popularity: 80.0))
        .environmentObject(FavoriteMoviesViewModel())
}
