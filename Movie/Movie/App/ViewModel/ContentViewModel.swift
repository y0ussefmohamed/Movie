import Foundation
import Combine


class ContentViewModel: ObservableObject
{
    init() {
        userLoggedIn()
    }
    
    @Published var isUserLoggedIn: Bool?
    private var cancellables = Set<AnyCancellable>()
    
    func userLoggedIn() {
        AuthService.shared.$isUserLoggedIn
            .receive(on: DispatchQueue.main) // Ensure updates are received on the main thread
            .map { $0 } // Convert Bool to Bool?
            .assign(to: \ContentViewModel.isUserLoggedIn, on: self)
            .store(in: &cancellables)
    }
}
