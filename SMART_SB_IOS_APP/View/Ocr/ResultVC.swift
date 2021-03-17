//
//  ResultViewVC.swift
//  SMART_SB_APP_IOS
//
//  Created by 김남교 on 2021/02/22.
//

import UIKit
import Then
import WebP

protocol OcrResultDelegate {
    func successHandler(result: [String:String])
    func reTakeHandler()
}

class ResultVC: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var result:[String: Any] = [:] // 촬영 후 받은 데이터
    var type: IdentifyType = .주민등록증
    var delegate: OcrResultDelegate?
    var callbackData:[String: String] = [:] // 완료 후 데이터
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ResultViewVC viewDidLoad")
        Keyboard.shared.addScrollingKeyboardObservers(with: view, scrollView: scrollView)
        result.forEach { Log.print(message: "ocr 결과 \($0.key): \($0.value)")}
        setupUI()
    }
    
    //뷰 생성 끝나고
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("ResultViewVC viewDidAppear")
        
    }
    var keyboardShown:Bool = false // 키보드 상태 확인
    var originY:CGFloat? // 오브젝트의 기본 위치

    
    //터치시 키보드 내림
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
    deinit {
        Log.print(message: "*** deinit ResultVC ***")
    }
    
    
    
    private func setupUI() {
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        "resultrecognitionvalue"
                
        // 결과 이미지
        if let iod = result["resultimage"] as? Data {
            imageView.image = UIImage(data: iod)
            
            //사진 압축
//            guard let imageData = imageView.image!.jpegData(compressionQuality: 0.4) else {
//                return
//            }
//            Log.print("기존 이미지 사이즈 : \(imageData.count)")
            
            let encoder = WebPEncoder()
            let webpdata = try! encoder.encode(imageView.image!, config: .preset(.picture, quality: 30))
            
            Log.print("압축 이미지 사이즈 : \(webpdata.count)")
            
            //암호화
            let strBase64 = Function.AES256Encrypt(val: webpdata.base64EncodedString(options: .lineLength64Characters))
            
            callbackData["photoStr"] = strBase64 // 사진
        }
        
        // 얼굴 이미지
        if let iofd = result["faceimage"] as? Data {
//            imageView.image = UIImage(data: iofd)
        }
        
        stackView.addArrangedSubview(setTextView(title: "인식 종류", content: type.title))
        
        if let item = result["resultrecognitionvalue"] as? [String:Any] {
            // 성명 name
            if let nItem = item["NAME"] as? [String:String],
               let n = nItem["TEXT"] {
                stackView.addArrangedSubview(setTextView(title: "성명", content: n))
                callbackData["name"] = Function.AES256Encrypt(val: n) // 이름
            }
            
            var idNum = "" // 주민번호
            
            // 주민 앞자리 first id
            if let iItem = item["IDNUMBER_FIRST_SIX_DIGIT"] as? [String:String],
               let fI = iItem["TEXT"] {
                idNum += fI
                stackView.addArrangedSubview(setTextView(title: "주민등록번호", content: String(idNum) + "-*******")) // 합쳐진 주민번호
            }
            // 주민 뒷자리 last id
            if let iItem = item["IDNUMBER_LAST_SEVEN_DIGIT_ENCRYPTED"] as? [String:String],
               let lI = iItem["TEXT"],
               let encryptedData = Data(base64Encoded: lI), // 암호화 값
               let plainText = PACECRControl().decryptSEED128Data(encryptedData) { // 복호화
                idNum += plainText
            }
            callbackData["rbrNo"] = Function.AES256Encrypt(val: idNum)  // 주민번호
            idNum=""
            
            // 발급일자 issue date
            if let isItem = item["ISSUEDATE"] as? [String:String],
               let isI = isItem["TEXT"] {
                stackView.addArrangedSubview(setTextView(title: "발급일자", content: isI, isEnabled: true))
                callbackData["issueDate"] = Function.AES256Encrypt(val:isI.replacingOccurrences(of: "-", with: "").replacingOccurrences(of: ".", with: ""))
            }
            
            // 운전면허증 번호 license number
            
            if type.title == "운전면허증" {
                if let lcItem = item["LICENSENUMBER"] as? [String:String],
                   let lcI = lcItem["TEXT"],
                   let encryptedData = Data(base64Encoded: lcI), // 암호화 값
                   let plainText = PACECRControl().decryptSEED128Data(encryptedData) {
                    
                    let firstIndex = plainText.index(plainText.startIndex, offsetBy: 0)
                    let lastIndex = plainText.index(plainText.startIndex, offsetBy: 9)
                    let mobCom = "\(plainText[firstIndex..<lastIndex])***-**"
                    stackView.addArrangedSubview(setTextView(title: "운전면허증 번호", content:mobCom))
                    callbackData["driveNo"] = Function.AES256Encrypt(val: plainText)
                }
                
                //CHECKDIGIT
                if let lcItem = item["CHECKDIGIT"] as? [String:String],
                   let lcI = lcItem["TEXT"],
                   let encryptedData = Data(base64Encoded: lcI), // 암호화 값
                   let plainText = PACECRControl().decryptSEED128Data(encryptedData) {
                    
//                    let firstIndex = plainText.index(plainText.startIndex, offsetBy: 0)
//                    let lastIndex = plainText.index(plainText.startIndex, offsetBy: 9)
//                    let mobCom = "\(plainText[firstIndex..<lastIndex])***-**"
                    stackView.addArrangedSubview(setTextView(title: "secureNo 번호", content:plainText))
                    callbackData["secureNo"] = Function.AES256Encrypt(val: plainText)
                }
            }else{
                callbackData["driveNo"] = ""
                callbackData["secureNo"] = ""
            }
            
        }
    }
    
    
    @IBAction func pressRetake(_ sender: UIButton) {
        self.dismiss(animated: false, completion: {
            self.delegate?.reTakeHandler()
        })
    }
    
    @IBAction func pressNext(_ sender: UIButton) {
        let time = DispatchTime.now() + .seconds(1)
        IndicatorView().loading(flag: "ON")
        DispatchQueue.main.asyncAfter(deadline: time) {
            IndicatorView().hideProgress()
            self.dismiss(animated: true, completion: {
                self.delegate?.successHandler(result: self.callbackData)
            })
        }
    }
}

enum IdentifyType: Int {
    case 주민등록증 = 1
    case 운전면허증 = 3
    case 외국인등록증 = 9
    
    var title: String {
        var title = ""
        switch self {
        case .주민등록증:
            title = "주민등록증"
        case .운전면허증:
            title = "운전면허증"
        case .외국인등록증:
            title = "외국인등록증"
        }
        return title
    }
}

extension ResultVC {
    public func setTextView(title: String, content: String, hint: String = "-", isEnabled: Bool = false) -> UIView {
        let contentView = UIView().then {
            $0.backgroundColor = .white
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let titleLabel = UILabel().then {
            $0.text = title + ":"
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 14)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let textField = UITextField().then {
            $0.placeholder = hint
            $0.text = content
            $0.font = .systemFont(ofSize: 14)
            $0.textColor = .black
            $0.isEnabled = isEnabled
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(textField)
        
        contentView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true

        textField.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 20).isActive = true
        
        return contentView
    }
}
