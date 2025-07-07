//
//  EditModuleModal.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-07-06.
//

import SwiftUI

struct EditModuleModal: View {
    @Environment(\.dismiss) var dismiss
    
    @State var title: String
    @State var isShared: Bool
    
    let originalModule: FixedExpenseModule
    let onSave: (FixedExpenseModule) -> Void
    let onDelete: (FixedExpenseModule) -> Void
    
    @State private var showToast = false
    @State private var showDeleteAlert = false
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Edit Module")
                .font(.title2.bold())
                .padding(.top)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Module Name")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                ModernTextField(placeholder: "Name...", text: $title)
                
                Toggle("Shared Bills", isOn: $isShared)
                    .toggleStyle(.switch)
            }
            
            Spacer()
            
            CustomSaveBotton(title: "Save Changes", onTap:  {
                var updated = originalModule
                updated.title = title
                updated.isShared = isShared
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                onSave(updated)
                showToast = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    dismiss()
                    showToast = false
                    }
                },
                addIcon: "checkmark.circle"
            )
            
            Button(role: .destructive) {
                showDeleteAlert = true
            } label: {
                Text("Delete Module")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
                    .padding()
            }
            .glassEffect(.regular.tint(.red.opacity(0.2)).interactive(), in: .containerRelative)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .alert("Delete Module?", isPresented: $showDeleteAlert) {
                Button("Cancel"){dismiss()}
                Button("Delete") {
                    onDelete(originalModule)
                    dismiss()
                }
                
            }
        }
        .padding()
        .fontDesign(.rounded)
        .background(Color("bg"))
        .overlay(alignment: .top) {
            if showToast {
                ToastView(message: "Module saved successfully!")
                    .padding(.top, 1)
            }
        }
    }
    
}
    
    #Preview {
        EditModuleModal(
            title: "Shared Bills",
            isShared: true,
            originalModule: FixedExpenseModule(title: "Shared", isShared: true, bills: [], monthIdentifier: "Jul 2025"),
            onSave: { updated in
                print("✅ Guardado módulo: \(updated.title)")
            },
            onDelete: { deleted in
                print("🗑️ Borrado módulo: \(deleted.title)")
            }
        )
        .padding()
        .background(Color("bg"))
    }
