import SwiftUI


struct HomeView: View
{
    @StateObject var moviesViewModel = MoviesViewModel()
    @State var searchText = ""
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.15, green: 0.16, blue: 0.24).ignoresSafeArea(edges: .all)
                
                VStack {
                    // Profile and Logout
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(.white)
                        
                        VStack(alignment: .leading) {
                            Text("Welcome,")
                                .foregroundStyle(Color(red: 0.83, green: 0.83, blue: 0.95))
                                .fontWeight(.semibold)
                            
                            if AuthService.shared.currentUser?.fullname == nil {
                                Text("Youssef Mohamed")
                                    .font(.title2)
                                    .foregroundStyle(.white)
                                    .fontWeight(.heavy)
                            } else {
                                Text("\(AuthService.shared.currentUser?.fullname ?? "Joe")")
                                    .foregroundStyle(.white)
                                    .fontWeight(.semibold)
                            }
                            
                        }
                        Spacer()
                        
                        Button {
                            AuthService.shared.logout()
                        } label: {
                            Image(systemName: "arrow.forward.square.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.gray)
                        }
                    }.padding()
                    
                    
                    ScrollView(.vertical) {
                        
                        // Search
                        NavigationLink(destination: SearchView()) {
                            HStack {
                                Text("Search")
                                Spacer()
                                Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    
                            }.foregroundStyle(.gray).padding().background(Color(red: 0.24, green: 0.25, blue: 0.35)).cornerRadius(20).padding()
                        }
                        
                        
                        
                        VStack {
                            HStack {
                                Text("Now in Cinema")
                                    .font(.title3)
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                                Spacer()
                                Text("See all")
                                    .foregroundStyle(.gray)
                                    .font(.footnote)
                            }.padding()
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(moviesViewModel.nowInCinemaMovies) { movie in
                                        NavigationLink {
                                            MovieDetailView(movie: movie)
                                        } label: {
                                            SmallMovieCard(movie: movie)
                                                .foregroundStyle(.white)
                                                .padding([.bottom,.leading])
                                        }

                                    }
                                }
                            }
                        }
                        
                        
                        VStack {
                            HStack {
                                Text("Trending")
                                    .font(.title3)
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                                Spacer()
                                Text("See all")
                                    .foregroundStyle(.gray)
                                    .font(.footnote)
                            }.padding()
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(moviesViewModel.trendingMovies){ movie in
                                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                                            SmallMovieCard(movie: movie)
                                                .padding(.trailing)
                                        }.foregroundStyle(.white)
                                    }
                                }.padding([.bottom,.leading])
                            }.scrollIndicators(.never)
                        }
                        
                        
                        VStack {
                            HStack {
                                Text("Upcoming")
                                    .font(.title3)
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                                Spacer()
                                Text("See all")
                                    .foregroundStyle(.gray)
                                    .font(.footnote)
                            }.padding()
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(moviesViewModel.upcomingMovies){ movie in
                                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                                            SmallMovieCard(movie: movie)
                                                .padding(.trailing)
                                        }.foregroundStyle(.white)
                                    }
                                }.padding([.bottom,.leading])
                            }.scrollIndicators(.never)
                        }
                        
                        VStack {
                            HStack {
                                Text("Top Rated")
                                    .font(.title3)
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                                Spacer()
                                Text("See all")
                                    .foregroundStyle(.gray)
                                    .font(.footnote)
                                    .onTapGesture {
                                        print("See all in Top Rated")
                                    }
                            }.padding()
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(moviesViewModel.topRatedMovies){ movie in
                                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                                            SmallMovieCard(movie: movie)
                                                .padding(.trailing)
                                        }.foregroundStyle(.white)
                                    }
                                }.padding([.bottom,.leading])
                            }.scrollIndicators(.never)
                        }
                        
                    }.scrollIndicators(.never)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
