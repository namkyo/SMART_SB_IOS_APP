//
//  OcrVC.swift
//  SMART_SB_APP_IOS
//
//  Created by 김남교 on 2021/02/22.
//

import UIKit

protocol OCRDelegate {
    func completedOCR(result:[String:String])
}

class OcrVC: UIViewController {
    var resultImageData : NSData? = nil
    var delegate: OCRDelegate?
    var params : [String:Any] = [:]
    var complete:((Dictionary<String,String>) -> Void)? = nil
    var failed:((String,String) -> Void)? = nil
    
    //다음버튼
    @IBAction func next(_ sender: Any) {
        Log.print(message: "ocr next")
        showCamera()
    }
    //취소버튼
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            self.failed!("9997","작업을취소하였습니다")
        })
    }
    //닫기버튼
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            self.failed!("9997","작업을취소하였습니다")
        })
    }
    
    deinit {
        Log.print(message: "*** deinit OcrVC ***")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.isHidden = true
        Log.print("OcrVC viewDidLoad")
    }
    override func loadView() {
        super.loadView()
        Log.print("OcrVC loadView")
    }
    //뷰 생성 끝나고
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        Log.print("OcrVC viewDidAppear")
    }
    
    private func showCamera() {
        let vc = CaptureViewController.instantiate(storyboard: "Ocr")
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func captureCompleteNotification(_ notification: Notification){
        var dicResults = ""
    }
}

// OCR 촬영 후 callBack
extension OcrVC: OcrCaptureDelegate {
    func completeCapture(_ result: [String : Any]!, type: Int32) {
        let vc = ResultVC.instantiate(storyboard: "Ocr")
        vc.result = result
        vc.delegate = self
        if let t = IdentifyType(rawValue: Int(type)) {
            vc.type = t
        }
        self.present(vc, animated: false, completion: nil)
    }
}

// OCR 재촬영 callBakc
extension OcrVC: OcrResultDelegate {
    func successHandler(result: [String : String]) {
        self.dismiss(animated: true, completion: {
            //self.delegate?.completedOCR(result: result)
            //UIApplication.shared.showAlert(message: "result: \(result)")
            self.complete!(result)
            Log.print("OCR 끝")
        })
    }
    func reTakeHandler() {
        showCamera()
    }
}
