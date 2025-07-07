//
//  NewModuleModal.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-07-05.
//

import SwiftUI

struct NewModuleModal: View {
    @Environment(\.dismiss) var dismiss
    let currentMonth: String
    let onSave: (FixedExpenseModule) -> Void
    
    @State private var title: String = ""
    @State private var isShared: Bool = false
    
    var body: some View {
        VStack(spacing: 24) {
            Text("New Module")
                .font(.title2.bold())
                .padding(.top)
            
            VStack(alignment: .leading) {
                Text("Module Name")
                ModernTextField(placeholder: "My Bills", text: $title)
                    .textInputAutocapitalization(.sentences)
            }
            
            Toggle("Shared Bills", isOn: $isShared)
                .toggleStyle(.switch)

            Spacer()
            
            CustomSaveBotton(
                title: "Create",
                onTap: {
                    let newmodule = FixedExpenseModule(
                        title: title.isEmpty ? "Untitled" : title,
                        isShared: isShared,
                        bills: [],
                        monthIdentifier: currentMonth
                    )
                    UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                    onSave(newmodule)
                    dismiss()
                }
            )
            .padding(.top)
        }
        .fontDesign(.rounded)
        .padding()
        .background(Color("bg"))
    }
}

#Preview {
    NewModuleModal(currentMonth: "Jul 2025") { newModule in
        print("Nuevo módulo creado: \(newModule.title), compartido: \(newModule.isShared)")
    }
    .padding()
    .background(Color("bg"))
}
