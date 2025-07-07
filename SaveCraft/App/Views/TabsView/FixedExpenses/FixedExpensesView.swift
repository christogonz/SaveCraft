//
//  FixedExpensesView.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-07-01.
//

import SwiftUI

struct FixedExpensesView: View {
    @State private var selectedMonth: Date = Date()
    @State private var modules: [FixedExpenseModule] = [
        FixedExpenseModule(
            title: "Shared Bills",
            isShared: true,
            bills: [
                FixedBill(name: "Rent", amount: 12000, userPortion: 6000, icon: "house.fill", date: .now),
                FixedBill(name: "Electricity", amount: 800, userPortion: 400, icon: "bolt.fill", date: .now),
                FixedBill(name: "Water", amount: 600, userPortion: 300, icon: "drop.fill", date: .now),
                
            ], monthIdentifier: "Jul 2025"
        ),
        FixedExpenseModule(
            title: "My Bills",
            isShared: false,
            bills: [
                FixedBill(name: "Gym", amount: 549, icon: "figure.strengthtraining.traditional", date: .now),
                FixedBill(name: "Bil", amount: 3890, icon: "car.side", date: .now),
                FixedBill(name: "Mobil", amount: 499, icon: "iphone", date: .now)
            ], monthIdentifier: "Jul 2025"
        ),
        
    ]
    
    @State private var showToast = false
    @State private var showNewModule = false
    @State private var refreshToggle = false
    
    // 📆 Formatea el mes actual como "Jul 2025"
    private var currentMonthIdentifier: String {
        let formatter =  DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter.string(from: selectedMonth)
    }
    
    // 🔍 Filtra los módulos por el mes seleccionado
    private var filteredModules: [FixedExpenseModule] {
        modules.filter { $0.monthIdentifier == currentMonthIdentifier }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                // seccion de Module
                ScrollView {
                    VStack(spacing: 16) {
                        //MARK: Selector de mes
                        MonthPicker(selectedMonth: $selectedMonth)
                        
                        //MARK: 🧾 Módulos del mes seleccionado
                        ExpenseModulesList(
                            modules: filteredModules,
                            onDeleteBill: { moduleID, billID in
                                if let moduleIndex = modules.firstIndex(where: { $0.id == moduleID }) {
                                    if let billIndex = modules[moduleIndex].bills.firstIndex(where: { $0.id == billID }) {
                                        modules[moduleIndex].bills.remove(at: billIndex)
                                    }
                                }
                            },
                            onAddBill: { moduleID, newBill in
                                if let index = modules.firstIndex(where: { $0.id == moduleID }) {
                                    modules[index].bills.append(newBill)
                                }
                            },
                            onUpdateBill: { moduleID, updatedBill in
                                if let moduleIndex = modules.firstIndex(where: { $0.id == moduleID }) {
                                    if let billIndex = modules[moduleIndex].bills.firstIndex(where: { $0.id == updatedBill.id }) {
                                        modules[moduleIndex].bills[billIndex] = updatedBill
                                        refreshToggle.toggle() // 🔁 fuerza el render al editar bill
                                    }
                                }
                            },
                            onUpdateModule: { updatedModule in
                                if let index = modules.firstIndex(where: { $0.id == updatedModule.id }) {
                                    modules[index] = updatedModule
                                    refreshToggle.toggle() // 🔁 fuerza el render al editar módulo
                                }
                            },
                            onDeleteModule: { deletedModule in
                                modules.removeAll { $0.id == deletedModule.id }
                                refreshToggle.toggle() // opcional si quieres que la lista se refresque visualmente
                            }
                        )
                        .id(refreshToggle) // mantiene el binding con el toggle
                    }
                    .padding()
                }
                .navigationTitle("Your Bills")
                .scrollIndicators(.hidden)
                .fontDesign(.rounded)
            }
            .background(Color("bg"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                        showNewModule = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarSpacer(.fixed, placement: .topBarTrailing)
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                        copyModulesToNextMonth()
                    } label: {
                        HStack {
                            Text("Save")
                            Image(systemName: "arrowshape.turn.up.right")
                        }
                        .padding()
                        
                    }
                }
            }
            .sheet(isPresented: $showNewModule) {
                NewModuleModal(currentMonth: currentMonthIdentifier) { newModule in
                    modules.append(newModule)
                }
                .presentationDetents([.fraction(0.5), .fraction(0.8)])
                .presentationDragIndicator(.visible)
            }
            .overlay(alignment: .top) {
                if showToast {
                    ToastView(message: "Bills copied to next month")
                        .padding(.top, 1)
                }
            }
        }
        
        
    }
    
    
    // 📋 Copia todos los módulos actuales al mes siguiente
    private func copyModulesToNextMonth() {
        guard !filteredModules.isEmpty else { return }
        
        // Obtiene fecha del próximo mes
        guard let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: selectedMonth) else { return }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        let nextMonthIdentifier = formatter.string(from: nextMonth)
        
        let copiedModules: [FixedExpenseModule] = filteredModules.map { originalModule in
            // Copia los bills con nuevas fechas (al mes siguiente)
            let copiedBills = originalModule.bills.map { bill in
                FixedBill(
                    name: bill.name,
                    amount: bill.amount,
                    userPortion: bill.userPortion,
                    icon: bill.icon,
                    date: nextMonth // actualiza la fecha al mes siguiente
                )
            }
            
            return FixedExpenseModule(
                title: originalModule.title,
                isShared: originalModule.isShared,
                bills: copiedBills,
                monthIdentifier: nextMonthIdentifier
            )
        }
        
        // Añade los módulos copiados al array original
        modules.append(contentsOf: copiedModules)
        
        // Mostrar el toast visual
        withAnimation {
            showToast = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation {
                showToast = false
            }
        }
    }
}

#Preview {
    FixedExpensesView()
}

