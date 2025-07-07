//
//  AddBillModal.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-07-06.
//

import SwiftUI

struct AddBillModal: View {
    @Environment(\.dismiss) var dismiss
    
    let moduleTitle: String
    let isShared: Bool
    let onAdd: (FixedBill) -> Void
    
    @State var name: String = ""
    @State var amount: String = ""
    @State var selectedIcon: String = "house.fill"
    @State var selectedDate: Date = Date()
    
    private let icons = [
            "bolt.fill", "house.fill", "drop.fill", "cart.fill", "car.fill",
            "heart.fill", "music.note", "wifi", "creditcard.fill", "cup.and.saucer.fill"
        ]
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Add new bill to \(moduleTitle)")
                .font(.title3.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
            
            VStack(alignment: .leading, spacing: 12 ) {
                Text("Bill Name")
                    .font(.subheadline)
                    .foregroundStyle(.primary)
                
                ModernTextField(placeholder: "House Rent...", text: $name)
                    
                
                Text("Amount")
                    .font(.subheadline)
                    .foregroundStyle(.primary)
                
                ModernTextField(placeholder: "1000...", text: $amount)
                    .keyboardType(.numberPad)
                
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
            }
            
            Spacer()
            
            
            CustomSaveBotton(
                title: "Add Bill",
                onTap: {
                    guard let total = Int(amount), !name.isEmpty else { return }
                    
                    let userPortion = isShared ? total / 2 : total
                    
                    let newBill = FixedBill(
                        name: name,
                        amount: total,
                        userPortion: userPortion,
                        icon: selectedIcon,
                        date: selectedDate
                    )
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    onAdd(newBill)
                    dismiss()
                },
                addIcon: "plus.circle"
            )
        }
        .padding()
        .fontDesign(.rounded)
        .background(Color("bg"))
    }
}

#Preview {
    AddBillModal(
        moduleTitle: "Shared Bills",
        isShared: true
    ) { bill in
        print("🧾 Nuevo bill creado: \(bill.name) - \(bill.amount) - Shared: \(String(describing: bill.userPortion))")
    }
    .background(Color("bg"))
}
