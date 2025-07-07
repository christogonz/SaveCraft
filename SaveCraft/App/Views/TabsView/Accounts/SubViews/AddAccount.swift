//
//  AddAccount.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-07-01.
//

import SwiftUI

struct AddAccount: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var balance = ""
    @State private var selectedIcon = "wallet.pass"
    
    let onSave: (Account) -> Void
    
    let icons = [
        "wallet.pass", "banknote", "chart.pie", "cart", "house", "gift", "creditcard", "bag", "airplane"
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("New Account")
                    .font(.title.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 16) {
                    ModernTextField(placeholder: "Account Name", text: $name)
                        .textInputAutocapitalization(.sentences)
                    
                    ModernTextField(placeholder: "Initial Balance", text: $balance)
                        .keyboardType(.numberPad)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Select Icon")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(icons, id: \.self) { icon in
                                Image(systemName: icon)
                                    .font(.title2)
                                    .padding(20)
                                    .glassEffect(.regular.tint(selectedIcon == icon
                                                               ? Color.gray.opacity(0.3)
                                                               : Color.clear
                                                              ).interactive())
                                    .clipShape(Circle())
                                    .onTapGesture {
                                        withAnimation(.bouncy(extraBounce: 0.4)) {
                                            selectedIcon = icon
                                        }
                                    }
                            }
                        }
                    }
                    .scrollClipDisabled()
                    Spacer()
                    
                    CustomSaveBotton(
                        title: "Add Accoount",
                        onTap: {
                            guard let amount = Int(balance), !name.isEmpty else { return }
                            let newAccount = Account(name: name, balance: amount, icon: selectedIcon)
                            onSave(newAccount)
                            dismiss()
                        }
                    )
                    .padding(.top)
                }
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .padding()
                    }
                    .frame(maxWidth: 90)
                    .glassEffect(.regular.tint(.red.opacity(0.15)).interactive(), in: .containerRelative)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                }
            }
            .background(Color("bg"))
        }
    }
}

#Preview {
    AddAccount {_ in }
}
