import Foundation


class DownloadsService {
    let downloadedMovieskey = "downloaded_movies_key"
    
    static let shared = DownloadsService()
    
    func getCurrentUserDownloadedMovies() -> [Movie] {
        guard let currentUserDownloadedMoviesEncodedData = UserDefaults.standard.data(forKey: downloadedMovieskey) else { return [] }
        guard let savedDownloadedMovies = try? JSONDecoder().decode([Movie].self, from: currentUserDownloadedMoviesEncodedData) else { return [] }
        
        return savedDownloadedMovies
    }
    
    func saveDownloadedMovies(movies: [Movie]) {
        if let encodeDataToJSON = try? JSONEncoder().encode(movies) {
            UserDefaults.standard.set(encodeDataToJSON, forKey: downloadedMovieskey)
        }
    }
    
    func addToDownloads(movie: Movie) {
        var downloadedMovies = getCurrentUserDownloadedMovies()
        downloadedMovies.insert(movie,at: 0)
        saveDownloadedMovies(movies: downloadedMovies)
    }
}

