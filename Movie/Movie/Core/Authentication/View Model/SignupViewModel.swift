import Foundation


class SignupViewModel: ObservableObject {
    
    @Published var fullname = ""
    @Published var email = ""
    @Published var password = ""
    
    @MainActor
    func createUser() async throws {
        try await AuthService.shared.createUser(withEmail: email, password: password, fullname: fullname)
    }
}
