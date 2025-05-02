//
//  SearchView.swift
//  Movie
//
//  Created by Youssef Mohamed on 21/03/2024.
//

import SwiftUI

struct SearchView: View {
    @StateObject var moviesViewModel = MoviesViewModel()
    
    @State var searchText: String = ""
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    var body: some View {
        ZStack {
            Color(red: 0.15, green: 0.16, blue: 0.24).ignoresSafeArea(edges: .all)
            VStack {
                        HStack {
                            TextField("Search", text: $searchText)
                                .onChange(of: searchText) {
                                    Task {
                                        if(searchText.count < 3) {
                                            do {
                                                try await moviesViewModel.getSearchedMovies(withQuery: searchText)
                                                print("Using Query \(searchText)")
                                            } catch {
                                                print("Error fetching movie with searchText: \(searchText)")
                                            }
                                        }
                                    }
                                }
                            Spacer()
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.gray)
                        }.padding().background(Color(red: 0.24, green: 0.25, blue: 0.35)).cornerRadius(20).padding()
                        
                        ScrollView(.vertical) {
                            LazyVGrid(columns: columns,spacing: 10) {
                                ForEach(moviesViewModel.searchedMoviesWithQuery) { movie in
                                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                                        SmallMovieCard(movie: movie)
                                            .padding(.trailing)
                                    }.foregroundStyle(.white)
                                }
                            }
                        }
                    }
        }
        
    }
}

#Preview {
    SearchView()
}
