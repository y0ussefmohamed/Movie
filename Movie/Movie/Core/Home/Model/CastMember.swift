import Foundation


struct CastResponse: Codable 
{
    let cast: [CastMember]
}

struct CastMember: Codable , Hashable
{
    let name: String?
    let original_name: String?
    let profile_path: String?
}
