//
//  MonthlyStat.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-07-01.
//

import Foundation
import FirebaseFirestore

// El capital total acumulado cada mes
struct MonthlyStat: Identifiable {
    @DocumentID var id: String?
    var month: String // "2025-07"
    var amount: Int // capital total de ese mes
}
