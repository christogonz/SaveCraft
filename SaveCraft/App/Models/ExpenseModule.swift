//
//  ExpenseModule.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-07-04.
//

import Foundation
import FirebaseFirestore

struct FixedExpenseModule: Identifiable, Codable {
    @DocumentID var firestoreID: String?
    var title: String
    var isShared: Bool  // Si el modulo es compartido
    var bills: [FixedBill] // La lista de gastos dentro del modulo
    var monthIdentifier: String
    
    var id: String {
        firestoreID ?? localID
    }
    
    private var localID = UUID().uuidString
    
    init(
        firestoreID: String? = nil,
        title: String,
        isShared: Bool = false,
        bills: [FixedBill],
        monthIdentifier: String
    ) {
        self.firestoreID = firestoreID
        self.title = title
        self.isShared = isShared
        self.bills = bills
        self.monthIdentifier = monthIdentifier
    }
}
