//
//  ToastView.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-07-05.
//

import SwiftUI

struct ToastView: View {
    let message: String
    
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.green.gradient)
            Text(message)
                .font(.subheadline)
                .foregroundStyle(.primary)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 20)
        .glassEffect(.regular, in: .containerRelative)
        .clipShape(Capsule())
        .shadow(radius: 5)
        .transition(.move(edge: .top).combined(with: .opacity))
        .animation(.spring(), value: message)
        
    }
}

#Preview {
    ToastView(message: "Bills copied to next month")
}
