//
//  CertManage.swift
//  SMART_SB_APP_IOS
//
//  Created by 김남교 on 2021/02/24.
//

import Foundation
class CertManageVC : UIViewController{
    
    var complete:((Dictionary<String,String>) -> Void)? = nil
    var failed:((String) -> Void)? = nil
    var parameters:[String:String] = [:]
    
    @IBOutlet weak var 고객명Label: UILabel!
    @IBOutlet weak var 발급기관Label: UILabel!
    @IBOutlet weak var 인증서종류Label: UILabel!
    
    @IBOutlet weak var 발급일Label: UILabel!
    @IBOutlet weak var 만료일Label: UILabel!
    
    @IBAction func 닫기Button(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var certContent : Certificate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        Log.print(message: "CertManageVC : setupView")
        
        
        Log.print(message: "고객명Label : "+(certContent?.getSubjectName())!)
        Log.print(message: "발급기관Label : "+(certContent?.getOrganizationname())!)
        Log.print(message: "인증서종류Label : "+(certContent?.getPolicy())!)
        Log.print(message: "발급일Label : "+(certContent?.getValidFrom())!)
        Log.print(message: "만료일Label : "+(certContent?.getValidTo())!)
        Log.print(message: "만료일비밀번호변경Button : "+String((certContent?.getCheckExpired())!))
        
        
        
        고객명Label.text = certContent?.getSubjectName()
        발급기관Label.text = certContent?.getOrganizationname()
        인증서종류Label.text = certContent?.getPolicy()
        
        발급일Label.text = certContent?.getValidFrom()
        만료일Label.text = certContent?.getValidTo()
        
//        if certContent?.getCheckExpired() == 0 { // 인증서 만료일 경우 0:유효, 1:만료, 2:만료예정
//            비밀번호변경Button.isHidden = true
//            인증서삭제Button.isHidden=true
//        }
    }
    
}
