//
//  SignInGoogleHelper.swift
//  Login Project
//
//  Created by Sarvesh Roshan on 29/01/26.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift

final class GoogleSignInHelper {
    
    @MainActor
    func getGoogleUser() async throws -> GoogleSignInResultModel {
        guard let topVC = Utilities.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken: String = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        let accessToken: String = gidSignInResult.user.accessToken.tokenString
        let name = gidSignInResult.user.profile?.name
        let email = gidSignInResult.user.profile?.email
        
        let tokens = GoogleSignInResultModel(accessToken: accessToken, idToken: idToken, name: name, email: email)
        
        return tokens
    }
}
