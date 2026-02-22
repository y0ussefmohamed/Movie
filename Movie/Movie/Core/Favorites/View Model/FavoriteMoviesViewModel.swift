import Foundation


class FavoriteMoviesViewModel: ObservableObject 
{
    let favoriteMoviesKey = "favorite_movies"
    
    @Published var favoriteMovies: [Movie] = []
    @Published var downloadedMovies: [Movie] = []
    
    init() {
        getCurrentUserFavoriteMovies()
    }
    
    func getCurrentUserFavoriteMovies() {
        // get data from db and then decode it
        guard let currentUserFavoriteMoviesEncodedData = UserDefaults.standard.data(forKey: favoriteMoviesKey) else {return}
        guard let savedFavoriteMovies = try? JSONDecoder().decode([Movie].self, from: currentUserFavoriteMoviesEncodedData) else {return}
        
        self.favoriteMovies = savedFavoriteMovies
    }
    
    
    func removeFromFavorites(indexSet: IndexSet) {
        self.favoriteMovies.remove(atOffsets: indexSet)
        saveFavoriteMovies()
    }
    
    func removeFromFavorites(movie: Movie) {
        if let index = self.favoriteMovies.firstIndex(where: { $0 == movie }) {
            self.favoriteMovies.remove(at: index)
        }
        saveFavoriteMovies()
    }
    
    func addToFavorites(movie: Movie) {
        favoriteMovies.insert(movie,at: 0)
        saveFavoriteMovies()
    }
    
    func saveFavoriteMovies() {
        if let encodeDataToJSON = try? JSONEncoder().encode(favoriteMovies) {
            UserDefaults.standard.set(encodeDataToJSON, forKey: favoriteMoviesKey)
        }
    }
}
