//
//  AppDelegate.swift
//  SMART_SB_APP_IOS
//
//  Created by 김남교 on 2021/01/10.
//

import UIKit
import Safetoken
import Then
import Firebase
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate, EversafeDelegate {
    func eversafeDidFailWithErrorCode(_ errorCode: String!, errorMessage: String!) {
        Log.print("errorCode : \(errorCode) , errorMessage : \(errorMessage)")
        yn = false
            DispatchQueue.main.async {
            UIApplication.shared.showAlert(message:errorMessage, confirmHandler: {
                    exit(0)
            })
        }
    }
    
    func eversafeDidFindThreats(_ threats: [Any]!) {
            Log.print("eversafeDidFindThreats threats : \(threats)")
        for tt in threats {
            yn = false
            DispatchQueue.main.async {
                UIApplication.shared.showAlert(message: (tt as AnyObject).localizedDescription, confirmHandler: {
                    exit(0)
            })
            return
        }
        }
    }
    var yn:Bool = true
    var window: UIWindow?
    //공동인증서 모듈
    var certManager = CertManager()
    
    //사설인증 모듈
    var tc=SafetokenSimpleClient.sharedInstance()
    //mOtp 모듈
    var oc=SafetokenFsbOtpClient.sharedInstance()
    //스마트앱 모듈
    var ac=SafetokenFsbAuthClient.sharedInstance()
    
    /**
     앱 초기설정
     */
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 응용 프로그램 시작 후 사용자 지정 지점을 재정의합니다.
        Log.print("AppDelegate application")
        
        UIApplication.shared.applicationIconBadgeNumber = 0 //알림배지 초기화
        
        certManager = CertManager.init()
        certManager.useIPv6=true
        
        
        setUserDefaults()
        setPush(application)
        
        /**************************** FDS service start *****************************/
        ixcSecureManager.initLicense(Configuration.IXC_LICENSE, andCustomID: Configuration.IXC_CUSTOMER_ID)
        /**************************** FDS service end *****************************/
        //위변조 탐지
        var userinfo : Dictionary<AnyHashable,Any> = [AnyHashable:Any]()
        userinfo["phoneNum"]=true
        //userinfo["blkdg"]=true
        //userinfo["adb"]=true
        
        Log.print("에버세이프 초기화")
        Eversafe.sharedInstance()?.initialize(withBaseUrl: Constants.EVERSAFE.url, appId: Constants.EVERSAFE.appid, userInfo: userinfo)
        Eversafe.sharedInstance()?.delegate=self
        return true
    }
    
    
    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    private func setUserDefaults() {
        if let bundleDictionary: [String: Any] = Bundle.main.infoDictionary {
            if let appName: String = bundleDictionary["CFBundleName"] as? String {
                myUserDefaults.set(appName, forKey: Constants.UserDefaultsKey.AppName)
            }
            if let appVersion: String = bundleDictionary["CFBundleShortVersionString"] as? String {
                myUserDefaults.set(appVersion, forKey: Constants.UserDefaultsKey.AppVersion)
            }
            if let appBundleId = bundleDictionary["CFBundleIdentifier"] as? String {
                myUserDefaults.set(appBundleId, forKey: Constants.UserDefaultsKey.AppBunleId)
            }
        }
    }
    
    private func setPush(_ application: UIApplication) {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions,completionHandler: {_, _ in })
        application.registerForRemoteNotifications()
    }
    
    func configureNotification() {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current() // 1
            .requestAuthorization(options: [.alert, .sound, .badge]) { // 2
                granted, error in
                Log.print(message: "granted: \(granted)")
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            Log.print(message: "Notification settings: \(settings)")
        }
    }
    
    internal func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        Log.print("sk : \(url.scheme)")
        if url.scheme == "smartsbbank" {
            guard let componets = NSURLComponents(url: url, resolvingAgainstBaseURL: true) else { return false}
            guard let params = componets.queryItems else { return false }
            if let type = params.first(where: { $0.name == "type"})?.value {
                myUserDefaults.set(type, forKey: Constants.UserDefaultsKey.LINK_DATA)
            }
            return true
        } else {
            return true
            
        }
    }
    
    let bgTaskView = UIView()
    // 실행 - (홈버튼 두번) -> 일시중지
    func applicationWillResignActive(_ application: UIApplication) {
        //스샷방지
        bgTaskView.backgroundColor = .white
        bgTaskView.frame = UIScreen.main.bounds
        window?.addSubview(bgTaskView)
    }
    
    // 실행 - (홈버튼) -> 백그라운드
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    // 중지 - (앱 재실행) -> 실행
    func applicationWillEnterForeground(_ application: UIApplication) {
        //스샷방지
        bgTaskView.removeFromSuperview()
        
    }
    // 중지 - (백그라운드 재실행) -> 실행
    func applicationDidBecomeActive(_ application: UIApplication){
        //스샷방지
        bgTaskView.removeFromSuperview()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}
extension AppDelegate : UNUserNotificationCenterDelegate {
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        completionHandler([.alert, .sound, .badge])

        // With swizzling disabled you must let Messaging know about the message, for Analytics
        Messaging.messaging().appDidReceiveMessage(userInfo)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        UIApplication.shared.applicationIconBadgeNumber = 0 //알림배지 초기화
        completionHandler()
        
        Log.print(message: "userInfo : \(userInfo)")
        
        if let strUrl = userInfo["gcm.notification.pushLnkUrl"] as? String {
            let instance = GlobalData.sharedInstance
            instance.pushClick = true
            instance.pushUrl = strUrl
            
            //let view = MainVC()
            //view.viewDidLoad()
        }
        
        if userInfo["fcm_options"] != nil {
            
            let imageTmp: [String: Any] = userInfo["fcm_options"] as! [String : Any]
            let image = imageTmp["image"]
        }
        
        // Print message ID.
        if  userInfo["aps"] != nil {
            if let messageID: [String: Any] = userInfo["aps"] as? [String : Any] {
                //messageID["alert"]
                if let reVal: [String: Any] = messageID["alert"] as? Dictionary {
                    let instance = GlobalData.sharedInstance
                    instance.pushClick = true
                    instance.pushTitle = reVal["title"] as? String
                    instance.pushMessage = reVal["body"] as? String
                }
            }
        }
    }
}

extension AppDelegate : MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        Log.print("파이어베이스 토큰: \(fcmToken)")
        if let m_fcmToken=fcmToken {
            UserDefaults.standard.set(m_fcmToken, forKey: "pushKey")
            let dataDict:[String: String] = ["token": m_fcmToken]
            NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        }
    }
//    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage?) {
//        print("Received data message: \(remoteMessage.appData)")
//    }
}

//extension AppDelegate: MessagingDelegate {
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
////        Log.print(message: "Firebase registration token: \(fcmToken)")
//
//        //Messaging.messaging().subscribe(toTopic: "fintechIOS")
//        Messaging.messaging().shouldEstablishDirectChannel = true
//
//        UserDefaults.standard.set(fcmToken, forKey: "pushKey")
//
//        let dataDict:[String: String] = ["token": fcmToken]
//        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
//    }
//
//    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
//        Log.print("Received data message: \(remoteMessage.appData)")
//        Messaging.messaging().shouldEstablishDirectChannel = true
//    }
//}

