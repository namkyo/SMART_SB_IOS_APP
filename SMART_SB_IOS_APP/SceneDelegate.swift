//
//  SceneDelegate.swift
//  SMART_SB_APP_IOS
//
//  Created by 김남교 on 2021/01/10.
//

import UIKit
@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    
    let bgTaskView = UIView()
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // 제공된 UIWindowScene`scene`에 UIWindow`window`를 선택적으로 구성하고 연결하려면이 메서드를 사용합니다.
        // 스토리 보드를 사용하는 경우`window` 속성이 자동으로 초기화되어 장면에 연결됩니다.
        //이 델리게이트는 연결 장면 또는 세션이 새로운 것을 의미하지 않습니다 (대신`application : configurationForConnectingSceneSession` 참조).
        
        
        
        /* 다크모드일때 시스템디폴트 색상 변경 */
        if #available(iOS 13.0, *) {
            self.window?.overrideUserInterfaceStyle = .light
        }
        SceneCoordinator().transition(to: "Splash", using: .root, animated: true)
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        
        bgTaskView.removeFromSuperview()
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        bgTaskView.backgroundColor = .white
        bgTaskView.frame = UIScreen.main.bounds
        window?.addSubview(bgTaskView)
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
}

