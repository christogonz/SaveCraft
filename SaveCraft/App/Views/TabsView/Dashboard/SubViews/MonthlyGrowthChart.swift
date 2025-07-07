//
//  MonthlyGrowthChart.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-07-01.
//

import SwiftUI
import Charts

struct MonthlyGrowthChart: View {
    let monthlySummary: [MonthlyStat]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Monthly Growth")
                .font(.headline)
                .foregroundStyle(.secondary)

            Chart(monthlySummary) {
                LineMark(
                    x: .value("Month", $0.month),
                    y: .value("Capital", $0.amount)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(LinearGradient(colors: [.accent.opacity(0.5), .accent.opacity(0.8), .accent], startPoint: .leading, endPoint: .trailing))
                .lineStyle(.init(lineWidth: 2))
                .symbol(.circle)
            }
            .frame(height: 220)
        }
        .padding()
        .glassEffect(.regular, in: .containerRelative)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .shadow(radius: 10)
        .transition(.move(edge: .bottom).combined(with: .opacity))
    }
}

#Preview {
    MonthlyGrowthChart(monthlySummary: [
        .init(month: "Jan", amount: 5200),
        .init(month: "Feb", amount: 6300),
        .init(month: "Mar", amount: 7100),
        .init(month: "Apr", amount: 7650),
        .init(month: "May", amount: 8000),
        .init(month: "Jun", amount: 8250)
    ])
}
