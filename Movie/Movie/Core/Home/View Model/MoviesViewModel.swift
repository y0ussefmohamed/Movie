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
    
    init() {
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
        self.nowInCinemaMovies = try await MoviesService.shared.getNowInCinemaMovies()
    }
    
    func getTrendingMovies() async throws {
        self.trendingMovies = try await MoviesService.shared.getTrendingMovies()
    }
    
    func getUpcomingMovies() async throws {
        self.upcomingMovies = try await MoviesService.shared.getUpcomingMovies()
    }
    
    func getTopRatedMovies() async throws {
        self.topRatedMovies = try await MoviesService.shared.getTopRatedMovies()
    }
    
    func getSearchedMovies(withQuery movieName: String) async throws {
        self.searchedMoviesWithQuery = try await MoviesService.shared.search(for: movieName)
    }
    
    func getMovieCast(forMovieID: Int) async throws { // use it in the movieDetailView.task{} with movieID
        self.movieCast = try await MoviesService.shared.getMovieCast(movieID: forMovieID)
    }
}
