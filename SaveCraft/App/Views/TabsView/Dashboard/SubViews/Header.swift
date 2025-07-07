//
//  Header.swift
//  SaveCraft
//
//  Created by Christopher Gonzalez on 2025-07-01.
//

import SwiftUI

struct Header: View {
    var displayName: String
    var profileImageURL: String? = nil
    
    var body: some View {
        HStack(spacing: 16) {
            if let url = profileImageURL, let imageURL = URL(string: url) {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 90, height: 90)
                .clipShape(Circle())
                .glassEffect(.regular, in: .circle)
                .shadow(radius: 6)
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 48))
                    .frame(width: 90, height: 90)
                    .glassEffect(.regular, in: .circle)
                    .foregroundStyle(.accent.gradient)
                    .clipShape(Circle())
            }
            
            
            VStack(alignment: .leading) {
                
                HStack {
                    Text("Welcome")
                        .font(.title3)
                        .foregroundColor(.text)
                    
                    Text(displayName)
                        .font(.title2.bold())
                        .foregroundColor(.accentColor)
                }

                Text("Dashboard")
                    .font(.title)
                    .foregroundStyle(.secondary)
            }
            .fontDesign(.rounded)
        }
    }
}

#Preview {
    Header(displayName: "Chris Gonzalez")
}
