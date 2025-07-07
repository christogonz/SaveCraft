//
//  MonthlyFixedExpenseStat.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-07-01.
//

import Foundation
import FirebaseFirestore

// muestrar el total mensual de todos los gastos fijos
struct MonthlyFixedExpenseStat: Identifiable {
    @DocumentID var id: String?
    var month: String
    var total: Int  //Total de gasta fijo en ese mes
}
