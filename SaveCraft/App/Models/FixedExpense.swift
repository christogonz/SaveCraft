//
//  FixedExpense.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-07-01.
//

import Foundation
import FirebaseFirestore

// Para un gasto fijo especifico mensual
struct FixedExpense: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String //"Rent", "Electricity", "Phone"
    var amount: Int  //Valor fijo mensual
    var cateregory: String? //"Housing", "Utilities"
    var month: String  //Mes correspondiente (Ej: "2025-07")
    var createdAt: Date?
}
