import Foundation


struct MoviesResponse : Codable
{
    let results: [Movie]
}

struct Movie : Identifiable, Codable ,  Equatable, Hashable
{
    let id: Int
    let title: String?
    let original_title: String?
    let backdrop_path: String?
    let overview: String?
    let vote_count: Int?
    let release_date: String?
    let vote_average: Double?
    let popularity: Double?
}
