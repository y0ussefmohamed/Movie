import Foundation

enum MoviesError: Error {
    case decodingError
    case networkError
}

// call API Here
struct MoviesService 
{
    static let shared = MoviesService()
    
    @MainActor
    func getNowInCinemaMovies() async throws -> [Movie] {
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=39d7b5254926a27f20f39c1509a22ee8&with_release_type=2|3") else {
            throw MoviesError.networkError
        }
        
        let movieData = try await URLSession.shared.data(from: url).0 // first element which is the data ( w/o @escaping func )
        
        do {
            let decodedMovieData = try JSONDecoder().decode(MoviesResponse.self, from: movieData)
            return decodedMovieData.results
        } catch {
            throw MoviesError.decodingError
        }
    }
    
    @MainActor
    func getTrendingMovies() async throws -> [Movie] {
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=39d7b5254926a27f20f39c1509a22ee8") else {
            throw MoviesError.networkError
        }
        
        let movieData = try await URLSession.shared.data(from: url).0
        
        do {
            let decodedMovieData = try JSONDecoder().decode(MoviesResponse.self, from: movieData)
            return decodedMovieData.results
        } catch {
            throw MoviesError.decodingError
        }
    }
    
    @MainActor
    func getUpcomingMovies() async throws -> [Movie] {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=39d7b5254926a27f20f39c1509a22ee8") else {
            throw MoviesError.networkError
        }
        
        
        let movieData = try await URLSession.shared.data(from: url).0 // first element which is the data ( w/o @escaping func )
        
        do {
            let decodedMovieData = try JSONDecoder().decode(MoviesResponse.self, from: movieData)
            return decodedMovieData.results
        } catch {
            throw MoviesError.decodingError
        }
    }
    
    @MainActor
    func getTopRatedMovies() async throws -> [Movie] {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=39d7b5254926a27f20f39c1509a22ee8") else {
            throw MoviesError.networkError
        }
        
        
        let movieData = try await URLSession.shared.data(from: url).0 // first element which is the data ( w/o @escaping func )
        
        do {
            let decodedMovieData = try JSONDecoder().decode(MoviesResponse.self, from: movieData)
            return decodedMovieData.results
        } catch {
            throw MoviesError.decodingError
        }
    }
    
    
    func search(for query: String) async throws -> [Movie] {
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?query=\(query)&api_key=39d7b5254926a27f20f39c1509a22ee8") else {
            throw MoviesError.networkError
        }
        
        let searchedMoviesData = try await URLSession.shared.data(from: url).0
        
        do {
            let decodedMoviesData = try JSONDecoder().decode(MoviesResponse.self, from: searchedMoviesData)
            return decodedMoviesData.results
        } catch {
            throw MoviesError.decodingError
        }
    }

    func getMovieCast(movieID: Int) async throws -> [CastMember] {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/credits?api_key=39d7b5254926a27f20f39c1509a22ee8") else {
            throw MoviesError.networkError
        }
        
        let movieCastData = try await URLSession.shared.data(from: url).0 // first element which is the data ( w/o @escaping func )
        
        do {
            let decodedMovieCastData = try JSONDecoder().decode(CastResponse.self, from: movieCastData)
            return decodedMovieCastData.cast
        } catch {
            throw MoviesError.decodingError
        }
    }

}
