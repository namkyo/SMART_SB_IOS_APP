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
        
        
    }
    
    func seletServer(){
        let alert_start = UIAlertController(title: "앱 환경선택", message: "고르세요", preferredStyle: .alert)
            
        
        let ok = UIAlertAction(title: "개발서버", style: .default, handler: {_ in
//            Constants.MODE="D"
            self.nertworkCheck()
        })
        let cancel = UIAlertAction(title: "운영서버", style: .cancel, handler: {_ in
//            Constants.MODE="R"
            self.nertworkCheck()
        })
        alert_start.addAction(ok)
        alert_start.addAction(cancel)
        self.present(alert_start,animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        Log.print("SplashVC viewDidAppear")
        
        //seletServer()
        nertworkCheck()
    }
    
    func nertworkCheck(){
        //인터넷 연결상태 체크
        if (Function.isInternetAvailable)() {
            Log.print("인터넷 정상")
        //internet avilable
            //대기시간
            sleep(3)
            //메인화면 이동
            //let appDelegate  = UIApplication.shared.delegate as! AppDelegate
            
            if myUserDefaults.string(forKey: Constants.UserDefaultsKey.CUST_NO) == nil {
                SceneCoordinator().transition(to: "Access", using: .root, animated: true)
            } else {
                SceneCoordinator().transition(to: "Main", using: .root, animated: true)
            }
         
        } else {
            Log.print("인터넷 미연결")
            
        //internet 'not' avilable
            UIApplication.shared.showAlert(message: "인터넷 미연결",confirmHandler: {
                exit(0)
            })
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



