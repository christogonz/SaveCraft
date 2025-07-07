//
//  Settings View.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-07-01.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    
    var body: some View {
        VStack {
            Text("Settings View")
            
            Button("Sign Out") {
                Task {
                    await authViewModel.signOut()
                }
            }
            .buttonStyle(.glass)
            .padding()
            .foregroundColor(.red)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("bg"))
    }
}

#Preview {
    SettingsView()
}
