//
//  ExpenseModulesList.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-07-05.
//

import SwiftUI

struct ExpenseModulesList: View {
    var modules: [FixedExpenseModule]
    let onDeleteBill: (_ moduleID: String, _ billID: String) -> Void
    let onAddBill: (_ moduleID: String, _ newBill: FixedBill) -> Void
    let onUpdateBill: (_ moduleID: String, _ updatedBill: FixedBill) -> Void
    let onUpdateModule: (_ updatedModule: FixedExpenseModule) -> Void
    let onDeleteModule: (_ deletedModule: FixedExpenseModule) -> Void
    
    private var isShowingAddBillModal: Bool {
        selectedModuleIndex != nil
    }
    
    @State private var selectedModuleIndex: Int? = nil
    
    
    var body: some View {
        VStack(spacing: 16) {
            if modules.isEmpty {
                VStack(spacing: 16) {
                    Spacer(minLength: 80)
                    
                    
                    Image(systemName: "tray.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundStyle(.quaternary)
                    
                    Text("No bills for this month")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    
                    Text("Press the + button or copy from previous month")
                        .font(.subheadline)
                        .foregroundStyle(.tertiary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Spacer(minLength: 120)
                }
                .frame(maxWidth: .infinity, minHeight: 400)
            } else {
                ForEach(modules.indices, id: \.self) { index in
                    FixedExpenseModuleCard(
                        module: modules[index],
                        onDeletedBill: { deleteBill in
                            onDeleteBill(
                                modules[index].id,
                                deleteBill.id)
                        },
                        onUpdatedBill: { updatedBill in
                            onUpdateBill(modules[index].id, updatedBill)
                        },
                        onUpdateModule: { update in
                            onUpdateModule(update)
                        },
                        onDeleteModule: { delete in
                            onDeleteModule(delete)
                        }
                    )
                    
                    HStack {
                        Button {
                            selectedModuleIndex = index
                        } label: {
                            HStack {
                                Image(systemName: "plus.circle")
                                Text("Add New Bill")
                            }
                        }
                    }
                    
                    Divider()
                }
            }
        }
        .sheet(isPresented: Binding<Bool>(
            get: { isShowingAddBillModal },
            set: { newValue in
                if !newValue {
                    selectedModuleIndex = nil
                }
            }
        )) {
            if let index = selectedModuleIndex {
                AddBillModal(
                    moduleTitle: modules[index].title,
                    isShared: modules[index].isShared,
                ) { newBill in
                    onAddBill(modules[index].id, newBill)
                }
                .presentationDetents([.fraction(0.8), .fraction(1)])
            }
        }
    }
}

#Preview {
    ExpenseModulesList(
        modules: [
            FixedExpenseModule(
                title: "Example",
                isShared: true,
                bills: [
                    FixedBill(name: "Test", amount: 100, icon: "bolt.fill", date: .now)
                ],
                monthIdentifier: "Jul 2025"
            )
        ],
        onDeleteBill: { _, _ in },
        onAddBill: { _, _ in },
        onUpdateBill: { _, _ in},
        onUpdateModule: { _ in },
        onDeleteModule: { _ in }
    )
}
