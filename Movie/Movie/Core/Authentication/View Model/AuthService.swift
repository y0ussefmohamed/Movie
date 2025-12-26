import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthService: ObservableObject
{
    @Published var currentUser: User?
    @Published var isUserLoggedIn: Bool = false
    
    static let shared = AuthService()
    
    init() {
        // Listen to Firebase Auth state changes
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            if let uid = user?.uid {
                self?.isUserLoggedIn = true
                self?.fetchUser(withUid: uid)
            } else {
                self?.isUserLoggedIn = false
                self?.currentUser = nil
            }
        }
    }
    
    @MainActor
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        // 1. Create user in Firebase Auth
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        // 2. Save user data to Firestore
        try await saveUserData(withEmail: email, fullname: fullname, uid: result.user.uid)
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func logout() {
        try? Auth.auth().signOut()
    }
    
    // MARK: - Firestore
    
    func saveUserData(withEmail email: String, fullname: String, uid: String) async throws {
        let user = User(id: uid, fullname: fullname, email: email)
        guard let userData = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("users").document(uid).setData(userData)
        self.currentUser = user
    }
    
    func fetchUser(withUid uid: String) {
        Firestore.firestore().collection("users").document(uid).getDocument { [weak self] snapshot, error in
            if let error = error {
                print("DEBUG: Failed to fetch user with error: \(error.localizedDescription)")
                return
            }
            
            guard let self = self else { return }
            
            if let snapshot = snapshot, snapshot.exists {
                do {
                    self.currentUser = try snapshot.data(as: User.self)
                } catch {
                    print("DEBUG: Failed to decode user data: \(error)")
                }
            }
        }
    }
}
