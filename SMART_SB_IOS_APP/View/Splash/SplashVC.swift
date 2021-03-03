//
//  LaunchScreen.swift
//  SMART_SB_APP_IOS
//
//  Created by 김남교 on 2021/01/10.
//

import UIKit
import WebP
import SwiftGifOrigin
class SplashVC: UIViewController {

    
    @IBOutlet weak var gifImg: UIImageView!
    
    override func loadView() {
        super.loadView()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Log.print("SplashVC viewDidLoad")
        self.navigationController?.navigationBar.isHidden = true
        
        //로딩 gif  이미지 가동
        let imageData = try? Data(contentsOf: Bundle.main.url(forResource: "incoming", withExtension: "gif")!)
        
        
        let advTimeGif = UIImage.gif(data: imageData!)
        gifImg!.frame.size = CGSize(width: 40, height: 20)
        gifImg.image = advTimeGif
        
        //위변조 탐지
        var userinfo : Dictionary<AnyHashable,Any> = [AnyHashable:Any]()
        userinfo["phoneNum"]=true
        userinfo["blkdg"]=true
        userinfo["adb"]=true
        //Eversafe.init(Constants.EVERSAFE.url,Constants.EVERSAFE.appid,userinfo)
        Eversafe.sharedInstance()?.initialize(withBaseUrl: Constants.EVERSAFE.url, appId: Constants.EVERSAFE.appid, userInfo: userinfo)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        Log.print("SplashVC viewDidAppear")
        //대기시간
        sleep(3)
        //메인화면 이동
        if myUserDefaults.string(forKey: Constants.UserDefaultsKey.CUST_NO) == nil {
            SceneCoordinator().transition(to: "Access", using: .root, animated: true)
        } else {
            SceneCoordinator().transition(to: "Main", using: .root, animated: true)
        }
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(true)
        Log.print("SplashVC viewWillDisappear")
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(true)
        Log.print("SplashVC viewDidDisappear")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning() // Dispose of any resources that can be recreated.
        super.viewDidAppear(true)
        Log.print("SplashVC didReceiveMemoryWarning")
    }
}



