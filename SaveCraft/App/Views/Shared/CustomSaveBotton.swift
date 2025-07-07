//
//  CustomSaveBotton.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-07-05.
//

import SwiftUI

struct CustomSaveBotton: View {
    let title: String
    var onTap: () -> Void
    let addIcon: String?
    
    init(title: String, onTap: @escaping () -> Void, addIcon: String? = nil) {
        self.title = title
        self.onTap = onTap
        self.addIcon = addIcon
    }
    
    var body: some View {
        Button {
            onTap()
        } label: {
            HStack {
                if let icon = addIcon {
                    Image(systemName: icon)
                    
                }
                Text(title)
                    .fontWeight(.semibold)
                    
            }
            .font(.headline)
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
            .padding()
            .foregroundStyle(Color(UIColor { trait in
                trait.userInterfaceStyle == .dark ? .black : .white
            }))
            
        }
        .glassEffect(.regular.tint(.green).interactive(), in: .containerRelative)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    CustomSaveBotton(title: "Add to Save", onTap: {})
        .padding()
        .background(Color("bg"))
}
