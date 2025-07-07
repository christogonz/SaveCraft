//
//  ModernTextField.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-06-30.
//

import SwiftUI

struct ModernTextField: View {
    var icon: String?
    var placeholder: String
    @Binding var text: String
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            Image(systemName: icon ?? "")
                .foregroundStyle(.accent)
            
            TextField(placeholder, text: $text)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .foregroundStyle(Color("TextSecondary"))
                .focused($isFocused)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color("card"))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(isFocused ? Color(.accent) : Color.white.opacity(0.1), lineWidth: 0.8)
        )
        .animation(.easeInOut(duration: 0.2), value: isFocused)
        
    }
}

#Preview {
    ModernTextField(
        icon: "envelope",
        placeholder: "Email",
        text: .constant("")
    )
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color("bg"))
}
