//
//  IndicatorView.swift
//  SMART_SB_APP_IOS
//
//  Created by 김남교 on 2021/02/20.
//

import UIKit
import SwiftGifOrigin
import Then
import SnapKit
var alphaView: UIView? = UIView()
var backView: UIView? = UIView()
var imageView:UIImageView? = UIImageView()
var runName:UILabel? = UILabel()
class IndicatorView: UIViewController {
    func loading(params: [String:Any]) {
        if let flag = params["FLAG"] as? String {
            if flag == "ON" {
                showProgress()
            } else {
                hideProgress()
            }
        }
    }
    func loading2(flag : String , msg : String) {
        if flag == "ON" {
            showProgress2(msg: msg)
        } else {
            hideProgress()
        }
    }
    func loading(flag : String) {
        if flag == "ON" {
            showProgress()
        } else {
            hideProgress()
        }
    }
}

extension UIViewController {
    
    func progressView() -> UIImage {
        let imageData = try? Data(contentsOf: Bundle.main.url(forResource: "progress_loading", withExtension: "gif")!)
        //let advTimeGif = UIImage.gifImageWithData(data: imageData! as NSData)
        let advTimeGif = UIImage.gif(data: imageData!)
        
        return advTimeGif!
    }
    
    func showProgress() {
        let topView = UIApplication.topViewController()
        
        backView!.frame = self.view.frame
        backView!.backgroundColor = .clear
        
        alphaView!.frame = self.view.frame
        alphaView!.backgroundColor = .gray
        alphaView!.alpha = 0.7
        
        imageView!.image = progressView()
        imageView!.frame.size = CGSize(width: 80, height: 80)
        imageView!.center = self.view.center
        imageView!.contentMode = .scaleAspectFit
        
        backView!.addSubview(alphaView!)
        backView!.addSubview(imageView!)
        topView?.view.addSubview(backView!)
    }
    func showProgress2(msg : String) {
        let topView = UIApplication.topViewController()
        
        backView!.frame = self.view.frame
        backView!.backgroundColor = .clear
        
        alphaView!.frame = self.view.frame
        alphaView!.backgroundColor = .gray
        alphaView!.alpha = 0.7
        
        imageView!.image = progressView()
        imageView!.frame.size = CGSize(width: 80, height: 80)
        imageView!.center = self.view.center
        imageView!.contentMode = .scaleAspectFit
        
        backView!.addSubview(alphaView!)
        backView!.addSubview(imageView!)
        
        if runName != nil {
            
        }
        runName = UILabel().then{
            $0.text=msg
            $0.textColor = #colorLiteral(red: 0.02745098039, green: 0.1803921569, blue: 0.368627451, alpha: 1)
            $0.textAlignment = .center
            $0.font=UIFont.systemFont(ofSize: 18)
        }
        backView!.addSubview(runName!)
        runName!.snp.makeConstraints{
            $0.centerX.equalTo(imageView as! ConstraintRelatableTarget)
            $0.top.equalTo(imageView?.snp.bottom as! ConstraintRelatableTarget).offset(30)
        }
        topView?.view.addSubview(backView!)
    }
    
    func textChange(msg : String){
        runName?.text=msg
    }
    
    func hideProgress(dismissHandler: (() -> Void)? = nil) {
        if let loadingView = backView {
            loadingView.removeFromSuperview()
        }
    }
    func hideProgress2(dismissHandler: (() -> Void)? = nil) {
        if let loadingView = backView {
            loadingView.removeFromSuperview()
            runName?.removeFromSuperview()
        }
    }
}
