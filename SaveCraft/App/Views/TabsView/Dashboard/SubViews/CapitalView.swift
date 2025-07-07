//
//  DashboardCapitalView.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-07-01.
//

import SwiftUI

struct CapitalView: View {
    let capitalTotal: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Total Capital")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text("$\(capitalTotal)")
                .font(.largeTitle.bold())
                .foregroundStyle(.accent)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .glassEffect(.regular, in: .containerRelative)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .shadow(radius: 10)
    }
}

#Preview {
    CapitalView(capitalTotal: 8250)
}
