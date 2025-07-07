//
//  MonthPicker.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-07-05.
//

import SwiftUI

struct MonthPicker: View {
    @Binding var selectedMonth: Date
    
    var body: some View {
        HStack {
            Button {
                if let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: selectedMonth) {
                    selectedMonth = previousMonth
                }
            } label: {
                Image(systemName: "chevron.left")
            }
            Spacer()
            Text(formattedMonth(selectedMonth))
                .font(.title2.bold())
                .foregroundStyle(.primary)
            Spacer()
            Button(action: {
                if let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: selectedMonth) {
                    selectedMonth = nextMonth
                }
            }) {
                Image(systemName: "chevron.right")
            }
        }
    }
    
    // 📆 Formatea el mes como "Jul 2025"
    private func formattedMonth(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter.string(from: date)
    }
}

#Preview {
    MonthPicker(selectedMonth: .constant(Date()))
        .padding()
        .background(Color.gray.opacity(0.1))
}
