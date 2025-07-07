//
//  AuthViewModel.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-06-30.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

@MainActor
class AuthViewModel: ObservableObject {
    
    @Published var currentUser: UserModel? = nil
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    
    // MARK: Registro de nuevo usuario
    func signUp(email: String, password: String, displayName: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let result = try await auth.createUser(withEmail: email, password: password)
            
            // Crea el doc del usuario en Firebae
            let newUser = UserModel(
                id: result.user.uid,
                email: result.user.email ?? "",
                displayName: displayName,
                createdAt: Date(),
            )
            
            try db.collection("users").document(result.user.uid).setData(from: newUser)
            
            try await fetchUser(uid: result.user.uid)
            
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    
    func signIn(email: String, password: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let result = try await auth.signIn(withEmail: email, password: password)
            try await fetchUser(uid: result.user.uid)
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    // MARK: SignOut
    func signOut() async {
        do {
            try auth.signOut()
            currentUser = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    // MARK: Cargar Datos del usuario de Firestore
    func fetchUser(uid: String) async throws {
        let doc = try await db.collection("users").document(uid).getDocument()
        currentUser = try doc.data(as: UserModel.self)
    }
    
    // MARK: verificar si hat sesion abierta
    func loadCurrentUser() async {
        guard let user = auth.currentUser else { return }
        try? await fetchUser(uid: user.uid)
    }
}
