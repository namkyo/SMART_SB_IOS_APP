//
//  ViewController.swift
//  SMART_SB_APP_IOS
//
//  Created by 김남교 on 2021/01/10.
//

import UIKit
import WebKit
import Foundation
import LocalAuthentication
import MobileCoreServices
import WebP
class MainVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var webView: WKWebView!
    var datePickerView = UIView()
    
    var sussFunc:String!
    var failFunc:String!
    
    
    lazy var datePicker: UIDatePicker = {
        // Set datePicker (default is the position at the top of the screen).
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 50, width: self.view.frame.width, height: 200))
        datePicker.datePickerMode = .date
        datePicker.locale = Locale.init(identifier: "ko_KR")
        datePicker.timeZone = TimeZone(identifier: "Asia/Seoul")
        datePicker.backgroundColor = UIColor.white
        datePicker.layer.cornerRadius = 5.0
        datePicker.layer.shadowOpacity = 0.5
        return datePicker
    }()
    
    //컨트롤러 생성자
    override func viewDidLoad() {
        super.viewDidLoad()
        Log.print("MainVC viewDidLoad")
        self.navigationController?.navigationBar.isHidden = true
        webViewUI()
        setupView()
    }
    
    
    //뷰 생성
    override func loadView() {
        super.loadView()
        let contentController = WKUserContentController()
        let config = WKWebViewConfiguration()
        let userScript = WKUserScript(source: "postMessage()", injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        contentController.addUserScript(userScript)

        let preferences = WKPreferences()
        //        preferences.javaScriptEnabled = true
        preferences.javaScriptCanOpenWindowsAutomatically = true
        
        contentController.add(self, name: "callbackHandler")
        config.userContentController = contentController
        
        config.preferences = preferences
        
        webView = WKWebView(frame: self.view.frame, configuration: config)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        self.view.addSubview(webView)
    }
    
    
    func setupView() {
        Log.print("MainVC viewDidLoad : ")
        //1. 웹뷰 화면 생성≈
        Log.print("URL 셋팅")
        var urlString = ""
        
        switch Constants.MODE {
        case "H":
            Log.print("H")
            urlString = Constants.PageUrl.WEB_MAIN_H+Constants.PageUrl.WEB_MAIN_VIEW
        case "D":
            Log.print("D")
            urlString = Constants.PageUrl.WEB_MAIN_D+Constants.PageUrl.WEB_MAIN_VIEW
        case "R":
            Log.print("R")
            urlString = Constants.PageUrl.WEB_MAIN_R+Constants.PageUrl.WEB_MAIN_VIEW
        default:
            Log.print("mode error")
        }
        
//        //고객번호 없을시 약관동의 페이지
//        if myUserDefaults.string(forKey: Constants.UserDefaultsKey.CUST_NO) == nil {
//            urlString = Constants.PageUrl.WEB_MAIN_R+Constants.PageUrl.WEB_SIGN_UP
//        }
        
        if urlString == ""{
            UIApplication.shared.showAlert(message: "접속 정보 에러",confirmHandler: {
                exit(0)
            })
            return
        }
        
        Log.print("접속URL : "+urlString)
        let request = URLRequest(url: URL(string: urlString)!)
        //웹뷰 url셋팅
        self.webView.load(request)
    }
    
    //뷰 생성 끝나고
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        Log.print("MainVC viewDidAppear : ")
    }
    
    
    func webViewUI() {
        if #available(iOS 11.0, *)
        {
            let safeArea = self.view.safeAreaLayoutGuide
            webView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
            webView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
            webView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
            webView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        }
        else
        {
            webView.frame = CGRect(x: 0, y: 20, width: self.view.frame.width, height: self.view.frame.height-20)
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            webView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            webView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        Log.print("MainVC viewWillDisappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        Log.print("MainVC viewDidDisappear")
    }
}

//MARK: - Bridge Callback Handler
extension MainVC: WKScriptMessageHandler {
    //웹뷰에서 요청
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "callbackHandler" {
            guard let dictionary: [String: Any] = message.body as? Dictionary else {
                Log.print(message: "json String Error")
                return
            }
            
            let sf = dictionary["SF"] as! String
            let ff = dictionary["FF"] as! String
            sussFunc=sf;
            failFunc=ff
            Log.print("SF : "+sf)
            Log.print("FF:  "+ff)
            if let jsonString = dictionary["DATA"] as? String{
                Log.print("DATA :  "+jsonString)
                let jsonData = jsonString.data(using: .utf8)!
                let dicData = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves)
            
                if let reVal: [String: Any] = dicData as? Dictionary {
                    guard let serviceCd = reVal["serviceCd"] as? String else {
                        Log.print(message: "serviceCd nil")
                        return
                    }
                    Log.print(message: "native serviceCd : " + serviceCd)
                    
                    guard let params = reVal["params"] as? [String: Any] else {
                        Log.print(message: "params error")
                        return
                    }
                    Log.print(message: "native params : " + params.description)
                    
                    switch serviceCd {
                        case Constants.ServiceCode.AUTHORIZATION:
                            Log.print(message: "AUTHORIZATION ")
                            Authorization().doAuthorization(params: params, sf: sf, ff: ff, webView: webView)
                            break
                        case Constants.ServiceCode.TRANSKEY:
                            Log.print(message: "TRANSKEY ")
                            KeyPad().secureKeyPad(params: params, sf: sf, ff: ff, webView: webView)
                            break
                        case Constants.ServiceCode.OCR:
                            Log.print(message: "OCR ")
                            
                            //카메라 권한
                                
                            UIApplication.shared.requestCameraPermission(completeHandler: {
                                OcrService().ocrGo(params: params, sf: sf, ff: ff, webView: self.webView)
                            })
                            break
                        case Constants.ServiceCode.SIGN_CERT_MANAGE:
                            Log.print(message: "SIGN_CERT_MANAGE ")
                            CertService().certManager(params: params, sf: sf, ff: ff, webView: webView)
                            break
                        case Constants.ServiceCode.SIGN_CERT:
                            Log.print(message: "SIGN_CERT ")
                            CertService().certSign(params: params, sf: sf, ff: ff, webView: webView)
                            break
                        case Constants.ServiceCode.SIGN_CERT_REG:
                            Log.print(message: "SIGN_CERT_REG ")
                            CertService().certImport(params: params, sf: sf, ff: ff, webView: webView)
                            break
                        case Constants.ServiceCode.CALENDAR:
                            Log.print(message: "CALENDAR ")
                            showDatePicker()
                            break
                        case Constants.ServiceCode.SCRAPING:
                            Log.print(message: "SCRAPING ")
                            CertService().scraping(params: params, sf: sf, ff: ff, webView: webView)
                            break
                        //웹에서 요청하는 setAdata,getData 함수 처리
                        case Constants.ServiceCode.APP_DATA:
                            Log.print(message: "APP_DATA ")
                            let resultData = Appdata().appData(params: params)
                            DataWebSend().resultWebSend(resultCd: "0000", dicParmas:resultData, resultFunc : sf ,webView: self.webView)
                            break
                        case Constants.ServiceCode.APP_LINK:
                            Log.print(message: "APP_LINK ")
                            Function.AppLink(params)
                            break
                        case Constants.ServiceCode.WEB_LINK:
                            Log.print(message: "WEB_LINK ")
                            openWebSite(params: params,sf: sf,ff: sf)
                            break
                        case Constants.ServiceCode.WEB_SUBMIT:
                            Log.print(message: "WEB_LINK ")
                            callWebSite(params: params)
                            break
                        case Constants.ServiceCode.GET_ADID:
                            Log.print(message: "GET_ADID ")
                            let resultData = Function.getADID()
                            DataWebSend().resultWebSend(resultCd: "0000", dicParmas:resultData, resultFunc : sf ,webView: self.webView)
                            break
                        case Constants.ServiceCode.LOADING:
                            Log.print(message: "LOADING ")
                            IndicatorView().loading(params: params)
                            break
                        case Constants.ServiceCode.FDS:
                            Log.print(message: "FDS ")
                            let resultData = Function.getFds(params: params)
                            DataWebSend().resultWebSend(resultCd: "0000", dicParmas:resultData, resultFunc : sf ,webView: self.webView)
                            break
                        case Constants.ServiceCode.CAMERA:
                        Log.print(message: "CAMERA ")
                            //카메라의 사용가능 여부를 확인

                            if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
                                sussFunc=sf
                                imagePicker.delegate = self
                                imagePicker.sourceType = .camera
                                imagePicker.mediaTypes=[kUTTypeImage as String]
                                imagePicker.allowsEditing=false
                                present(imagePicker,animated: true, completion: nil)
                            }else{
                                UIApplication.shared.showAlert(message: "application cannot access the photo album")
                                
                            }
                            
                       // DataWebSend().resultWebSend(resultCd: "0000", dicParmas:resultData, resultFunc : sf ,webView: self.webView)
                        break
                            
                        case Constants.ServiceCode.APP_CLOSE:
                            Log.print(message: "APP_CLOSE ")
                            exit(0)
                            break
                        default:
                            Log.print(message: "default ")
                            break
                    }
                }
            }
        }
    }
}

//MARK :-
extension MainVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {
        if(challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
            let cred = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            completionHandler(.useCredential, cred)
        } else {
            completionHandler(.performDefaultHandling, nil)
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        if let tempStr = webView.url?.absoluteString {
            if tempStr.hasPrefix("tel") {
                let numberURL = webView.url //NSURL(string: urlString)
                //UIApplication.shared.openURL(numberURL!)
                //UIApplication.shared.canOpenURL(numberURL!)
                UIApplication.shared.open(numberURL!, options: [:], completionHandler: nil)
            }
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let strUrl = navigationAction.request.url?.absoluteString
        guard let url = URL(string: strUrl!) else { return }
        
        if ((strUrl?.hasPrefix("tauthlink"))! || (strUrl?.hasPrefix("ktauthexternalcall"))! || (strUrl?.hasPrefix("upluscorporation"))! || (strUrl?.hasPrefix("niceipin2"))!) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
            decisionHandler(.cancel)
            return
        }
        
        decisionHandler(.allow)
        return
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        webView.evaluateJavaScript("navigator.userAgent", completionHandler: { result, error in
            if let userAgent = result as? String {
                
            }
        })
    }
}
//MARK :-
extension MainVC: WKUIDelegate {
    
    //alert 처리
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        //{serviceCd:'SIGN_CERT', params:{rbrNo:'주민번호', signData:'인증서명데이타'}}
        //message    String    "\"{“serviceCd”:”SIGN_CERT”, “params”:{“rbrNo”:”주민번호”, “signData”:”인증서명데이타”}}\""
        
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: {
            (action) in completionHandler()
            
        }))
        self.present(alertController, animated: true, completion: nil)
        
        let jsonString = message
        
        let jsonData = jsonString.data(using: .utf8)!
        let dicData = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves)
        
        
    }
    
    //confirm 처리
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: {
            (action) in completionHandler(true)
            
        }))
        alertController.addAction(UIAlertAction(title: "취소", style: .default, handler: {
            (action) in completionHandler(false)
            
        }))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    //confirm 처리2
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        
        let alertController = UIAlertController(title: "", message: prompt, preferredStyle: .alert)
        alertController.addTextField {
            (textField) in textField.text = defaultText
            
        }
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: {
            (action) in
            if let text = alertController.textFields?.first?.text {
                completionHandler(text)
                
            } else {
                completionHandler(defaultText)
                
            } }))
        
        alertController.addAction(UIAlertAction(title: "취소", style: .default, handler: {
            (action) in completionHandler(nil)
            
        }))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
            
        }
        return nil
        
    }
    
    func webViewDidClose(_ webView: WKWebView) {
    }
    
    
    // 중복적으로 리로드 방지
    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        webView.reload()
        
    }
    
    func webViewReload() {
        viewDidLoad()
    }
    
    
    
    //web 사이트 호출
    func openWebSite(params:Dictionary<String, Any>,sf:String,ff:String) {
        var dicParams: Dictionary<String, Any> = [String:Any]()
        dicParams["title"] = "web호출"
        let urlString = params["url"] as! String
        let encoded  = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let numberURL = URL(string: encoded!) //NSURL(string: urlString)
        //UIApplication.shared.openURL(numberURL!)
        //UIApplication.shared.canOpenURL(numberURL!)
        
        if UIApplication.shared.canOpenURL(numberURL!) {
            //Function.DFT_TRACE_PRINT(output: "numberURL:",numberURL as Any)
            UIApplication.shared.open(numberURL!, options: [:], completionHandler: {
                (success) in
                
                let resultData = Function.getFds(params: params)
                DataWebSend().resultWebSend(resultCd: "0000", resultFunc : sf ,webView: self.webView)
            })
        } else {
            let resultData = Function.getFds(params: params)
            DataWebSend().resultWebSend(resultCd: "9991", resultFunc : sf ,webView: self.webView)
            return
        }
    }
    
    //web 사이트 서브밋(post)
    func callWebSite(params:Dictionary<String, Any>) {
        let reqData = params["reqData"] as! String
        let url = params["url"] as! String
        //Function.DFT_TRACE_PRINT(output: "url:",url)
        let reVal = Connection.connect(requestUrl: url, data: reqData)
    }
    
    
    //MARK: - Calendar
    func showDatePicker(){
        let datePickerH = (self.view.frame.height-250)
        datePickerView.frame = CGRect(x: 0, y: datePickerH, width: self.view.frame.width, height: 200)
        //Formate Date

        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        toolbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        let doneButton = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelDatePicker));

        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)

        datePickerView.addSubview(datePicker)
        datePickerView.addSubview(toolbar)
        self.view.addSubview(datePickerView)
    }

    @objc func donedatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let selectedDate: String = formatter.string(from: datePicker.date)

        self.view.endEditing(true)

        let data:[String:Any] = ["resData": selectedDate]
        DataWebSend().resultWebSend(resultCd: "0000", dicParmas:data, resultFunc : sussFunc ,webView: self.webView)
        datePickerView.removeFromSuperview()
    }

    @objc func cancelDatePicker() {
        self.view.endEditing(true)
        datePickerView.removeFromSuperview()
    }
    
    // 사진 찍은 후, 앨범에서 사진을 가져온 후 실행되는 함수
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        Log.print("일반카메라")
        var resultData: Dictionary<String, Any> = [String:Any]()
        
        
        let mediaType = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.mediaType.rawValue)] as! NSString
        Log.print("mediaType : \(mediaType)")
        
        let captureImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        //사진 압축
        guard let imageData = captureImage.jpegData(compressionQuality: 0.4) else {
            return
        }
        
        Log.print("일반 이미지 사이즈 : \(imageData.count)")
        let encoder = WebPEncoder()
        let webpdata = try! encoder.encode(captureImage, config: .preset(.picture, quality: 30))
        
        Log.print("압축 이미지 사이즈 : \(webpdata.count)")
        
        //암호화
        let strBase64 = Function.AES256Encrypt(val: webpdata.base64EncodedString(options: .lineLength64Characters))
        resultData["photoStr"]=strBase64
        self.dismiss(animated: true, completion: {
            DataWebSend().resultWebSend(resultCd: "0000", dicParmas:resultData, resultFunc : self.sussFunc ,webView: self.webView)
        })
        
    }
    @available(iOS 2.0, *)
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        Log.print("일반카메라 취소")
        let resultData: Dictionary<String, Any> = [String:Any]()
        self.dismiss(animated: true, completion: {
            DataWebSend().resultWebSend(resultCd: "9997", dicParmas:resultData, resultFunc : self.sussFunc ,webView: self.webView)
        })
    }
    
}
