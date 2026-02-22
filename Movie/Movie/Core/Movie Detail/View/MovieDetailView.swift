import SwiftUI

// Color(red: 0.83, green: 0.83, blue: 0.95)
// Color(red: 0.24, green: 0.25, blue: 0.35)

struct MovieDetailView: View
{
    @State private var cast: [CastMember] = []
    let movie: Movie
    @StateObject var moviesViewModel = MoviesViewModel(moviesService: MoviesService())
    @State var isFavorite = false
    
    var body: some View {
        ZStack {
            Color(red: 0.15, green: 0.16, blue: 0.24).ignoresSafeArea(edges: .all)
            
                ScrollView(.vertical) {
                    VStack {
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w780/\(movie.backdrop_path!)" )) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height / 2.1 - 20)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        } placeholder: {
                            ZStack {
                                Rectangle()
                                    .foregroundStyle(Color(.systemGray3))
                                    .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height / 2.1 - 20)
                                    .cornerRadius(20)
                                ProgressView()
                            }
                        }
                        
                        HStack {
                            Text(movie.original_title ?? movie.title ?? "Movie" )
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            VStack(alignment:.trailing) {
                                HStack {
                                    
                                    Image(systemName: "hand.thumbsup.fill")
                                        .foregroundStyle(.yellow)
                                    Text(String(format: "%.1f", movie.vote_average ?? 0.0))
                                        .font(.footnote)
                                        .bold()
                                        .foregroundStyle(.yellow)
                                    
                                    Text("(\(movie.vote_count ?? 141))")
                                        .font(.footnote)
                                        .foregroundStyle(.gray)
                                }.padding(.horizontal)
                                
                                HStack {
                                    Spacer()
                                    HStack {
                                        Image(systemName: "calendar")
                                        Text(movie.release_date ?? "2024 - 01 - 01")
                                    }.foregroundStyle(Color(.systemGray))
                                }.padding(.horizontal)
                            }
                            
                        }.padding([.top,.horizontal])
                        
                        
                        VStack {
                            HStack {
                                Text("About film")
                                    .font(.title3)
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                                Spacer()
                                Text("See all")
                                    .foregroundStyle(.gray)
                                    .font(.footnote)
                            }.padding()
                            
                            Text("\(movie.overview ?? "")").padding(.horizontal)
                                .foregroundStyle(.white)
                                .lineLimit(2)
                        }
                        
                        VStack {
                            HStack {
                                Text("Cast & Crew")
                                    .font(.title3)
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                                Spacer()
                                Text("See all")
                                    .foregroundStyle(.gray)
                                    .font(.footnote)
                            }.padding()
                            
                            ScrollView(.horizontal) {
                                LazyHStack {
                                    // Fetch and display cast members for the current movie
                                    ForEach(moviesViewModel.movieCast.prefix(10),id: \.self) { member in
                                        
                                        if member.profile_path != nil {
                                            VStack(alignment: .leading) {
                                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original/\( member.profile_path ?? "rtCx0fiYxJVhzXXdwZE2XRTfIKE.jpg")" )) { image in
                                                    image
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 150,height: 150)
                                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                                } placeholder: {
                                                    ZStack {
                                                        Rectangle()
                                                            .foregroundStyle(Color(.systemGray3))
                                                            .frame(width: 150,height: 150)
                                                            .cornerRadius(20)
                                                        ProgressView()
                                                    }
                                                }
                                                
                                                Text(member.original_name ?? member.name ?? "Zax")
                                                    .foregroundStyle(.white)
                                            }
                                        } else {
                                            VStack {
                                                ZStack {
                                                    Rectangle()
                                                        .foregroundStyle(Color(.systemGray3))
                                                        .frame(width: 150,height: 150)
                                                        .cornerRadius(20)
                                                    ProgressView()
                                                }
                                                Text(member.original_name ?? member.name ?? "Zax")
                                            }
                                        }
                                        
                                    }
                                    
                                }.padding(.horizontal)
                            }.scrollIndicators(.never)
                        }
                        
                        
                        Spacer()
                    }
                }.scrollIndicators(.never).navigationBarBackButtonHidden(true)
                    .navigationBarItems(leading: CustomBackButtonView())
                    .navigationBarItems(trailing: CustomHeartButton(isFavorite: isFavorite)).ignoresSafeArea(edges:.top)
                    .task {
                        do {
                            try await moviesViewModel.getMovieCast(forMovieID: movie.id)
                        } catch {
                            print("Error fetching movie cast: \(error)")
                        }
                    }
                
            VStack {
                Spacer()
                Button {
                    DownloadsService.shared.addToDownloads(movie: movie)
                    print("\(movie.title!) Downloaded")
                } label: {
                    Text("Download")
                        .foregroundStyle(Color(red: 0.15, green: 0.16, blue: 0.24))
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding()
                        .background(Color(red: 0.83, green: 0.83, blue: 0.95))
                        .cornerRadius(20).padding()
                }
            }

        }
    }
}

#Preview {
    MovieDetailView(movie: Movie(id: 1, title: "Dummy Movie 1", original_title: "Original Dummy Movie 1", backdrop_path: "dn3gbDpXPSwC6saMJOHkCiFA9jn.jpg", overview: "This is a dummy overview for Dummy Movie 1", vote_count: 100, release_date: "2023-01-01", vote_average: 7.5, popularity: 80.0) )
}
