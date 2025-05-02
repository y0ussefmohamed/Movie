import Foundation


struct User: Identifiable, Codable
{
    var id: String
    var fullname: String
    var email: String
}
