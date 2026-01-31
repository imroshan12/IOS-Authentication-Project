//
//  ContentView.swift
//  Login Project
//
//  Created by Sarvesh Roshan on 23/09/25.
//

import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    var body: some View {
        NavigationStack {
            VStack {
                TextField(text: $username) {
                    Text("Username")
                }
                .border(.secondary)
                .textFieldStyle(.roundedBorder)
                
                TextField(text: $password) {
                    Text("Username")
                }
                .border(.secondary)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                
                NavigationLink("Login", destination: RootView())
                Button {
                    username = "Sarvesh"
                    
                } label: {
                    Text("Login")
                }
                .frame(width: 200)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(.green.mix(with: .yellow, by: 0.15))
                .foregroundStyle(.white)
                .clipShape(.rect(cornerRadius: 100))
                
                Spacer()
            }
            .padding(.top, 200)
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    ContentView()
}
