//
//  UIApplication.swift
//  SMART_SB_APP_IOS
//
//  Created by 김남교 on 2021/01/11.
//

import Foundation
import UIKit

extension UIApplication {
    class func topViewController() -> UIViewController? {
        if let keyWindow = UIApplication.shared.keyWindow {
            if var viewController = keyWindow.rootViewController {
                while viewController.presentedViewController != nil {
                    viewController = viewController.presentedViewController!
                }
                print("topViewController -> \(String(describing: viewController))")
                
                //viewController.modalPresentationStyle = .fullScreen
                return viewController
            }
        }
        return nil
    }
    func showAlert(title: String = "알림",
                   message: String?,
                   hideCancel:Bool = true,
                   cancelTitle: String = "취소",
                   confirmTitle: String = "확인",
                   cancelHandler: (() -> Void)? = nil,
                   confirmHandler: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: cancelTitle, style: .cancel, handler: { action in
            //Log.print(message: "cancel")
            cancelHandler?()
        })
        let ok = UIAlertAction(title: confirmTitle, style: .default, handler: { action in
            //Log.print(message: "confirm")
            confirmHandler?()
        })
        if hideCancel == true {
            alert.addAction(ok)
        } else {
            alert.addAction(cancel)
            alert.addAction(ok)
        }
        
        let topView = UIApplication.topViewController()
        topView?.present(alert, animated: true, completion: nil)
//        keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func capchaView(image64: String,
                refreshHandler:(() -> Void)? = nil,
                cancelHander:(() -> Void)? = nil,
                completeHandler: (([String:String]) -> Void)? = nil) {
        let vc = CaptchaVC.instantiate(storyboard: "Captcha")
        vc.image            =   image64
        vc.completeHandler  =   completeHandler
        vc.refreshHandler   =   refreshHandler
        vc.cancelHander     =   cancelHander
        let topView = UIApplication.topViewController()
        topView?.present(vc, animated: true, completion: nil)
    }
    
    func OcrView(data:[String:Any] = [:],
                 completeHandler: ((Dictionary<String,String>) -> Void)? = nil,
                 cancelHandler: ((String,String) -> Void)? = nil) {
        let vc = OcrVC.instantiate(storyboard: "Ocr")
        vc.params=data
        vc.complete = completeHandler
        vc.failed = cancelHandler
        let topView = UIApplication.topViewController()
        topView?.modalPresentationStyle = .fullScreen
        topView?.present(vc, animated: true, completion: nil)
    }
    
    
    func CertView(title:String,
                 sub_title:String,
                 hint:String,
                 mode:Int,
                 data:[String:Any] = [:],
                 complete: ((Dictionary<String,Any>) -> Void)? = nil,
                 failed: ((String,String) -> Void)? = nil) {
        let vc = CertListVC.instantiate(storyboard: "CertList")
        vc.parameters=data
        vc.complete=complete
        vc.failed=failed
        vc.mode=mode
        let topView = UIApplication.topViewController()
        topView?.modalPresentationStyle = .fullScreen
        topView?.present(vc, animated: true, completion: nil)
    }
    
    func PattrunView(title:String,
                 sub_title:String,
                 hint:String,
                 register:Bool,
                 data:[String:Any] = [:],
                 complete: ((String) -> Void)? = nil,
                 failed: ((String) -> Void)? = nil) {
        let vc = PatternVC.instantiate(storyboard: "Pattern")
        vc.title_name = title
        vc.content = sub_title
        vc.register=register
        vc.hint = hint
        vc.data=data as! Dictionary<String,String>
        vc.complete = complete
        vc.failed = failed
        let topView = UIApplication.topViewController()
        topView?.modalPresentationStyle = .fullScreen
        topView?.present(vc, animated: true, completion: nil)
    }
    func BioView(title:String,
                 sub_title:String,
                 hint:String,
                 register:Bool,
                 data:[String:Any] = [:],
                 complete: ((String) -> Void)? = nil,
                 failed: ((String,Int32,String, Int32) -> Void)? = nil) {
       // let vc = PinVC.instantiate(storyboard: "Pin")
        let vc = BioVC()
        vc.register = register
        vc.data=data as! Dictionary<String,String>
        vc.complete=complete
        vc.failed=failed
        //pushViewController(to: vc)
        
        let topView = UIApplication.topViewController()
        topView?.modalPresentationStyle = .fullScreen
        topView?.present(vc, animated: true, completion: nil)
    }
    
    
    func PINView(title:String,
                 sub_title:String,
                 hint:String,
                 type:Int,
                 data:[String:Any] = [:],
                 completeHandler: ((String, String) -> Void)? = nil,
                 cancelHandler: (() -> Void)? = nil) {
        
        let vc = PinVC.instantiate(storyboard: "Pin")
        
        vc.key = ""
        vc.titleStr = title
        vc.hint = sub_title
        vc.maxInputLength = 6
        vc.minInputLength = 6
        vc.completeHandler = completeHandler
        vc.cancelHandler = cancelHandler
        if type == 1 {
            vc.keypadType = ESKeypadTypeNumericpad
        }else if type == 2 {
            vc.keypadType = ESKeypadTypeQwerty
        }
        let topView = UIApplication.topViewController()
        topView?.modalPresentationStyle = .fullScreen
        topView?.present(vc, animated: true, completion: nil)
    }
    
    func QwertyView(title:String,
                 data:[String:Any] = [:],
                 isShowDots:Bool,
                 completeHandler: ((String, String) -> Void)? = nil,
                 cancelHandler: (() -> Void)? = nil) {
        
        let vc = PinVC.instantiate(storyboard: "Pin")
        
        let hint = data["HINT"] as! String
        if let key = data["KEY"] as? String {
            vc.key = key
        }
        let max = UInt(data["MAX"] as! String)!
        let min = UInt(data["MIN"] as! String)!
        
        vc.titleStr = title
        vc.hint = hint
        vc.maxInputLength = max
        vc.minInputLength = min
        vc.completeHandler = completeHandler
        vc.cancelHandler = cancelHandler
        vc.keypadType=ESKeypadTypeQwerty
        
        
        vc.isShowDots=isShowDots
        let topView = UIApplication.topViewController()
        topView?.modalPresentationStyle = .fullScreen
        topView?.present(vc, animated: true, completion: nil)
    }
    //MARK: - PIN View
    func NumberView(title:String,
                 data:[String:Any] = [:],
                 completeHandler: ((String, String) -> Void)? = nil,
                 cancelHandler: (() -> Void)? = nil) {
        
        let vc = PinVC.instantiate(storyboard: "Pin")
        
        //let label = data["LABEL"] as! String
        let hint = data["HINT"] as! String
        if let key = data["KEY"] as? String {
            vc.key = key
        }
        let max = UInt(data["MAX"] as! String)!
        let min = UInt(data["MIN"] as! String)!
        vc.titleStr = title
        vc.hint = hint
        vc.maxInputLength = max
        vc.minInputLength = min
        vc.completeHandler = completeHandler
        vc.cancelHandler = cancelHandler
        vc.keypadType=ESKeypadTypeNumericpad
        let topView = UIApplication.topViewController()
        topView?.modalPresentationStyle = .fullScreen
        topView?.present(vc, animated: true, completion: nil)
    }
    
    
    func requestCameraPermission(completeHandler: (() -> Void)? = nil){
          AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
              if granted {
                  print("Camera: 권한 허용")
                    DispatchQueue.main.async {
                        completeHandler!()
                    }
              } else {
                  print("Camera: 권한 거부")
                    DispatchQueue.main.async {
                        UIApplication.shared.showAlert(message: "카메라 권한을 켜주세요")
                    }
              }
          })
      }
    
//    func customPINView(
//                controller:UIViewController
//                ,params:[String:Any] = [:]
//                ,completeHandler: ((String, String) -> Void)? = nil
//                ,cancelHandler: (() -> Void)? = nil) {
//
//        let vc = PinVC.instantiate(storyboard: "Pin")
//
//        let label   =   params["LABEL"] as! String
//        let hint    =   params["HINT"]  as! String
//        let min     =   UInt(params["MIN"] as! String)!
//        let max     =   UInt(params["MAX"] as! String)!
//
//        if let key=params["KEY"] as? String {
//            vc.key=key
//        }else {
//            vc.key=""
//        }
//        vc.titleStr = label
//        vc.hint = hint
//        vc.minInputLength=min
//        vc.maxInputLength=max
//        vc.completeHandler = completeHandler
//        vc.cancelHandler = cancelHandler
//        Log.print(message: "customPINView")
//        let topView = UIApplication.topViewController()
//        topView?.present(vc, animated: true, completion: nil)
//    }
}
