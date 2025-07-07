//
//  EditFixedBillModal.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-07-04.
//

//EditFixedBillModal

import SwiftUI
import UIKit

struct EditFixedBillModal: View {
    @Environment(\.dismiss) var dismiss
    
    @State var name: String
    @State var amount: String
    @State private var selectedIcon: String
    @State private var selectedDate: Date
    @State private var showDeleteAlert = false
    @State private var showToast = false
    
    let bill: FixedBill
    let onSave: (FixedBill) -> Void
    let onDelete: (FixedBill) -> Void
    
    let icons = [
        "bolt.fill", "house.fill", "drop.fill", "cart.fill", "car.fill", "heart.fill", "music.note", "wifi", "creditcard.fill", "cup.and.saucer.fill"
    ]
    
    init(bill: FixedBill, onSave: @escaping (FixedBill) -> Void, onDelete: @escaping (FixedBill) -> Void) {
        self.bill = bill
        self.onSave = onSave
        self.onDelete = onDelete
        _name = State(initialValue: bill.name)
        _amount = State(initialValue: String(bill.amount))
        _selectedIcon = State(initialValue: bill.icon)
        _selectedDate = State(initialValue: bill.date)
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("Edit Bill")
                    .font(.title.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Bill Name")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        ModernTextField(placeholder: "Name", text: $name)
                            .textInputAutocapitalization(.sentences)
                        
                        Text("Amount")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        ModernTextField(placeholder: "Amount", text: $amount)
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
                    }
                    
                    Spacer()
                    
                    
                    CustomSaveBotton(
                        title: "Save Changes",
                        onTap: {
                            guard let total = Int(amount), !name.isEmpty else { return }
                            
                            let updated = FixedBill(
                                name: name,
                                amount: total,
                                userPortion: bill.userPortion,
                                icon: selectedIcon,
                                date: selectedDate
                            )
                            
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
                        Text("Delete Bill")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .contentShape(Rectangle())
                            .padding()
                    }
                    
                    .glassEffect(.regular.tint(.red.opacity(0.2)).interactive(), in: .containerRelative)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .alert("Are you sure you want to delete this bill?", isPresented: $showDeleteAlert) {
                        Button("Cancel") {
                            dismiss()
                        }
                        
                        Button("Delete") {
                            onDelete(bill)
                            dismiss()
                        }
                    }
                }
            }
            .padding()
            .background(Color.bg)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundStyle(.red)
                            .padding()
                            .frame(maxWidth: 90)
                            .contentShape(Rectangle())
                    }
                    
                    .glassEffect(.regular.tint(.clear).interactive(), in: .containerRelative)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                }
            }
            .overlay(alignment: .top) {
                if showToast {
                    Text("Changes saved successfully")
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(.white.opacity(0.3), lineWidth: 0.5))
                        .foregroundStyle(.primary)
                        .font(.subheadline.bold())
                        .padding(.top, 50)
                        .transition(.move(edge: .top).combined(with: .opacity))
                }
            }
            .animation(.easeInOut, value: showToast)
        }
    }
}

#Preview {
    EditFixedBillModal(
        bill: FixedBill(
            name: "Spotify",
            amount: 129,
            userPortion: 64,
            icon: "music.note",
            date: .now
        ),
        onSave: { updated in
            print("✅ Saved bill: \(updated)")
        },
        onDelete: { deleted in
            print("🗑️ Deleted bill: \(deleted)")
        }
    )
    .background(Color.bg)
}
