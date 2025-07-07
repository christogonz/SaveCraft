//
//  AccountCard.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-07-01.
//

import SwiftUI

struct AccountCard: View {
    var account: Account
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: account.icon)
                .font(.title2)
                .foregroundStyle(.accent)
                .padding()
                .background(Color.gray.opacity(0.15))
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(account.name)
                    .font(.headline)
                
                Text("$\(account.balance)")
                    .font(.title2.bold())
                    .foregroundStyle(.accent)
            }
            
            Spacer()
        }
        .padding()
        .glassEffect(.regular, in: .containerRelative)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color:.black.opacity(0.1), radius: 6, x: 0, y: 4)
    }
}

#Preview {
    AccountCard(account: Account(name: "Main", balance: 565656, icon: "banknote"))
}
