import Foundation


@MainActor
class MoviesViewModel: ObservableObject
{
    @Published var nowInCinemaMovies: [Movie] = []
    @Published var trendingMovies: [Movie] = []
    @Published var upcomingMovies: [Movie] = []
    @Published var topRatedMovies: [Movie] = []
    @Published var searchedMoviesWithQuery: [Movie] = []
    @Published var movieCast: [CastMember] = []
    
    let moviesService: MoviesService
    
    init(moviesService: MoviesService) {
        self.moviesService = moviesService
        
        Task {
            do {
                try await self.getNowInCinemaMovies()
                try await self.getTrendingMovies()
                try await self.getUpcomingMovies()
                try await self.getTopRatedMovies()
            }
        }
    }
    
    func getNowInCinemaMovies() async throws {
        self.nowInCinemaMovies = try await moviesService.getNowInCinemaMovies()
    }
    
    func getTrendingMovies() async throws {
        self.trendingMovies = try await moviesService.getTrendingMovies()
    }
    
    func getUpcomingMovies() async throws {
        self.upcomingMovies = try await moviesService.getUpcomingMovies()
    }
    
    func getTopRatedMovies() async throws {
        self.topRatedMovies = try await moviesService.getTopRatedMovies()
    }
    
    func getSearchedMovies(withQuery movieName: String) async throws {
        self.searchedMoviesWithQuery = try await moviesService.search(for: movieName)
    }
    
    func getMovieCast(forMovieID: Int) async throws { // use it in the movieDetailView.task{} with movieID
        self.movieCast = try await moviesService.getMovieCast(movieID: forMovieID)
    }
}
