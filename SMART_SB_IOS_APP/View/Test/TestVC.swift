//
//  TestVC.swift
//  SMART_SB_APP_IOS
//
//  Created by 김남교 on 2021/01/10.
//

import UIKit

class TestVC: UIViewController {
    
    override func loadView() {
        super.loadView()
        print("TestVC loadView")
        makeBtn()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TestVC viewDidLoad")
        
        
        let logMaster = ixcSecuLogMaster()
        logMaster.setServerKey("123123")
        logMaster.setCheckApp("")
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    func makeBtn(){
        var index:Int = 0
        
        let btn = UIButton()
        btn.setTitle("메인", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.frame=CGRect.init(x: 0,y: 50,width: 250,height: 50)
        btn.backgroundColor = .black
        btn.addTarget(self, action: #selector(onTapButton01), for: .touchUpInside)
        self.view.addSubview(btn)
        
        let btn2 = UIButton()
        btn2.setTitle("공동인증서 관리", for: .normal)
        btn2.setTitleColor(.white, for: .normal)
        btn2.frame=CGRect.init(x: 0,y: 100,width: 250,height: 50)
        btn2.backgroundColor = .black
        btn2.addTarget(self, action: #selector(onTapButton02), for: .touchUpInside)
        self.view.addSubview(btn2)
        
        let btn3 = UIButton()
        btn3.setTitle("공동인증서 수행", for: .normal)
        btn3.setTitleColor(.white, for: .normal)
        btn3.frame=CGRect.init(x: 0,y: 150,width: 250,height: 50)
        btn3.backgroundColor = .black
        btn3.addTarget(self, action: #selector(onTapButton03), for: .touchUpInside)
        self.view.addSubview(btn3)
        
        let btn4 = UIButton()
        btn4.setTitle("공동인증서 가져오기", for: .normal)
        btn4.setTitleColor(.white, for: .normal)
        btn4.frame=CGRect.init(x: 0,y: 200,width: 250,height: 50)
        btn4.backgroundColor = .black
        btn4.addTarget(self, action: #selector(onTapButton04), for: .touchUpInside)
        self.view.addSubview(btn4)
        
        let btn5 = UIButton()
        btn5.setTitle("OCR", for: .normal)
        btn5.setTitleColor(.white, for: .normal)
        btn5.frame=CGRect.init(x: 0,y: 250,width: 250,height: 50)
        btn5.backgroundColor = .black
        btn5.addTarget(self, action: #selector(onTapButton05), for: .touchUpInside)
        self.view.addSubview(btn5)
        
    }
    @objc func onTapButton01() {
        print("Button was tapped.")
        SceneCoordinator().transition(to: "Main", using: .root, animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }
    @objc func onTapButton02() {
        print("Button was tapped.")
        SceneCoordinator().transition(to: "CertList", using: .root, animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }
    @objc func onTapButton03() {
        print("Button was tapped.")
    }
    @objc func onTapButton04() {
        SceneCoordinator().transition(to: "CertImport", using: .root, animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }
    @objc func onTapButton05() {
        SceneCoordinator().transition(to: "Ocr", using: .root, animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //뷰 생성 끝나고
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("TestVC viewDidAppear")
    }
    
    
}
