//
//  AccountsView.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-07-01.
//

import SwiftUI

struct AccountsView: View {
    @State private var accounts: [Account] = [
            .init(name: "Main", balance: 750, icon: "wallet.pass"),
            .init(name: "Savings", balance: 12556, icon: "banknote"),
            .init(name: "Investments", balance: 805656, icon: "chart.pie"),
            .init(name: "Emergency", balance: 56550, icon: "shield.lefthalf.fill")
        ]
    @State private var showingAddAccount = false
    @State private var selectedAccount: Account? = nil
    @State private var showEditModal = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(accounts) { account in
                        AccountCard(account: account)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                selectedAccount = account
//                                showEditModal = true
                                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                            }
                    }
                    
                    Text("Press the + button to add new accounts.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 50)
                }
                .padding()
            }
            .navigationTitle("Accounts")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddAccount = true
                    } label: {
                        HStack {
                            Text("New Account")
                            Image(systemName: "plus")
                                .font(.footnote)
                                .foregroundStyle(.accent)
                        }
                        .padding()
                        
                    }
                }
            }
            .sheet(isPresented: $showingAddAccount) {
                AddAccount { newAccount in
                    accounts.append(newAccount)
                }
                .presentationDetents([.fraction(0.6), .fraction(0.8), .fraction(1)])
                .presentationDragIndicator(.visible)
            }
            .sheet(item: $selectedAccount) { accountToEdit in
                    EditAccount(
                        account: accountToEdit,
                        onSave: { updated in
                            if let index = accounts.firstIndex(where: { $0.id == updated.id}) {
                                accounts[index] = updated
                            }
                        },
                        onDelete: { deleted in
                                        accounts.removeAll { $0.id == deleted.id }
                                    }
                    )
                
            }
            .background(Color("bg"))
            .fontDesign(.rounded)
            .scrollIndicators(.hidden)
        }
        
        
    }
}

#Preview {
    AccountsView()
}
