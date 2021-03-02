//
//  Configuration.swift
//  SmartSavingsBank
//
//  Created by 김남교 on 2020/12/19.
//

import Foundation

class Configuration {
    //main url
    static let DEV_URL = "http://112.216.114.150:8010"
    static let OPER_URL = "https://www.naver.com"
    //sub url
    static let ERR_URL = "/error.html"
    static let MAIN_VIEW_URL = "/main.view"
    static let JOIN_URL = "/CUS0003_1.view"
    
    //운영,개발 모드
    static let OPER_DEV_YN=false
    
    
    //인증서가져오기 주소
    static let KSW_IP="210.207.195.142"
    static let KSW_PORT=10500
    
    
    
    
    static let URL="URL"
    
    
    //웹 전달받는 키값
    static let OCR = "OCR"                                          //OCR 기동
    static let JWT_READ = "JWT"                                     //JWT(JSON WEB TOKEN) 읽어오기
    static let TRANSKEY = "TRANSKEY"                                //보안키패드 기동
    static let XECURE_PASS_REG = "XECURE_PASS_REG"                  //제큐어패스 등록기동(생체인증)
    static let XECURE_PASS_AUTH = "XECURE_PASS_AUTH"                //제큐어패스 인증기동(생체인증)
    static let XECURE_PASS_DEREG = "XECURE_PASS_REMOVE"             //제큐어패스 해지기동(생체인증)
    static let SCRAPING = "SCRAPING"                                //스크래핑
    static let SIGN_CERT = "SIGN_CERT"                              //공인인증서
    static let SIGN_CERT_REG = "SIGN_CERT_REG"                      //공인인증서 가져오기
    static let SIGN_CERT_MANAGE = "SIGN_CERT_MANAGE"                //공인인증서 관리
    static let APP_IRON = "APP_IRON"                                //앱위변조 방지
    static let APP_DATA = "APP_DATA"                                //앱데이터 저장및 조회
    static let CALENDAR = "CALENDAR"                                //앱 달력기동
    static let APP_LINK = "APP_LINK"                                //다른 앱 링크
    static let WEB_LINK = "WEB_LINK"                                //웹사이트 링크
    static let WEB_SUBMIT = "WEB_SUBMIT"                            //다른 웹사이트 서브밋
    static let APP_CLOSE = "APP_CLOSE"                              //앱종료
    static let LOADING = "LOADING"                                  //로딩바
    static let ADID = "GET_ADID"                                    //ADID값 요청
    static let AUTHORIZATION = "AUTHORIZATION"                      //PIN등록
    static let FDS = "FDS"                                          //FDS모듈
    
    
    static let CUST_NO = "custNo"                                   //사용자 넘버
    
    static let SERVICE_CODE = "serviceCd"                           //전달받는 종류 키값
    static let SERVICE_DATA = "params"                              //해당 정보
    //static let SERVICE_PUSH = "pushKey"                             //푸시 토큰값
    
    static let JOIN = "C"                                           //앱 데이터 등록
    static let REFERENCE = "R"                                      //앱 데이터 조회
    
    static let APP_DATA_VAL = "appDataJsonValue"                    //앱 데이터 저장한 jsonValue
    
    
    //loding 화면 옵션
    static let INTRO_LODING = "INTRO"                               //처음 intro화면일 경우
    static let VIEW_LODING = "VIEW"
    
    
    //처음 접속
    static let INTO_TYPE = "checkFirst"
    static let FIRST_INTO = "fistIntoView"
    static let NOT_FIRST = "notFirst"
    
    
    //AppIron (앱위변조)
    static let APP_IRON_URL = "http://iron.jtchinae-bank.co.kr/authCheck.call"
    static let APP_IRON_URLTEST = "http://deviron.jtchinae-bank.co.kr/authCheck.call" //authDubleCheck.jsp"
    
    //token
    static let AUTH_TOKEN = "authorization"                         //인증 전달받은 토큰값
    static let PUSH_TOKEN = "pushKey"                               //FCM 단말 등록 push 값
    
    
    //제큐어패스 인증
    static let XECURE_PASS_SET_VAL = "XecurePassSettingValue"       //인증 등록방법 저장값
    static let XECURE_PASS_FINGER = "XecurePassSettingFinger"       //손가락(FaceID)
    static let XECURE_PASS_PATTERN = "XecurePassSettingPastten"     //Pattern
    static let XECURE_PASS_PASSCODE = "XecurePassSettingPasscode"   //Passcode
    
    //8Byte 인증 (2020-04-13)
    static let SAFETOKEN_SET_VAL = "safetoken_Setting_value"       //PIN
    static let SAFETOKEN_PIN = "safetoken_pin"       //PIN
    static let SAFETOKEN_MOTP = "safetoken_motp"       //PIN
    static let SAFETOKEN_SMART = "safetoken_smart"       //PIN
    static let SAFETOKEN_PATTERN = "safetoken_pattern"       //패턴
    static let SAFETOKEN_BIO = "safetoken_bio"     //생체인증
    
    static let BIOMETRY_ERRORCODE = "2005"                          //단말에 지문 또는 face ID가 등록이 되어있지 않을경우
    
    //키보드보안
    static let MTRANSKEY_VAL = "MobileTransKey10MobileTransKey10"   //키보드보안 키값
    
    
    //공인인증
    static let ICRS_IP = "211.44.27.80"//인증서 가져오기 ip 주소
    static let ICRS_URL = "http://msign.jtchinae-bank.co.kr" //인증서 가져오기
    static let ICRS_PORT = 10500
    static let BIZ_IP = "http://ksbiz.raonsecure.com"
    static let BIZ_PORT = 8080
    
    //WAS 서버 주소
    static let SID = "https://msign.jtchinae-bank.co.kr:1443/ksbiz/sid.jsp" //"ksbiz/sid.jsp"
    static let CERT = "https://msign.jtchinae-bank.co.kr:1443/ksbiz/servercert.jsp" //"ksbiz/servercert.jsp"
    static let ENC = "https://msign.jtchinae-bank.co.kr:1443/" //"kshybrid/encResult_cs.jsp"
    static let ENC1 = "kshybrid/encResultJson_cs.jsp"
    static let SIGN = "kshybrid/signAction_cs.jsp"
    static let SIMPLE_SIGN = "kshybrid/simpleSignAction_cs.jsp"
    static let SIGN_ENC = "kshybrid/signEncAction_cs.jsp"
    static let VID = "kshybrid/vidAction_cs.jsp"
    
    
    
    static let KEY = "FT3456789JT23456"
    static let IV = "FT87654321JT4321"
    static let OCR_ENCRYPTKEY = "FT3456789"
    
    //모바일 FDS
    static let IXC_LICENSE = "C113FBD7D8A2" //라이센스 id
    static let IXC_CUSTOMER_ID = "SMART_01"  //사용자 id
    
    
    
    static let REQUEST_FILE_CHOOSE: Int = 101
    // mTranskey 요청 코드
    static let REQUEST_MTRANSKEY: Int = 103
    // 전자서명 요청 코드
    static let KSW_Activity_CertList_Result: Int = 104
    // OCR
    static let REQ_PERMISSON_RESULT: Int = 105
    static let REQ_OCR_ID: Int = 106
    static let REQ_OCR_RESULT: Int = 107
    // 스크래핑을 위한 공인인증
    static let REQUEST_SCRAPING_SIGN_CERT: Int = 108
    // 간편비밀번호 입력을 위한 mTranskey 요청 코드
    static let REQUEST_MTRANSKEY_PIN_INPUT: Int = 109
    static let REQUEST_MTRANSKEY_PIN_CONFIRM: Int = 110
    static let REQUEST_MTRANSKEY_PIN_AUTH: Int = 111
    // mOTP 입력을 위한 mTranskey 요청 코드
    static let REQUEST_MTRANSKEY_MOTP_INPUT: Int = 112
    static let REQUEST_MTRANSKEY_MOTP_CONFIRM: Int = 113
    static let REQUEST_MTRANSKEY_MOTP_AUTH: Int = 114
    // 추가인증수단 스마트앱 인증 입력을 위한 mTranskey 요청 코드
    static let REQUEST_MTRANSKEY_SAMARTAPP_INPUT: Int = 115
    static let REQUEST_MTRANSKEY_SAMARTAPP_CONFIRM: Int = 116
    static let REQUEST_MTRANSKEY_SAMARTAPP_AUTH: Int = 117
    
    
    
}
