//
// Created by 김남교 on 2021/02/25.
//

import Foundation
import WebKit
import SwiftyJSON
protocol ScrapingDelegate {
//    func ScrapingData(data: [String:String])
    func ScrapingData(data: String)
    func onCapcha(image64: String)
    func failCaptcha(code: String, message:String)
}

class Scraping : NSObject , SASManagerDelegate {
    var delegate: ScrapingDelegate?
    var sasManager : SASManager?
    var parameters:[String:Any] = [:]
    var parameters_cert:[String:String] = [:]
    
    
    var scrapingcompleteHandler:((String,Dictionary<String,Any>) -> Void)? = nil
    
    var resultData : Dictionary<String,Any> = [String:Any]()
    
    func runScraping(params:Dictionary<String, Any>,cert:Dictionary<String, String>,handler: @escaping ((String,Dictionary<String,Any>) -> Void)) {
        
        IndicatorView().hideProgress2()
        IndicatorView().loading2(flag: "ON",msg: "1..10 [민원24] : 보안문자 요청")
        
        
        parameters=params
        parameters_cert=cert
        scrapingcompleteHandler=handler
        //sasManager=SASManager.init()
        sasManager=(SASKeySharpFacotry.createSASManager() as! SASManager)
        
        
        sasManager!.delegate=self
        sasManager!.setDebugMode(false)
        
        //보안문자
        minwonScraping01(params: params, cert: cert, sasManager: sasManager)
        
    }
    
    private func minwonScraping01(params:Dictionary<String, Any>,cert:Dictionary<String, String>,sasManager : SASManager?){
        Log.print("민원스크랩핑 보안문자")
        sasManager!.run(0, in:secureStr(),asyncMode: true)
    }
    
    private func minwonScraping02(params:Dictionary<String, Any>,cert:Dictionary<String, String>,secuerStr : String){
        Log.print("민원스크랩핑 스크래핑2")
        
        
        var MinWon1: JSON = JSON(params["MinWon_1"] as Any)
        Log.print("MinWon1 : \(MinWon1)")
        
        MinWon1["Input"]["주민등록번호"].string=Function.AES256Decrypt(val: MinWon1["Input"]["주민등록번호"].string!)
        MinWon1["Input"]["보안문자"].string=secuerStr
        
        //Log.print("파라미터 : \(MinWon1)")
        
        var MinWon2: JSON = JSON(params["MinWon_2"] as Any)
        MinWon2["Input"]["인증서"]["이름"].string=cert["name"]!
        MinWon2["Input"]["인증서"]["만료일자"].string=cert["validTo"]!
        MinWon2["Input"]["인증서"]["비밀번호"].string=Function.AES256Decrypt(val: cert["password"]!)
        
        Log.print("파라미터 : \(MinWon2)")
        var MinWon3: JSON = JSON(params["MinWon_3"] as Any)
        Log.print("파라미터 : \(MinWon3)")

        sasManager!.run(1, in: "\(MinWon1)",asyncMode: true)
        sasManager!.run(2, in: "\(MinWon2)",asyncMode: true)
        sasManager!.run(3, in: "\(MinWon3)",asyncMode: true)
    }
    
    private func homeScraping(params:Dictionary<String, Any>,cert:Dictionary<String, String>,rbrNo:String){
        var HOME_1: JSON = JSON(params["HOME_1"] as Any)
        HOME_1["Input"]["주민사업자번호"].string=Function.AES256Decrypt(val: HOME_1["Input"]["주민사업자번호"].string!)
        HOME_1["Input"]["인증서"]["이름"].string=cert["name"]!
        HOME_1["Input"]["인증서"]["만료일자"].string=cert["validTo"]!
        HOME_1["Input"]["인증서"]["비밀번호"].string=Function.AES256Decrypt(val: cert["password"]!)
        
        var HOME_2: JSON = JSON(params["HOME_2"] as Any)
        HOME_2["Input"]["주민등록번호"].string=Function.AES256Decrypt(val: HOME_2["Input"]["주민등록번호"].string!)
        HOME_2["Input"]["인증서"]["이름"].string=cert["name"]!
        HOME_2["Input"]["인증서"]["만료일자"].string=cert["validTo"]!
        HOME_2["Input"]["인증서"]["비밀번호"].string=Function.AES256Decrypt(val: cert["password"]!)
        
        let HOME_3: JSON = JSON(params["HOME_3"] as Any)
        var HOME_4: JSON = JSON(params["HOME_3"] as Any)
        HOME_4["Input"]["사업자등록번호"].string=rbrNo
        sasManager!.run(7, in: "\(HOME_1)",asyncMode: true)
        sasManager!.run(8, in: "\(HOME_2)",asyncMode: true)
        sasManager!.run(9, in: "\(HOME_3)",asyncMode: true)
        sasManager!.run(10, in: "\(HOME_3)",asyncMode: true)
    }
    private func nhisScraping(params:Dictionary<String, Any>,cert:Dictionary<String, String>){
        
        var NHIS_1: JSON = JSON(params["NHIS_1"] as Any)
        NHIS_1["Input"]["인증서"]["이름"].string=cert["name"]!
        NHIS_1["Input"]["인증서"]["만료일자"].string=cert["validTo"]!
        NHIS_1["Input"]["인증서"]["비밀번호"].string=Function.AES256Decrypt(val: cert["password"]!)
        let NHIS_2: JSON = JSON(params["NHIS_2"] as Any)
        let NHIS_3: JSON = JSON(params["NHIS_3"] as Any)
        sasManager!.run(4, in: "\(NHIS_1)",asyncMode: true)
        sasManager!.run(5, in: "\(NHIS_2)",asyncMode: true)
        sasManager!.run(6, in: "\(NHIS_3)",asyncMode: true)
        
    }
    /**
     *  서버에러 및 스크래핑 에러
     */
    private func scrapingError(index: Int, msg: String) {
        DispatchQueue.main.async {
            IndicatorView().hideProgress()
            UIApplication.shared.showAlert(message: "\(msg)")
        }
    }
    
    //민원24 보안문자 input
    private func secureStr() -> String{
        let MINWON1:JSON = ["Class":"민원신청조회"
                         ,"Module":"MinWon"
                         ,"Job":"보안문자"
                         ,"INPUT":""
        ]
//        var MINWON1 : Dictionary<String,Any> = [String:Any]()
//        MINWON1["Class"]="민원신청조회"
//        MINWON1["Module"]="MinWon"
//        MINWON1["Job"]="보안문자"
//        let INPUT : Dictionary<String,Any> = [String:Any]()
//        MINWON1["INPUT"]=INPUT
        //return DataWebSend().stringToJson(dic: MINWON1)!
        return "\(MINWON1)"
    }
    
    
    func onSASRunStatusChanged(action: Int32, percent: Int32) {
        Log.print("onSASRunStatusChanged :" + action.description + " , " + percent.description)
    }
    func onSASRunCompleted(_ index: Int32, outString: String!) {
        Log.print("onSASRunCompleted : index = "+index.description)
        
//        let data2:JSON = JSON.init(outString as Any) //JSON(outString as String)
//        let output2:JSON = data2["Output"]
//        Log.print("==============스크랩핑결과 \(index) ==============")
//        Log.print("데이터라는데output  \(output2)")
//        Log.print("============== 끝 ==============")
//        let errorCode2 = output2["ErrorCode"].stringValue
//        Log.print("errorCode : \(errorCode2)")
        
        guard let data = outString.data(using: .utf8),
            let jsonRaw = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                Log.print(message: "result error")
                IndicatorView().hideProgress()
                UIApplication.shared.showAlert(message: "스크래핑 실패 outString error")
                return
        }
        guard let output = jsonRaw["Output"] as? [String: Any],
            let errorCode = output["ErrorCode"] as? String ,
            let errorMsg = output["ErrorMessage"] as? String  else {
                //self.scrapingError(index: Int(index), msg: "스크래핑 실패 output error")
            IndicatorView().hideProgress()
                UIApplication.shared.showAlert(message: "스크래핑 실패 Output error")
                return
        }
        //Log.print("\nOutput = \(Output)")
        Log.print("\nErrorCode = \(errorCode)")
        Log.print("\nErrorMsg = \(errorMsg)")
        
        DispatchQueue.main.async {
        switch index {
            case 0:
                Log.print("0.보안문자")
                if errorCode == "00000000" { // 성공
                    guard let result = output["Result"] as? [String: Any] else {
                        UIApplication.shared.showAlert(message: "스크래핑 실패 Result error")
                        return
                    }
                    Log.print("보안문자화면 이동")
                    if let image = result["보안문자"] as? String {
                        UIApplication
                            .shared
                            .capchaView(
                                image64 : image
                            ,refreshHandler: {
                                Log.print("보안문자 새로고침")
                                Scraping().runScraping(params: self.parameters,cert: self.parameters_cert,handler: self.scrapingcompleteHandler!)
                                self.sasManager?.cancel()
                             },cancelHander: {
                                Log.print("보안문자 취소")
                                IndicatorView().hideProgress2()
                                UIApplication.shared.showAlert(message: "보안문자 입력 취소")
                                
                             },completeHandler: {
                                secuerStr in
                                Log.print("보안문자 완료 \(secuerStr)")
                                IndicatorView().textChange(msg: "1..10 [민원24] : 보안문자 검증")
                                self.minwonScraping02(params: self.parameters, cert: self.parameters_cert,secuerStr: secuerStr["보안문자"]!)
                                self.nhisScraping(params: self.parameters, cert: self.parameters_cert)
                                
                             })
                    }
                }
                //  통신실패
                else{
                    DispatchQueue.main.async {
                        UIApplication.shared.showAlert(message: "에러입니다")
                        Scraping().runScraping(params: self.parameters,cert: self.parameters_cert,handler: self.scrapingcompleteHandler!)
                    }
                }
                break;
        case 1:
            IndicatorView().textChange(msg: "2..10 [민원24] : 비회원로그인")
            
            Log.print("1.비회원로그인")
            //보안코드 오타
            if "80003391" == errorCode {
                Log.print("보안문자 틀림")
                self.sasManager?.cancel()
                UIApplication.shared.showAlert(message: "보안문자 틀렸습니다", confirmHandler: {
                    DispatchQueue.main.async {
                        Scraping().runScraping(params: self.parameters,cert: self.parameters_cert,handler: self.scrapingcompleteHandler!)
                    }
                })
            }
            self.resultData["MinWon_1"]=output
            break;
        case 2:
            IndicatorView().textChange(msg: "3..10 [민원24] : 초본출력")
            Log.print("2.초본")
            self.resultData["MinWon_2"]=output
            break;
        case 3:
            IndicatorView().textChange(msg: "4..10 [민원24] : 로그아웃")
            Log.print("3.로그아웃")
            self.resultData["MinWon_3"]=output
            break;
        case 4:
            IndicatorView().textChange(msg: "5..10 [건강보험공단] : 로그인")
            Log.print("4.로그인")
            self.resultData["NHIS_1"]=output
            break;
        case 5:
            IndicatorView().textChange(msg: "6..10 [건강보험공단] : 납부내역")
            Log.print("5.납부내역")
            self.resultData["NHIS_2"]=output
            break;
        case 6:
            IndicatorView().textChange(msg: "7..10 [건강보험공단] : 자격득실확인서")
            Log.print("6.자격득실")
            self.resultData["NHIS_3"]=output
            
            if "00000000" == errorCode {
                if let temp = JSON(output)["Result"]["사업장관리번호"].string {
                    let endIdx: String.Index = temp.index(temp.startIndex, offsetBy: 9)
                    let result = String(temp[...endIdx])
                    Log.print("사업자등록번호 : \(result)")
                    self.homeScraping(params: self.parameters,cert: self.parameters_cert,rbrNo: result)
                }else{
                    self.homeScraping(params: self.parameters,cert: self.parameters_cert,rbrNo: "")
                }
            }else{
                self.homeScraping(params: self.parameters,cert: self.parameters_cert,rbrNo: "")
            }
            
            break;
        case 7:
            IndicatorView().textChange(msg: "7..10 [홈택스] : 공동인증서등록")
            Log.print("7.공동인증서등록")
            self.resultData["HOME_1"]=output
            break;
        case 8:
            IndicatorView().textChange(msg: "8..10 [홈택스] : 로그인")
            Log.print("8.홈택스로그인")
            self.resultData["HOME_2"]=output
            break;
        case 9:
            IndicatorView().textChange(msg: "9..10 [홈택스] : 부가가치세증명원")
            Log.print("9.홈택스 1")
            self.resultData["HOME_3"]=output
            break;
        case 10:
            IndicatorView().textChange(msg: "10..10 [홈택스] : 소득금액증명원")
            Log.print("10. 홈택스 2")
            self.resultData["HOME_4"]=output
            IndicatorView().hideProgress2()
            
            self.scrapingcompleteHandler!( "0000",self.resultData)
            
            break;
        default:
            Log.print("스크래핑 에러")
            break;
        }
            
        }
    }
}

