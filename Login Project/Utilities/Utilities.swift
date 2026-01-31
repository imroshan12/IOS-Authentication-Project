//
//  Utilities.swift
//  Login Project
//
//  Created by Sarvesh Roshan on 29/01/26.
//

import Foundation
import UIKit

final class Utilities {
    
    static let shared = Utilities()
    
    private init (){}
    
    
    func topViewController(controller: UIViewController? = nil) -> UIViewController? {
        
//        let controller = controller ?? UIApplication.shared.keyWindow?.rootViewController
        let controller = controller ?? {
            if let windowScene = UIApplication.shared.connectedScenes
                .filter({ $0.activationState == .foregroundActive })
                .first as? UIWindowScene {
                return windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController
            }
            return nil
        }()
        
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }

}
