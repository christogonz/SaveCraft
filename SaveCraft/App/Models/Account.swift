//
//  Account.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-07-01.
//

import Foundation
import FirebaseFirestore

// todas las cuentas creadad por el usuario
struct Account: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String //"Main", "Invest", "Emergency"
    var balance: Int // Saldo Actual
    var icon: String
    var history: [AccountUpdate]
    
    
    init(id: String? = UUID().uuidString, name: String, balance: Int, icon: String, history: [AccountUpdate] = []) {
        self.id = id
        self.name = name
        self.balance = balance
        self.icon = icon
        self.history = history
        
        if history.isEmpty {
            self.history.append(AccountUpdate(date: Date(), balance: balance))
        }
    }
}

struct AccountUpdate: Identifiable, Codable, Equatable {
    var id: String = UUID().uuidString
    var date: Date
    var balance: Int
}
