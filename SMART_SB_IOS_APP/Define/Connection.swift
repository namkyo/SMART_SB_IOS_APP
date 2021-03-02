//
//  Connection.swift
//  ft
//
//  Created by chinae on 06/09/2019.
//  Copyright © 2019 chinae. All rights reserved.
//

import Foundation
import WebKit


class Connection: NSObject, StreamDelegate, WKUIDelegate, URLSessionDelegate, NSURLConnectionDelegate {
    
    var host:String?
    var port:Int?
    var inputStream: InputStream?
    var outputStream: OutputStream?
    //var sneds = Queue<String>()
    
    //var mainWeb: WKWebView
    var criteriaDic:Dictionary<String, Any>?
    
    private class func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodClientCertificate) {
            completionHandler(.rejectProtectionSpace, nil)
        }
        if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            completionHandler(.useCredential, credential)
        }
    }
   
  
    
     class func uploadImage(image: UIImage, url:String, dicData:Dictionary<String, Any>) ->Dictionary<String, Any>?  {
            
            var reDicData: Dictionary = [String: Any]()
            
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd_HHmmss"
            
            let randomNumber = arc4random_uniform(1000)
            let fileName = dateFormatter.string(from: currentDate) + "_\(randomNumber)" + ".jpg"
        
        
            //var request = URLRequest(url: URL(string: url)!)
            
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL) // Here, kLogin contains the Login API.
           // let urlConnection:NSURLConnection = NSURLConnection(request: request, delegate: self)!
            
            request.httpMethod = "POST"
            
            //let config = URLSessionConfiguration.default
            //let session = URLSession(configuration: config)//URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.current)
            // URLSession(configuration: config)
            
            
            //let imgData =  UIImageJPEGRepresentation(image, 0.7)//UIImage.jpegData(image)
            
            //let params = dicData //["first" : "gyeom"]
            
            Function.DFT_TRACE_PRINT(output: "imageUpload: ",dicData)
            Function.DFT_TRACE_PRINT(output: "imageUpload URL:",url)
            
            let boundary = "Boundary-\(UUID().uuidString)"
            request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            //request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.httpBody = createBody(parameters: dicData, boundary: boundary, data: image.jpegData(compressionQuality: 0.7)! , mimeType: "image/jpg", filename: fileName)
            
//            var body = Data()
//            body = createBody(parameters: dicData, boundary: boundary, data: image.jpegData(compressionQuality: 0.7)! , mimeType: "multipart/form-data", filename: fileName)
//
//            Function.DFT_TRACE_PRINT(output: "httpBody:",body as Any)
      
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
        data, response, error in

                if error != nil {
                    Function.DFT_TRACE_PRINT(output: "error=\(String(describing: error))")
                    return
                }

                // You can print out response object
            Function.DFT_TRACE_PRINT(output: "******* response = \(String(describing: response))")

                // Print out reponse body
            reDicData =  ["val":String(describing: response)]
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                 Function.DFT_TRACE_PRINT(output: "****** response data = \(responseString!)")

                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary

                    Function.DFT_TRACE_PRINT(output: json as Any)

//                    dispatch_async(dispatch_get_main_queue(),{
//                        self.myActivityIndicator.stopAnimating()
//                        self.myImageView.image = nil;
//                    });

                }catch
                {
                    Log.print("error")
                }

            }

            task.resume()
        return reDicData
       
    }
        

    
    class func createBody(parameters: [String: Any],
                    boundary: String,
                    data: Data,
                    mimeType: String,
                    filename: String) -> Data {
        var body = Data()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        for (key, value) in parameters {
            body.append(boundaryPrefix.data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        body.append(boundaryPrefix.data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"uploadFile\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
        //body.append("Content-Type: multipart/form-data; \r\n\r\n".data(using: .utf8)!)
        body.append(data)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--".appending(boundary.appending("--")).data(using: .utf8)!)
        
        return body
        
    }
    
    
    class func sendImgData(img:String, url:String) {
        
        
        // the image in UIImage type
        //guard let image = tmpImage else { return  }
        let image = UIImage.init(contentsOfFile: img) //tmpImage else { return  }
        
        let filename = img //"avatar.png"
        
        // generate boundary string using a unique per-app string
        let boundary = UUID().uuidString
        
        let fieldName = "reqtype"
        let fieldValue = "uploadFile"
        
        let fieldName2 = "userhash"
        let fieldValue2 = "caa3dce4fcb36cfdf9258ad9c"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // Set the URLRequest to POST and to the specified URL
        //var urlRequest = URLRequest(url: URL(string: "https://catbox.moe/user/api.php")!)
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = "POST"
        
        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
        // And the boundary is also set here
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        
        // Add the reqtype field and its value to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(fieldName)\"\r\n\r\n".data(using: .utf8)!)
        data.append("\(fieldValue)".data(using: .utf8)!)
        
        // Add the userhash field and its value to the raw http reqyest data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(fieldName2)\"\r\n\r\n".data(using: .utf8)!)
        data.append("\(fieldValue2)".data(using: .utf8)!)
        
        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"uploadFile\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        //data.append(UIImagePNGRepresentation(image)!)
        data.append(image!.pngData()!)
        
        // End the raw http request data, note that there is 2 extra dash ("-") at the end, this is to indicate the end of the data
        // According to the HTTP 1.1 specification https://tools.ietf.org/html/rfc7230
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            
            if(error != nil){
                print("\(error!.localizedDescription)")
            }
            
            guard let responseData = responseData else {
                print("no response data")
                return
            }
            
            if let responseString = String(data: responseData, encoding: .utf8) {
                Function.DFT_TRACE_PRINT(output: "uploaded to: \(responseString)")
            }
        }).resume()
    }
    

    class func connect(requestUrl: String, data: String) -> String {
        
        
//        let request = NSMutableURLRequest()
//        request.url = NSURL(string: requestUrl) as URL?
//        request.httpMethod = "POST"
//        //request.setValue(UnitLength, forHTTPHeaderField:"Content-Length")
//        request.setValue("application/json", forHTTPHeaderField:"Accept")
//        //request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
//        request.addValue("text/plain; charset=utf-8", forHTTPHeaderField: "Content-Type")
//        request.postBody = postData
        
        


        let request = NSMutableURLRequest(url: NSURL(string: requestUrl)! as URL) // Here, kLogin contains the Login API.
        
        let session = URLSession.shared
        
        request.httpMethod = "POST"
    
        // loginFtApp.act?custNo=저장소값
        
        //var err: NSError?
        //request.HTTPBody = JSONSerialization.dataWithJSONObject(self.criteriaDic(), options: nil, error: &err) // This Line fills the web service with required parameters.
//        let requestBodyData = (data as NSString).dataUsingEncoding(NSUTF8StringEncoding)?.base64EncodedStringWithOptions([])
//        //request.HTTPBody = requestBodyData
//        request.httpBody = requestBodyData
        
        //var requestBodyData: NSData = data.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) as NSData
        //let requestBodyData = (data as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        let requestBodyData = (data as NSString).data(using: String.Encoding.utf8.rawValue, allowLossyConversion: true)
        request.httpBody = requestBodyData
        
        
        request.addValue("text/plain; charset=utf-8", forHTTPHeaderField: "Content-Type")
        //request.addValue("application/json", forHTTPHeaderField: "Accept")
        //request.setValue(<#T##value: String?##String?#>, forHTTPHeaderField: <#T##String#>)
        
        var strData = ""
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)! as String
            Function.DFT_TRACE_PRINT(output: "Body: \(String(describing: strData))")
//            var err1: NSError?
//            var json2 = JSONSerialization.JSONObjectWithData(strData.dataUsingEncoding(String.Encoding.utf8), options: .MutableLeaves, error:&err1 ) as NSDictionary
//
//
//            if((err) != nil) {
//                print(err!.localizedDescription)
//            }
//            else {
//                var success = json2["success"] as? Int
//                print("Succes: \(success)")
//            }
        })
        
        task.resume()
        
        return String(describing: strData)
    }
    
    //////--->
    private func connection(connection: NSURLConnection, canAuthenticateAgainstProtectionSpace protectionSpace: URLProtectionSpace) -> Bool{
        print("canAuthenticateAgainstProtectionSpace method Returning True")
        return true
    }
    
    
    private func connection(connection: NSURLConnection, didReceiveAuthenticationChallenge challenge: URLAuthenticationChallenge){
        
        print("did autherntcationchallenge = \(challenge.protectionSpace.authenticationMethod)")
        
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust  {
            print("send credential Server Trust")
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            challenge.sender!.use(credential, for: challenge)
            
        }else if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodHTTPBasic{
            print("send credential HTTP Basic")
            let defaultCredentials: URLCredential = URLCredential(user: "username", password: "password", persistence:URLCredential.Persistence.forSession)
            challenge.sender!.use(defaultCredentials, for: challenge)
            
        }else if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodNTLM{
            print("send credential NTLM")
            
        } else{
            challenge.sender!.performDefaultHandling!(for: challenge)
        }
    }

    /////////<----------
    

    }





    

