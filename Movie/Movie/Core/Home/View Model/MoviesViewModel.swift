import Foundation


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
    
    
    @MainActor
    func getNowInCinemaMovies() async throws {
        self.nowInCinemaMovies = try await MoviesService.shared.getNowInCinemaMovies()
    }
    
    @MainActor
    func getTrendingMovies() async throws {
        self.trendingMovies = try await MoviesService.shared.getTrendingMovies()
    }
    
    @MainActor
    func getUpcomingMovies() async throws {
        self.upcomingMovies = try await MoviesService.shared.getUpcomingMovies()
    }
    
    @MainActor
    func getTopRatedMovies() async throws {
        self.topRatedMovies = try await MoviesService.shared.getTopRatedMovies()
    }
    
    @MainActor
    func getSearchedMovies(withQuery movieName: String) async throws {
        self.searchedMoviesWithQuery = try await MoviesService.shared.search(for: movieName)
    }
    
    @MainActor
    func getMovieCast(forMovieID: Int) async throws { // use it in the movieDetailView.task{} with movieID
        self.movieCast = try await MoviesService.shared.getMovieCast(movieID: forMovieID)
    }
}
