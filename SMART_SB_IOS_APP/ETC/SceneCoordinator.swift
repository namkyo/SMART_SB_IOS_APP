//
//  SceneCoordinator.swift
//  SMART_SB_APP_IOS
//
//  Created by 김남교 on 2021/01/30.
//

import Foundation
class SceneCoordinator {
    
    var window: UIWindow? {
        if #available(iOS 13, *) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let delegate = windowScene.delegate as? SceneDelegate, let window = delegate.window else { return nil }
                   return window
        }
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate, let window = delegate.window else { return nil }
        return window
    }
    
    func transition(to scene: String, using style: TransitionStyle, animated: Bool) {
        Log.print("SceneCoordinator : "+scene)
        let storyBoard = UIStoryboard(name: scene, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: scene + "VC")
        let topView = UIApplication.topViewController()
        
       
        switch style {
        case .modal:
            topView?.present(vc, animated: animated, completion: nil)
        case .push:
            let nvc = UINavigationController(rootViewController: vc)
            topView?.navigationController?.pushViewController(nvc, animated: animated)
        case .root:
            let nvc = UINavigationController(rootViewController: vc)
            if #available(iOS 13.0, *) {
                self.window?.rootViewController = nvc
                self.window?.makeKeyAndVisible()
//                let sceneDelgate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
//                let window = sceneDelgate.window
//                window?.rootViewController = nvc
//                window?.makeKeyAndVisible()
            } else {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let window = appDelegate.window
                window?.rootViewController = nvc
                window?.makeKeyAndVisible()
            }
        }
    }
}

enum TransitionStyle {
    case root
    case push
    case modal
}
