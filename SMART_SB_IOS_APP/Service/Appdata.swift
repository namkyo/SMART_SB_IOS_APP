//
//  Appdata.swift
//  SmartSavingsBank
//
//  Created by 김남교 on 2020/12/20.
//

import Foundation
class Appdata{
    func appData(params:Dictionary<String, Any>) -> Dictionary<String,Any>{
        var resultData : Dictionary<String,Any> = [String:Any]()
        
        Log.print("appData == ")
        let gubun = params["gubun"] as? String
        
        //등록
        if Constants.AppData.C == gubun {
            if let reVal = params["reqData"] as? Dictionary<String, String> {
                for(key,val) in reVal {
                    Log.print("===등록")
                    Log.print("key : "+key)
                    Log.print("val : " + val)
                    UserDefaults.standard.set(val,forKey: key)
                }
            }
        }
        
        //조회
        else if Constants.AppData.R == gubun {
            let reqData = params["reqData"] as! String
            let arrReqData = Array(reqData.components(separatedBy: ","))
            
            // 다수건
            if arrReqData.capacity > 1 {
                Log.print("다수건")
                var selectDatas : Dictionary<String,String> = [String:String]()
                
                for keyVal in arrReqData {
                    Log.print("keyVal = "+keyVal)
                    let appDelegate  = UIApplication.shared.delegate as! AppDelegate
                    switch keyVal {
                        case "phoneNo":
                            selectDatas[keyVal] = ""
                            break
                        case "tokenId":
                            if let tokenId=appDelegate.tc?.getToken()?.uid {
                                selectDatas[keyVal] = tokenId
                            }else{
                                selectDatas[keyVal] = ""
                            }
                            break
                        case "mOTP":
                            let ocListCount=(appDelegate.oc?.getTokenList()?.capacity)!
                            if ocListCount > 0 {
                                selectDatas[keyVal] = "Y"
                            }else{
                                selectDatas[keyVal] = "N"
                            }
                            break
                        case "smartAuth":let acListCount=(appDelegate.ac?.getTokenList()?.capacity)!
                            if acListCount > 0 {
                                selectDatas[keyVal] = "Y"
                            }else{
                                selectDatas[keyVal] = "N"
                            }
                            break
                        case "appVersion":
                            if let dictionary=Bundle.main.infoDictionary {
                                if let bulid = dictionary["CFBundleVersion"] as? String {
                                    selectDatas[keyVal] = bulid
                                }else{
                                    selectDatas[keyVal] = ""
                                }
                            }else{
                                selectDatas[keyVal] = ""
                            }
                            break
                        default:
                            if let selectData = UserDefaults.standard.string(forKey: keyVal){
                                selectDatas[keyVal] = selectData
                            }else{
                                
//                                if keyVal == "custNo" {
//                                    selectDatas[keyVal] = "00000000023"
//                                }else{
                                    selectDatas[keyVal] = ""
//                                }
                            }
                        }
                }
                resultData = selectDatas
            }
            // 단건
            else{
                Log.print("단건")
                let appDelegate  = UIApplication.shared.delegate as! AppDelegate
                switch reqData {
                    case "phoneNo":
                        resultData[reqData] = ""
                        break
                    case "tokenId":
                        if let tokenId=appDelegate.tc?.getToken()?.uid {
                            resultData[reqData] = tokenId
                        }else{
                            resultData[reqData] = ""
                        }
                        break
                    case "mOTP":
                        let ocListCount=(appDelegate.oc?.getTokenList()?.capacity)!
                        if ocListCount > 0 {
                            resultData[reqData] = "Y"
                        }else{
                            resultData[reqData] = "N"
                        }
                        break
                    case "smartAuth":let acListCount=(appDelegate.ac?.getTokenList()?.capacity)!
                        if acListCount > 0 {
                            resultData[reqData] = "Y"
                        }else{
                            resultData[reqData] = "N"
                        }
                        break
                    case "appVersion":
                        if let dictionary=Bundle.main.infoDictionary {
                            if let bulid = dictionary["CFBundleVersion"] as? String {
                                resultData[reqData] = bulid
                            }else{
                                resultData[reqData] = ""
                            }
                        }else{
                            resultData[reqData] = ""
                        }
                    break
                    default:
                        if let data = UserDefaults.standard.string(forKey: reqData){
                            resultData[reqData] = data
                        }else{
//                            if reqData == "custNo" {
//                                resultData[reqData] = "00000000023"
//                            }else{
                                resultData[reqData] = ""
//                            }
                        }
                    }
            }
        
        }
        
        else{
            Log.print(message: "미사용")
        }
        
        return resultData
    }
}
