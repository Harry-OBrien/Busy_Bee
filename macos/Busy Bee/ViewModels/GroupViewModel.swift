//
//  GroupViewModel.swift
//  Busy Bee
//
//  Created by Harry O'Brien on 27/10/2024.
//
import Foundation
import FirebaseFirestore
import Combine

class GroupViewModel: ObservableObject {
    @Published var members: [User] = []
    @Published var errorMessage: String?

    private var db = Firestore.firestore()
    private var cancellables = Set<AnyCancellable>()

    func fetchGroup(by group_id: String, excluding user_id: String) {
        db.collection("groups").document(group_id).getDocument { [weak self] document, error in
            if let error = error {
                self?.errorMessage = "Error fetching group: \(error.localizedDescription)"
                return
            }

            if let document = document, let group = try? document.data(as: Group.self) {
                self?.fetchMembers(memberUIDs: group.members, excluding: user_id)
            } else {
                self?.errorMessage = "Group not found"
            }
        }
    }

    private func fetchMembers(memberUIDs: [String], excluding currentUserUID: String) {
        print("Member UIDs to fetch: \(memberUIDs)")

        db.collection("users").whereField(FieldPath.documentID(), in: memberUIDs).getDocuments { [weak self] snapshot, error in
            if let error = error {
                self?.errorMessage = "Error fetching members: \(error.localizedDescription)"
                return
            }

            guard let documents = snapshot?.documents else {
                print("No documents found.")
                self?.members = []
                return
            }

            self?.members = documents.compactMap { doc in
                // Create a User instance with the document ID
                var user = try? doc.data(as: User.self)
                user?.id = doc.documentID // Manually assign the document ID
                
                // Exclude the current user from the members list
                if user?.id == currentUserUID {
                    return nil // Skip adding this user to the members array
                }
                
                return user
            }

//            print("Fetched members: \(self?.members ?? [])")
        }
    }

}
