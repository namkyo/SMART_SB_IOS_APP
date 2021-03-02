//
//  AccessVC.swift
//  SMART_SB_APP_IOS
//
//  Created by 김남교 on 2021/01/31.
//

import UIKit
class AccessVC: UIViewController {
    
    @IBAction func next(_ sender: Any) {
        SceneCoordinator().transition(to: "Main", using: .root, animated: true)
    }
    override func loadView() {
        super.loadView()
        Log.print("AccessVC loadView")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        Log.print("TestVC viewDidLoad")
        
    }
    //뷰 생성 끝나고
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        Log.print("AccessVC viewDidAppear")
    }
    
    
}
