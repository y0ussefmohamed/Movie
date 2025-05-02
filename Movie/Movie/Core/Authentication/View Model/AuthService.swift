import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthService
{
    private let LoggingStateKey = "LOG_STATE"
    
    // Singleton Object ( One Object Shared Across the Application )
    static let shared = AuthService()
    
    @Published var currentUser: User? //  Doesn't do anything but leave it as it is
    @Published var isUserLoggedIn: Bool?
    
    init() {
        fetchLoggingState()
    }
    
    
    @MainActor
    func createUser(withEmail email: String , password: String , fullname: String) async throws {
        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
            currentUser?.fullname = fullname
            //try await saveUserData(withEmail: email, fullname: fullname, uid: result.user.uid)
            isUserLoggedIn = true
            saveLoggingState()
        } catch {
            print("DEBUG: Failed to Create a User with Error -> \(error)")
        }
    }
    
    func login(withEmail email: String, password: String) async throws {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
            isUserLoggedIn = true
            saveLoggingState()
        } catch {
            print("DEBUG: Failed to Login User with Error -> \(error)")
        }
    }
    
    
    func logout() {
        try? Auth.auth().signOut()
        isUserLoggedIn = false
        saveLoggingState()
    }
    
    func fetchLoggingState() {
        self.isUserLoggedIn = UserDefaults.standard.bool(forKey: LoggingStateKey)
    }
    
    func saveLoggingState() {
        if( isUserLoggedIn == nil || isUserLoggedIn == false) {
            UserDefaults.standard.setValue(false, forKey: LoggingStateKey) // no user or user is logged out
        } else {
            UserDefaults.standard.setValue(true, forKey: LoggingStateKey) // user is logged in
        }
    }
    
    //func saveUserData(
    //        withEmail email: String,
    //        fullname: String,uid: String) async throws {
    //            // 1. make a user object  2. make userData using user object  3. save user in a collection using the data
    //            let user = User(id: uid, fullname: fullname, email: email)
    //
    //            guard let userData = try? Firestore.Encoder().encode(user) else {
    //                print("DEBUG: Firestore Failed to Encode User Data with Error")
    //                return
    //            }
    //
    //            try await Firestore.firestore().collection("users").document(uid).setData(userData)
    //        }
}
