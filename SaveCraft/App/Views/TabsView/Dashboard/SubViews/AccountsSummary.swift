//
//  AccountsSummary.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-07-01.
//

import SwiftUI

struct AccountsSummary: View {
    var ahorroMensual: Int
    var inversionActual: Int
    var mainDisponible: Int
    var testAccounts: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Accounts")
                .font(.headline)
                .foregroundStyle(.secondary)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    DashboardCard(title: "Saved", amount: ahorroMensual, icon: "banknote")
                    DashboardCard(title: "Invested", amount: inversionActual, icon: "chart.pie")
                    DashboardCard(title: "Main", amount: mainDisponible, icon: "wallet.pass")
                    DashboardCard(title: "Test Account", amount: testAccounts, icon: "wallet.pass")
                }
                .padding(.vertical, 4)
                .transition(.scale)
            }
            .scrollClipDisabled()
        }
    }
}

#Preview {
    AccountsSummary(ahorroMensual: 450, inversionActual: 3200, mainDisponible: 750, testAccounts: 65655)
}
