//
//  UserViewModel.swift
//  Busy Bee
//
//  Created by Harry O'Brien on 27/10/2024.
//

import Foundation
import FirebaseFirestore
import Combine

class UserViewModel: ObservableObject {
    @Published var user: User?
    @Published var errorMessage: String?
    
    var db = Firestore.firestore();
    
    var statusText: String {
        guard let status = user?.status else { return "Unknown" }
        return status.toString();
    }

    var statusIcon: String {
        guard let status = user?.status else { return "bee_black" }
        return status.iconName;
    }
    
    init() {
        // Example: Replace with the current user's UID
        let currentUserUID = "3x3TuK8NHeqlAiIhvbLh"
        fetchUser(withUID: currentUserUID)
    }

    func fetchUser(withUID uid: String) {
        db.collection("users").document(uid).getDocument { [weak self] document, error in
            if let error = error {
                self?.errorMessage = "Error fetching user: \(error.localizedDescription)"
                return
            }

            if let document = document, document.exists {
                self?.user = try? document.data(as: User.self)
                self?.user?.id = document.documentID;
            } else {
                self?.errorMessage = "User not found"
            }
        }
    }

    func updateUserStatus(to status: User.WorkStatus) {
        guard let uid = user?.id else { return }
        
        db.collection("users").document(uid).updateData(["status": status.firestoreValue]) { [weak self] error in
            if let error = error {
                self?.errorMessage = "Error updating status: \(error.localizedDescription)"
            } else {
                self?.user?.status = status
            }
        }
    }
}

