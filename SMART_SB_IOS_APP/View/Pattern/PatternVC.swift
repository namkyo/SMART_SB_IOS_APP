//
//  PatternVC.swift
//  SMART_SB_APP_IOS
//
//  Created by 최지수 on 2021/02/08.
//

import UIKit
import Safetoken
import SafetokenPattern

class PatternVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    
    var patternView: PatternView!
    var DeviceHeight: CGFloat = 0
    
    var pwFirst = ""
    var pw = ""
    
    let tc = SafetokenSimpleClient.sharedInstance()
    let patternAuth = SafetokenPatternAuth()
    
    var data: [String:String] = [:]
    var register = false
    
    var complete: ((String) -> Void)? = nil
    var failed: ((String) -> Void)? = nil
    
    var title_name = "간편 로그인"
    var content = "패턴 입력"
    var hint = "패턴을 그려주세요"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setup()
        addSubView()
        
    }
    
    func setup() {
        titleLabel.text = title_name
        contentLabel.text = content
        hintLabel.text = hint
        
    }
    
    // MARK: - 패턴뷰
    func addSubView() {
        
        if UIScreen.main.nativeBounds.height > 2300 {
            self.DeviceHeight = 0
        } else {
            self.DeviceHeight = 40
        }
        
        patternView = PatternView(delegate: self)
        
        patternView?.normalNodeColor = #colorLiteral(red: 0.7607843137, green: 0.7607843137, blue: 0.7607843137, alpha: 1) /// 기본 point color
        patternView?.pathColor = #colorLiteral(red: 0, green: 0.6235294118, blue: 0.9098039216, alpha: 1) /// 경로 color
        patternView?.selectedNodeColor = #colorLiteral(red: 0, green: 0.6235294118, blue: 0.9098039216, alpha: 1) /// 선택된 point color
        patternView?.layoutView()
        
        self.view.addSubview(patternView!)
        
        let views = ["patternView" : patternView!]
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(40)-[patternView]-(40)-|", options: .alignAllTop, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-(\(view.center.y - self.DeviceHeight))-[patternView]", options: .alignAllBottom, metrics: nil, views: views)
        NSLayoutConstraint.activate(constraints)
    }
    
    func pattern(toString pattern: [AnyHashable]?) -> String? {
        var str = ""
        for i in 0..<(pattern?.count ?? 0) {
            let point = pattern?[i] as? NSNumber
            str += "\(point?.intValue ?? 0)"
        }
        
        return str
    }
    
    // MARK: - 패턴 저장
    func patternStore(_ patterns:[AnyHashable]) {
        let patternString = pattern(toString: patterns) // 패턴입력값
        let patternHash = patternString?.sha1() // 입력값 hash
        
        if register { // pattern 등록
            guard pwFirst != "" else { //패턴 최초입력시
                if let pw = patternHash {
                    pwFirst = pw
                    patternView.invalidateCurrentPattern() // 패턴 초기화
                    self.contentLabel.text = "패턴 확인"
                    self.hintLabel.text = "패턴을 한번 더 그려주세요"
                }
                return
            }
            
            if let pw = patternHash, pw == pwFirst {
                self.pw = pw
                save()
            } else {
                patternView.invalidateCurrentPattern() // 패턴 초기화
                //UIApplication.shared.showAlert(message: "이전 입력한 패턴과 동일하게 입력해 주세요.")
                self.dismiss(animated: true, completion: {
                    self.failed?("9994")
                })
            }
            
        } else { // pattern 인증
            if let pw = patternHash {
                sign(pw)
            }
        }
        
    }
    
    //MARK: - 패턴 저장 함수
    func save() {
        Log.print(message: "save")
        guard let getToken = tc?.getToken() else {
            UIApplication.shared.showAlert(message: "PIN번호를 먼저 등록해 주세요.")
            self.patternView.invalidateCurrentPattern() // 패턴 초기화
            
            self.dismiss(animated: true, completion: {
                self.failed?("9999")
            })
            
            return
        }
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let tcc = appDelegate.tc!
        
        let pin = UserDefaults.standard.string(forKey: "PIN")!
        patternAuth.storeCredential(withToken: getToken, tokenClient: tcc, credential: pin, pattern: pw, onComplete: {
            self.dismiss(animated: true, completion: {
                self.complete?("")
            })
        })
    }
    
    func sign(_ pattern: String) {
        guard let getToken = tc?.getToken() else {
            UIApplication.shared.showAlert(message: "PIN번호를 먼저 등록해 주세요.")
            self.patternView.invalidateCurrentPattern() // 패턴 초기화
            return
        }
        
        guard let rnd = data["RANDOM_KEY"] else {
            UIApplication.shared.showAlert(message: "서버와의 통신이 원할하지 않습니다.\n다시 시도해 주세요.", confirmHandler: {
                self.dismiss(animated: true, completion: {
                    self.failed?("9999")
                })
            })
            return
        }
        
        var auth_msg = ""
        if let msg = data["AUTH_MESG"] {
            auth_msg = msg
        }
        
        patternAuth.generateSign(withToken: getToken, tokenClient: tc!, rnd: rnd, msg: auth_msg, pattern: pattern, failCheck: false, onComplete: { tnp in
            self.dismiss(animated: true, completion: {
                self.complete?(tnp.encodedMessage!)
            })
        }, onFail: { code, errMsg, count in
//            if count >= 5 {
//                self.dismiss(animated: true, completion: {
//                    self.failed?("9992")
//                })
//            }

//            UIApplication.shared.showAlert(message: "패턴을 정확히 입력해 주세요.(\(count)/5)")
//            self.patternView.invalidateCurrentPattern() // 패턴 초기화
            self.dismiss(animated: true, completion: {
                self.failed?("0000")
            })
        })
    }
    
    
    @IBAction func pressClose(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            self.failed?("close")
        })
    }
    
    
    
}


extension PatternVC: PatternDelegate {
    func enteredPattern(_ pattern: [Any]!) {
        guard pattern.count > 3 else {
            UIApplication.shared.showAlert(message: "4개 이상의 점을 연결해 주세요.")
            patternView.invalidateCurrentPattern()
            return
        }
        
        patternStore(pattern as! [AnyHashable])
    }
    
    func completedAnimations() {
    }
    
    func startedDrawing() {
    }
}
