//
//  SettingsView.swift
//  Login Project
//
//  Created by Sarvesh Roshan on 26/01/26.
//

import SwiftUI
import Observation

@MainActor
@Observable
final class SettingsViewModel {
    
    var authProviders: [AuthProviderOptions] = []
    
    func loadAuthProviders() {
        if let providers = try? AuthenticationManager.shared.getProviders() {
            authProviders = providers
        }
    }
    
    func logOut() throws {
        try AuthenticationManager.shared.signOut()
    }
    
    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func updateEmail() async throws {
        let email = "emailUpdate@gmail.com"
        
        try await AuthenticationManager.shared.updateEmail(email: email)
    }
    
    func updatePassowrd() async throws {
        let password = "Hello@123"
        try await AuthenticationManager.shared.updatePassword(password: password)
    }
}

struct SettingsView: View {
    
    @State private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            Button("Log out") {
                Task {
                    do {
                        try viewModel.logOut()
                        showSignInView.toggle()
                    } catch {
                        print("Error while logout")
                    }
                }
            }
            if (viewModel.authProviders.contains(.email)) {
                emailSection
            }
            
        }
        .onAppear() {
            viewModel.loadAuthProviders()
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView(showSignInView: .constant(false))
    }
    
}

extension SettingsView {
    private var emailSection: some View {
        Section {
            Button("Reset password") {
                Task {
                    do {
                        try await viewModel.resetPassword()
                        print("Password reset")
                    } catch {
                        print("Error while reset")
                    }
                }
            }
            
            Button("Update email") {
                Task {
                    do {
                        try await viewModel.updateEmail()
                        print("Email update")
                    } catch {
                        print("Error while reset")
                    }
                }
            }
            
            Button("Update password") {
                Task {
                    do {
                        try await viewModel.updatePassowrd()
                        print("Password update")
                    } catch {
                        print("Error while reset")
                    }
                }
            }
        } header: {
            Text("Email Functions")
        }

    }
}
