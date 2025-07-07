//
//  DashboardCard.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-07-01.
//

import SwiftUI

struct DashboardCard: View {
    var title: String
    var amount: Int
    var icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(Color.accentColor)
                    .font(.title3)
                
                Spacer()
                
                Text("$\(amount)")
                    .bold()
                    .foregroundStyle(Color.text)
            }
            
            Text(title)
                .font(.caption)
                .foregroundStyle(Color.secondary)
            
            
            
        }
        .padding()
        .frame(width: 160 )
        .background(Color("card"))
        .glassEffect(.regular, in: .containerRelative)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        
    }
}

#Preview {
    DashboardCard(title: "Saved", amount: 500, icon: "banknote")
}
