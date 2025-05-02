import Foundation


class DownloadsViewModel: ObservableObject 
{
    @Published var downloadedMovies: [Movie] = []
        
    init() {
        setupDownloadedMovies()
    }
    
    func setupDownloadedMovies() {
        downloadedMovies = DownloadsService.shared.getCurrentUserDownloadedMovies()
    }
    
    func removeFromDownloads(indexSet: IndexSet) {
        downloadedMovies.remove(atOffsets: indexSet)
        DownloadsService.shared.saveDownloadedMovies(movies: downloadedMovies)
    }
}

