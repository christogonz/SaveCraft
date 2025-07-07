//
//  EditAccount.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-07-02.
//

import SwiftUI
import UIKit

struct EditAccount: View {
    @Environment(\.dismiss) var dismiss
    
    @State var name: String
    @State var balance: String
    @State private var selectedIcon: String
    @State private var selectedDate: Date
    @State private var showDeleteAlert = false
    @State private var showSaveAlert = false
    @State private var showToast = false
    
    let account: Account
    let onSave: (Account) -> Void
    let onDelete: (Account) -> Void
    
    let icons = [
        "wallet.pass", "banknote", "chart.pie", "cart", "house", "gift", "creditcard", "bag", "airplane"
    ]
    
    init(account: Account, onSave: @escaping (Account) -> Void, onDelete: @escaping (Account) -> Void) {
        self.account = account
        self.onSave = onSave
        self.onDelete = onDelete
        _name = State(initialValue: account.name)
        _balance = State(initialValue: String(account.balance))
        _selectedIcon = State(initialValue: account.icon)
        _selectedDate = State(initialValue: Date())
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("Edit Account")
                    .font(.title.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Account Name")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        ModernTextField(placeholder: "Account Name", text: $name)
                            .textInputAutocapitalization(.sentences)
                            .padding(.bottom)
                        
                        Text("Account Balance")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        ModernTextField(placeholder: "Balance", text: $balance)
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
                                        .glassEffect(.regular.tint(selectedIcon == icon ? Color.gray.opacity(0.3) : Color.clear).interactive())
                                        .clipShape(Circle())
                                        .onTapGesture {
                                            withAnimation(.bouncy(extraBounce: 0.4)) {
                                                selectedIcon = icon
                                                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                            }
                                        }
                                }
                            }
                        }
                        .scrollClipDisabled()
                        
                        DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .padding(.top)
                        
                        Spacer()
                        
                        CustomSaveBotton(
                            title: "Save Changes",
                            onTap: {
                                guard let amount = Int(balance), !name.isEmpty else { return }
                                
                                var updated = account
                                updated.name = name
                                updated.balance = amount
                                updated.icon = selectedIcon
                                updated.history.append(AccountUpdate(date: selectedDate, balance: amount))
                                
                                onSave(updated)
                                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                showToast = true
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                    showToast = false
                                    dismiss()
                                }
                            }
                        )
                        .padding(.top)
                        
                        Button(role: .destructive) {
                            showDeleteAlert = true
                        } label: {
                            Text("Delete Account")
                                .font(.subheadline)
                                .frame(maxWidth: .infinity)
                                .contentShape(Rectangle())
                                .padding()
                        }
                        .glassEffect(.regular.tint(.red.opacity(0.2)).interactive(), in: .containerRelative)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .alert("Are you sure you want to delete this account?", isPresented: $showDeleteAlert) {
                            Button() {
                                dismiss()
                            } label: {
                                Text("Cancel")
                            }
                    
                            
                            Button() {
                                onDelete(account)
                                dismiss()
                            } label: {
                                Text("Delete")
                                    
                            }
                            
                        }
                    }
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
                            .frame(maxWidth: 90)
                            .contentShape(Rectangle())
                    }
                    .glassEffect(.regular.tint(.red.opacity(0.15)).interactive(), in: .containerRelative)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                }
            }
            .background(Color("bg"))
            .overlay(alignment: .top) {
                if showToast {
                    Text("Changes saved successfully")
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.white.opacity(0.3), lineWidth: 0.5)
                        )
                        .foregroundStyle(.primary)
                        .font(.subheadline.bold())
                        .padding(.top, 50)
                        .transition(.move(edge: .top).combined(with: .opacity))
                }
            }
            .animation(.easeInOut, value: showToast)
        }
        .alert("Changes Saved successfully!", isPresented: $showSaveAlert) {
        }
    }
}

#Preview {
    EditAccount(
        account: Account(
            id: "test-id",
            name: "Savings",
            balance: 1500,
            icon: "wallet.pass",
            history: [
                AccountUpdate(date: Date().addingTimeInterval(-86400 * 30), balance: 1000),
                AccountUpdate(date: Date(), balance: 1500)
            ]
        ),
        onSave: { updated in
            print("Updated account: \(updated)")
        },
        onDelete: { deleted in
            print("Deleted account: \(deleted)")
        }
    )
}
