//
//  AuthView.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-06-30.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var email = ""
    @State private var password = ""
    @State private var displayName = ""
    @State private var isRegistering = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                RadialGradient(
                    colors: [Color.accent.opacity(0.03), Color.clear],
                    center: .center,
                    startRadius: 0,
                    endRadius: 300
                )
                .blur(radius: 60)
                .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    Image(systemName: "dollarsign.gauge.chart.leftthird.topthird.rightthird")
                        .font(.system(size: 100, weight: .light, design: .rounded))
                    
                    Text("Save Craft")
                        .font(.largeTitle.bold())
                        .foregroundStyle(Color.accentColor)
                    
                    
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text(isRegistering ? "Sign Up" : "Sign In")
                                .foregroundStyle(Color.secondary)
                            
                            Text("with email")
                                .foregroundStyle(Color.text)
                        }
                        
                        Text("Enter your Credentails")
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom)
                    
                    
                    
                    
                    ModernTextField(
                        icon: "envelope",
                        placeholder: "Email",
                        text: $email
                    )
                    ModernSecureField(
                        icon: "lock",
                        placeholder: "Password",
                        text: $password
                    )
                    
                    if isRegistering {
                        ModernTextField(
                            icon: "person",
                            placeholder: "Name",
                            text: $displayName
                        )
                    }
                    
                    Button {
                        Task {
                            if isRegistering {
                                await viewModel.signUp(email: email, password: password, displayName: displayName)
                            } else {
                                await viewModel.signIn(email: email, password: password)
                            }
                        }
                    } label: {
                        Text(isRegistering ? "Register" : "Login")
                            .frame(maxWidth: .infinity)
                            .fontWeight(.semibold)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(Color.black)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    .disabled(viewModel.isLoading)
                    
                    Divider()
                    
                        Button {
                            withAnimation {
                                isRegistering.toggle()
                            }
                        } label: {
                            
                            HStack {
                                Text(isRegistering ? "Already have an account?" : "Don't have an account?")
                                    .foregroundStyle(.text)
                                    
                                
                                Text(isRegistering ? "Sign In" : "Sign Up")
                                    .font(.footnote)
                                    .foregroundStyle(.accent)
                            }
                            
                            
                                
                        }
                    
                    
                    if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                            .padding(.top, 8)
                    }
                    
                    
                    
                    Spacer()
                }
                .padding()
            }
            .fontDesign(.rounded)
            .background(Color.bg)
        }
    }
}

#Preview {
    AuthView()
        .environmentObject(AuthViewModel())
}
