//
//  DashboardView.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-07-01.
//

import SwiftUI
import Charts


struct DashboardView: View {
    // Datos temporales
    var capitalTotal: Int = 802280
    var ahorroMensual: Int = 18656
    var inversionActual: Int = 805656
    var mainDisponible: Int = 4659
    var testAcount: Int = 56550

    var monthlySummary: [MonthlyStat] = [
            .init(month: "Jan", amount: 100565),
            .init(month: "Feb", amount: 165565),
            .init(month: "Mar", amount: 172565),
            .init(month: "Apr", amount: 190565),
            .init(month: "May", amount: 205650),
            .init(month: "Jun", amount: 250650),
        ]
    
    // 📊 Evolución de gastos fijos mensuales
    var fixedExpensesByMonth: [MonthlyFixedExpenseStat] = [
        .init(month: "Jan", total: 12506),
        .init(month: "Feb", total: 10565),
        .init(month: "Mar", total: 11650),
        .init(month: "Apr", total: 15656),
        .init(month: "May", total: 14650),
        .init(month: "Jun", total: 11506)
    ]
    
    var body: some View {
        ScrollView() {
            VStack(alignment: .leading, spacing: 24) {
                
                Header(
                    displayName: "Chris Gonzalez",
                    profileImageURL: nil
                )
                
                CapitalView(capitalTotal: capitalTotal)
                
                MonthlyGrowthChart(monthlySummary: monthlySummary)
                
                AccountsSummary(
                    ahorroMensual: ahorroMensual,
                    inversionActual: inversionActual,
                    mainDisponible: mainDisponible,
                    testAccounts: testAcount
                )
                
                FixedBillsChart(fixedExpensesByMonth: fixedExpensesByMonth)
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .navigationTitle("Dashboard")
        .background(Color("bg"))
        .fontDesign(.rounded)
        .scrollEdgeEffectStyle(.soft, for: .top)
        
    }
    
}

#Preview {
    DashboardView()
}
