import Foundation


class LoginViewModel: ObservableObject
{
    // using @Published to publish it to the View and using $thisViewModel.email
    @Published var email = ""
    @Published var password = ""
    
    @MainActor
    func login() async throws {
        // try await better than .success() and .failure()
        try await AuthService.shared.login(withEmail: email, password: password)
    }
}
