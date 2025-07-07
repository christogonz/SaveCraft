//
//  FixedBillsChart.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-07-01.
//

import SwiftUI
import Charts

struct FixedBillsChart: View {
    let fixedExpensesByMonth: [MonthlyFixedExpenseStat]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Text("Bills over each months")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            VStack(alignment: .leading) {
                Text("Fixed Bills")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                
                Chart(fixedExpensesByMonth) {
                    BarMark(
                        x: .value("Month", $0.month),
                        y: .value("Total", $0.total)
                    )
                    .foregroundStyle(.accent.gradient.opacity(0.8))
                }
                .frame(height: 200)
            }
            .padding()
            .glassEffect(.regular, in: .containerRelative)
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .shadow(radius: 10)
            .transition(.move(edge: .bottom).combined(with: .opacity))
        }
    }
}

#Preview {
    FixedBillsChart(fixedExpensesByMonth: [
        .init(month: "Jan", total: 12560),
        .init(month: "Feb", total: 11560),
        .init(month: "Mar", total: 12460),
        .init(month: "Apr", total: 12560),
        .init(month: "May", total: 10360),
        .init(month: "Jun", total: 15560)
    ])
}
