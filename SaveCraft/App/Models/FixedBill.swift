//
//  FixedBill.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-07-04.
//

import Foundation
import FirebaseFirestore

// Cada cuenta (item) por especifico
struct FixedBill: Codable, Identifiable {
    @DocumentID var firestoreID: String? //solo para firebase
    var name: String
    var amount: Int
    var userPortion: Int?  // Cuanto paga el usuario si es compartido
    var icon: String
    var date: Date
    var id: String {
        firestoreID ?? localID
    }
    
    private var localID = UUID().uuidString
    
    init(
        firestoreID: String? = nil,
        name: String,
        amount: Int,
        userPortion: Int? = nil,
        icon: String,
        date: Date
    ) {
        self.firestoreID = firestoreID
        self.name = name
        self.amount = amount
        self.userPortion = userPortion
        self.icon = icon
        self.date = date
    }
}
