//
//  Constants.swift
//  SMART_SB_APP_IOS
//
//  Created by 김남교 on 2021/01/31.
//

import Foundation

enum Constants {
    
    static var MODE: String = "D"
    
    /*
     *  검증설정 checkPinValidation
     */
    static let CHECK_VALIDATION = true
    enum PageUrl{
        static let  WEB_MAIN_H: String = "http://210.221.92.125:8082/"
//        ?static let  WEB_MAIN_D: String = "http://172.17.171.1:8010/"
        static let  WEB_MAIN_D: String = "http://112.216.114.150:8010/"
        
        static let  WEB_MAIN_R: String = "https://smart-i.smartbank.co.kr:8010/"

        static let  WEB_MAIN_VIEW: String = "main.view"
        static let  WEB_SIGN_UP: String = "COM0006.view"
        static let  WEB_ERROR: String = "error.html"
    }
    
    /**
     *  에버세이프 위변조 접속 정보
     */
    enum EVERSAFE{
        static let url :String  = "http://112.216.114.150:4443/eversafe"
        static let token: String = "EVERSAFE_TOKEN"
        static let appid: String = "51E260532B184455"
    }
    
    /**
     *  AES256 암호화 키값
     */
    enum AES{
        static let SECRET_KEY :String  = "FT3456789JT23456" // 16byte
        static let iv: String             = "FT87654321JT4321"
    }
    /**
     *  키보드보안 키값
     */
    static let MTRANSKEY_VAL = ""
    
    /**
     *  Certificate
     */
    enum Cert {
        static let ICRS_IP = "210.207.195.142"                       // 인증서 가져오기 ip 주소
        static let ICRS_URL = "http://sign.jt-bank.co.kr"            // 인증서 가져오기(운영)
        //static let ICRS_URL = "http://devsign.jt-bank.co.kr"       // 인증서 가져오기(개발)
        static let ICRS_PORT: UInt = 10500
        static let BIZ_IP = "http://ksbiz.raonsecure.com"
        static let BIZ_PORT = 8080
    }
    
    /**
     *  Scaping 주민번호 암호화 Key, IV
     */
    enum Scraping {
        static let KEY = "" // "FT3456789JT23456"
        static let IV = ""  // "FT87654321JT4321"
    }
    /**
     *  앱데이터 요청 작업구분 코드
     */
    enum AppData {
        static let C = "C"
        static let R = "R"
    }
    
    /**
     *  ServiceCode
     */
    enum ServiceCode {
        static let AUTHORIZATION = "AUTHORIZATION"       // 8Byte 호출
        static let TRANSKEY = "TRANSKEY"                 // 보안키패드 기동
        static let LOADING = "LOADING"                   // Loading
        static let CALENDAR = "CALENDAR"                 // Calendar
        static let OCR = "OCR"                           // OCR
        static let WEB_LINK = "WEB_LINK"                 // 네이티브 외부 브라우저 링크 호출
        static let WEB_SUBMIT = "WEB_SUBMIT"             // 링크 호출(폼 데이터 전달)
        static let APP_DATA = "APP_DATA"                 // 앱 내부 데이터 단일, 다건 저장 및 조회
        static let APP_LINK = "APP_LINK"                 // 외부 앱 호출
        static let APP_CLOSE = "APP_CLOSE"               // 앱 종료
        static let GET_ADID = "GET_ADID"                 // 단말 ADID 조회
        static let SIGN_CERT_REG = "SIGN_CERT_REG"       // 공인인증서 가져오기
        static let SIGN_CERT_MANAGE = "SIGN_CERT_MANAGE" // 공인인증서 관리
        static let SIGN_CERT = "SIGN_CERT"               // 공인인증서
        static let SCRAPING = "SCRAPING"                 // 스크래핑
        static let FDS = "FDS"                          // 단말기정보
        static let CAMERA = "CAMERA"                          // 일반카메라
    }
    
    /**
     *  UserDefaultKey
     */
    enum UserDefaultsKey {
        static let CUST_NO = "custNo"                // cust_no(고객번호)
        static let APP_DATA_VAL = "appDataJsonValue"  // 앱 데이터 저장한 jsonValue
        static let LINK_DATA = "linkData"             // 링크데이터
        static let AppVersion = "JTSB.AppVersion"     // 앱 버전
        static let AppBunleId = "JTSB.BundleId"       // 앱 id
        static let AppName = "JTSB.AppName"           // 앱 name
        
        //token
        static let AUTH_TOKEN = "authorization"                     // 인증 전달받은 토큰값
        static let PUSH_TOKEN = "pushKey"                           // FCM 단말 등록 push 값
        static let PUSH_CLICK = "pushClick"                         // 푸시 클릭 여부
        static let PUSH_URL = "pushURL"                             // 푸시로 받은 URL
        static let PUSH_TITLE = "push_title"                        // 푸시 타이틀
        static let PUSH_MESSAGE = "push_message"                    // 푸시 메세지
        
        //8Byte 인증
        static let SAFETOKEN_SET_VAL = "safetoken_Setting_value"
        static let SAFETOKEN_PIN = "safetoken_pin"                  // PIN
        static let SAFETOKEN_PATTERN = "safetoken_pattern"          // 패턴
        static let SAFETOKEN_BIO = "safetoken_bio"                  // 생체인증
    }
    
    /**
     *  앱 위변조 검사 (APP_IRON)
     */
    enum AppIron {
        static let APP_IRON_URL = "http://appchk.jt-bank.co.kr:8070/appiron-inspect/authCheck.call"        // AppIron 운영 URL
        //static let APP_IRON_URL = "http://devappchk.jt-bank.co.kr:8070/appiron-inspect/authCheck.call"   // AppIron 개발 URL
    }
}

let myUserDefaults = UserDefaults.standard
