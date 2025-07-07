//
//  FixedExpeseModuleCard.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-07-04.
//

import SwiftUI

struct FixedExpenseModuleCard: View {
    let module: FixedExpenseModule
    let onDeletedBill: (FixedBill) -> Void
    let onUpdatedBill: (FixedBill) -> Void
    let onUpdateModule: (FixedExpenseModule) -> Void
    let onDeleteModule: (FixedExpenseModule) -> Void
    
    @State private var selectedBill: FixedBill? = nil
    @State private var showSaveConfirmation = false
    @State private var isEditingModule = false
    
    var totalAmount: Int {
        module.bills.reduce(0) { $0 + $1.amount }
    }
    
    var userTotal: Int {
        module.bills.reduce(0) { $0 + ($1.userPortion ?? $1.amount)}
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                if module.isShared {
                    Image(systemName: "person.2")
                        .foregroundStyle(.secondary)
                } else {
                    Image(systemName: "person")
                        .foregroundStyle(.secondary)
                }
                
                Button {
                    isEditingModule = true
                } label: {
                    Text(module.title)
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.accentColor)
                }
                
                Spacer()
                
                if module.isShared {
                    HStack {
                        Text("\(formattedAmount(totalAmount))")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        Text("/")
                            .font(.subheadline)
                            .foregroundStyle(.accent)
                        
                        Text("\(formattedAmount(userTotal))")
                            .font(.subheadline)
                            .foregroundStyle(.primary)
                    }
                    
                } else {
                    Text("\(formattedAmount(totalAmount))")
                }
                
                
            }
            
            ForEach(module.bills) { bill in
                VStack {
                    HStack(spacing: 12) {
                        Image(systemName: bill.icon)
                            .frame(width: 28, height: 28)
                            .padding(8)
                            .foregroundColor(.accentColor)
                            .background(.thinMaterial)
                            .clipShape(Circle())
                        
                        
                        VStack(alignment: .leading) {
                            Text(bill.name)
                                .font(.subheadline)
                                .foregroundStyle(.primary)
                            
                            Text(formattedDate(bill.date))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text("\(formattedAmount(bill.amount))")
                                .foregroundStyle(module.isShared ? .secondary : Color.accentColor)
                                .font(.subheadline.bold())
                            
                            if module.isShared, let portion = bill.userPortion {
                                HStack {
                                    Text("You pay:")
                                        .foregroundStyle(.secondary)
                                    
                                    Text("\(formattedAmount(portion))")
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.accent.gradient)
                                }
                            }
                            
                            
                        }
                        .padding(.vertical, 4)
                        
                        
                    }
                }
                .padding()
                .glassEffect(.regular, in: .containerRelative)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .circular))
                .shadow(radius: 6)
                .contentShape(Rectangle()) // Hace toda la tarjeta tocable
                .onTapGesture {
                    UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                    selectedBill = bill
                }
            }
        }
        .fontDesign(.rounded)
        .sheet(item: $selectedBill) { bill in
            EditFixedBillModal(bill: bill) { updatedBill in
                onUpdatedBill(updatedBill)
                showSaveConfirmation = true
            } onDelete: { deletedBill in
                onDeletedBill(deletedBill)
            }
            .presentationDetents([.fraction(1)])
            .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $isEditingModule) {
            EditModuleModal(
                title: module.title,
                isShared: module.isShared,
                originalModule: module,
                onSave: { updatedModule in
                    onUpdateModule(updatedModule)
                },
                onDelete: { deletedModule in
                        onDeleteModule(deletedModule)
                }
            )
            .presentationDetents([.fraction(0.6), .fraction(1)])
        }
        .alert("Saved!", isPresented: $showSaveConfirmation) {
            Button("OK") { }
        }
    }
    
    //💰 formatea Monto
    private func formattedAmount(_ amount: Int) -> String {
        "\(amount) kr"
    }
    
    //📅 formata Fecha
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        return formatter.string(from: date)
        
    }
    
}

#Preview {
    FixedExpenseModuleCard(
        module: FixedExpenseModule(
            title: "With Wife",
            isShared: true,
            bills: [
                FixedBill(name: "Electricity", amount: 800, userPortion: 400, icon: "bolt.fill", date: .now),
                FixedBill(name: "Water", amount: 500, userPortion: 250, icon: "drop.fill", date: .now),
                FixedBill(name: "Rent", amount: 12000, userPortion: 6000, icon: "house.fill", date: .now)
            ],
            monthIdentifier: "Jul 2025"
        ),
        onDeletedBill: { bill in
            print("🗑️ Deleted bill in preview: \(bill.name)")
        },
        onUpdatedBill: { bill in
            print("🗑️ updated bill in preview: \(bill.name)")
        },
        onUpdateModule: { updatedModule in
            print("✅ Module updated in preview: \(updatedModule.title), shared: \(updatedModule.isShared)")
        },
        onDeleteModule: { deletedModule in
            print("🧨 Module deleted in preview: \(deletedModule.title)")
        }
    )
    .padding()
    .background(Color.bg)
}
