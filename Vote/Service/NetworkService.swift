//
//  NetworkService.swift
//  Vote
//
//  Created by Grant Yuan on 2018/2/5.
//  Copyright © 2018年 林以达. All rights reserved.
//

import UIKit
import Foundation

public enum Method: String, CustomStringConvertible {
    case OPTIONS    = "OPTIONS"
    case GET        = "GET"
    case HEAD       = "HEAD"
    case POST       = "POST"
    case PUT        = "PUT"
    case PATCH      = "PATCH"
    case DELETE     = "DELETE"
    case TRACE      = "TRACE"
    case CONNECT    = "CONNECT"
    
    public var description: String {
        return self.rawValue
    }
}

public struct ErrorMsg: CustomStringConvertible {
    let code: Int
    let message: String
    
    init(code: Int = -1, message: String){
        self.code = code
        self.message = message
    }
    
    public var description: String {
        return "code = \(code), message = \(message)"
    }
}

public struct Resource<A>: CustomStringConvertible {
    let path: String
    let method: Method
    let requestBody: NSData?
    let headers: [String:String]
    let parse: (NSData) -> A?
    
    public var description: String {
        let decodeRequestBody: [String: AnyObject]
        if let requestBody = requestBody {
            decodeRequestBody = decodeJSON(data: requestBody)! as [String : AnyObject]
        } else {
            decodeRequestBody = [:]
        }
        
        return "Resource(Method: \(method), path: \(path), requestBody: \(decodeRequestBody))"
    }
}

public enum Reason: CustomStringConvertible {
    case CouldNotParseJSON
    case NoData
    case NoSuccessStatusCode(statusCode: Int)
    case Timeout
    case Other(NSError?)
    
    public var description: String {
        switch self {
        case .CouldNotParseJSON:
            return "CouldNotParseJSON"
        case .NoData:
            return "NoData"
        case .NoSuccessStatusCode(let statusCode):
            return "NoSuccessStatusCode: \(statusCode)"
        case .Timeout:
            return "Timeout"
        case .Other(let error):
            return "Other, Error: \(String(describing: error?.description))"
        }
    }
}

public typealias FailureHandler = (_ reason: Reason, _ error: ErrorMsg?) -> Void

let defaultFailureHandler: FailureHandler = { reason, errorMessage in
    log.error("\n***************************** NetworkManager Failure *****************************")
    log.error("Reason: \(reason)")
    if let errorMessage = errorMessage {
        log.error("errorMessage: >>>\(errorMessage)<<<\n")
    }
}

func queryComponents(key: String, value: AnyObject) -> [(String, String)] {

    func escape(string: String) -> String {
        return string.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }
    
    var components: [(String, String)] = []
    if let dictionary = value as? [String: AnyObject] {
        for (nestedKey, value) in dictionary {
            components += queryComponents(key: "\(key)[\(nestedKey)]", value: value)
        }
    } else if let array = value as? [AnyObject] {
        for value in array {
            components += queryComponents(key: "\(key)[]", value: value)
        }
    } else {
        components.append(contentsOf: [(escape(string: key), escape(string: "\(value)"))])
    }
    
    return components
}

var networkActivityCount = 0 {
    didSet {
        //        UIApplication.shared.isNetworkActivityIndicatorVisible = (networkActivityCount > 0)
    }
}

private let successStatusCodeRange: Range<Int> = 200..<300

class SessionDelegate: NSObject, URLSessionDelegate, URLSessionTaskDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
        }
    }
    
    @available(iOS 10.0, *)
    func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        //        print("redirectCount =", metrics.redirectCount)
        log.debug("taskInterval = \(metrics.taskInterval)")
        //        log.debug("transactionMetrics = \(metrics.transactionMetrics)")
    }
}

let _sessionDelegate = SessionDelegate()

public func apiRequest<A>(modifyRequest: (NSMutableURLRequest) -> (), baseURL: NSURL, resource: Resource<A>?, isInBackground: Bool = false, failure: FailureHandler?, completion: @escaping (A) -> Void) {
    
    guard let resource = resource else {
        failure?(.Other(nil), ErrorMsg(message: "出了点小状况，请再试一下^o^"))
        return
    }
    
    let sessionConfig = URLSessionConfiguration.default
    sessionConfig.timeoutIntervalForRequest = Config.networkTimeout
    let session = URLSession(configuration: sessionConfig, delegate: _sessionDelegate, delegateQueue: nil)
    
    let url = baseURL.appendingPathComponent(resource.path)
    let request = NSMutableURLRequest(url: url!)
    request.httpMethod = resource.method.rawValue
    
    func needEncodesParametersForMethod(method: Method) -> Bool {
        switch method {
        case .GET, .PUT, .HEAD, .POST:
            return true
        default:
            return false
        }
    }
    
    func query(parameters: [String: AnyObject]) -> String {
        var components: [(String, String)] = []
        for key in Array(parameters.keys).sorted(by: <) {
            let value: AnyObject! = parameters[key]
            components += queryComponents(key: key, value: value)
        }
        
        return (components.map{"\($0)=\($1)"} as [String]).joined(separator: "&")
    }
    
    func handleParameters() {
        if needEncodesParametersForMethod(method: resource.method) {
            guard let URL = request.url else {
                log.debug("Invalid URL of request: \(request)")
                return
            }
            
            if let requestBody = resource.requestBody {
                if resource.method == .POST {
                    request.httpBody = getPostBody(params: decodeJSON(data: requestBody)! as [String : AnyObject])
                } else if let URLComponents = NSURLComponents(url: URL, resolvingAgainstBaseURL: false) {
                    URLComponents.percentEncodedQuery = (URLComponents.percentEncodedQuery != nil ? URLComponents.percentEncodedQuery! + "&" : "") + query(parameters: decodeJSON(data: requestBody)! as [String : AnyObject])
                    request.url = URLComponents.url
                }
            }
            
        } else {
            request.httpBody = resource.requestBody as Data?
        }
    }
    
    func getPostBody(params:[String:Any]) -> Data {
        var components: [(String, String)] = []
        
        for key in params.keys.sorted(by: <) {
            let value = params[key]!
            components += queryComponents(key: key, value: value as AnyObject)
        }
        
        let paramsStr = components.map { "\($0)=\($1)" }.joined(separator: "&")
        
        return paramsStr.data(using: .utf8, allowLossyConversion: false)!
    }

    handleParameters()
    
    modifyRequest(request)
    
    for (key, value) in resource.headers {
        request.setValue(value, forHTTPHeaderField: key)
    }
    
    let _failure: FailureHandler
    
    if let failure = failure {
        _failure = failure
    } else {
        _failure = defaultFailureHandler
    }
    
    func handleFailure(_ reason: Reason, _ error: ErrorMsg?) {
        if isInBackground {
            _failure(reason, error)
        } else {
            mainAsync {
                _failure(reason, error)
            }
        }
    }
    
    let task = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
        if let httpResponse = response as? HTTPURLResponse {
            log.debug("============================> NETWORK REQUEST <============================ \n \(resource.description) \n\n")
            log.debug("============================> NETWORK RESPONSE <============================ \nURL:\(String(describing: httpResponse.url))>>> StatusCode:\(httpResponse.statusCode)\n\n")
            
            if let tempData = data {
                if let stringData = NSString(data: tempData, encoding: String.Encoding.utf8.rawValue) {
                    log.debug("============================> NETWORK DATA <============================ \n \(stringData) \n\n")
                } else {
                    log.debug("============================> NETWORK DATA <============================ \n  NO DATA \n\n")
                }
            }
            
            switch httpResponse.statusCode {
            case HttpStatusCode.success.rawValue:
                if let responseData = data {
                    // 解析数据
                    if let result = resource.parse(responseData as NSData) {
                        // check error code
                        if let error = errorMessageInData(data: responseData as NSData) {
                            // failed
                            handleFailure(.NoSuccessStatusCode(statusCode: (error.code)), error)
                        } else {
                            // success
                            if isInBackground {
                                completion(result)
                            } else {
                                mainAsync {
                                    completion(result)
                                }
                            }
                        }
                        
                    } else {
                        let dataString = NSString(data: responseData, encoding: String.Encoding.utf8.rawValue)
                        log.debug(String(describing: dataString))
                        
                        handleFailure(.CouldNotParseJSON, errorMessageInData(data: data as NSData?))
                    }
                    
                } else {
                    handleFailure(.NoData, errorMessageInData(data: data as NSData?))
                }
                
            case HttpStatusCode.bad_request.rawValue, HttpStatusCode.failed.rawValue, HttpStatusCode.access_invalid.rawValue:
                // 检查错误
                let errorMsg = errorMessageInData(data: data as NSData?)
                
                if  errorMsg != nil {
                    handleFailure(.NoSuccessStatusCode(statusCode: (errorMsg?.code)!), errorMsg)
                } else {
                    handleFailure(.NoSuccessStatusCode(statusCode: httpResponse.statusCode), nil)
                }
            case HttpStatusCode.auth_failed.rawValue:
                let errorMsg = errorMessageInData(data: data as NSData?)
                if let message = errorMsg?.message {
                    log.error("auth failed = \(message)")
                }
                
                if let requestHost = request.url?.host, requestHost == Config.baseURL.host {
                    VUserDefaults.token.value = nil
                    // todo: user should login
                }
                
                handleFailure(.NoSuccessStatusCode(statusCode: httpResponse.statusCode), nil)
            case HttpStatusCode.not_found.rawValue:
                handleFailure(.NoSuccessStatusCode(statusCode: httpResponse.statusCode), nil)
            default:
                handleFailure(.Other(error as NSError?), nil)
            }
            
        } else {
            if let errorCode = error?.code {
                switch (errorCode) {
                case -1001:
                    // handle timeout
                    handleFailure(.Timeout, ErrorMsg(code: errorCode, message: "请求超时，请重试"))
                    
                default:
                    handleFailure(.Other(error as NSError?), nil)
                    log.debug("\(resource)")
                }
            } else {
                handleFailure(.Other(error as NSError?), nil)
                log.debug("\(resource)")
            }
        }
        
        mainAsync {
            networkActivityCount -= 1
        }
    }
    
    task.resume()
    
    mainAsync {
        networkActivityCount += 1
    }
}

func errorMessageInData(data: NSData?) -> ErrorMsg? {
    if let data = data {
        if let json = decodeJSON(data: data) {
            var code: Int = -1
            
            if let errorCode = json["status"] as? Int{
                code = errorCode
            }
            
            // 正常消息
            guard code != 1 else {
                return nil
            }
            
            if let msg = json["msg"] as? String {
                return ErrorMsg(code: code, message: msg)
            }
            
            if let errorCode = json["status"] as? Int {
                log.debug("error code = \(errorCode)")
                
                if let errorMsg = json["msg"] as? String {
                    log.debug("error msg = \(errorMsg), code = \(errorCode)")
                    return ErrorMsg(code: errorCode, message: errorMsg)
                }
                
                var errorMsg: String!
                
                switch errorCode {
                case 1001:
                    errorMsg = "验证码错误"
                case 1002:
                    errorMsg = "登录失败"
                default:
                    errorMsg = "出了点小状况，请再试一下^o^"
                }
                
                log.error("[ERROR] code \(errorCode), msg: \(errorMsg!)")
                return ErrorMsg(code: errorCode, message: errorMsg)
            }
        }
    }
    
    return nil
}

fileprivate func postLogoutNotification() {
    // todo
}

// Here are some convenience functions for dealing with JSON APIs

public typealias JSONDictionary = [String : Any]

func decodeJSON(data: NSData) -> JSONDictionary? {
    if data.length > 0 {
        guard let result = try? JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions()) else {
            return JSONDictionary()
        }
        
        if let dictionary = result as? JSONDictionary {
            if let dataDict = dictionary["data"] {
                if let data = dataDict as? JSONDictionary {
                    return data
                }
            }
            
            return dictionary
        } else if let array = result as? [JSONDictionary] {
            return ["data": array as AnyObject]
        } else {
            return JSONDictionary()
        }
        
    } else {
        return JSONDictionary()
    }
}

func encodeJSON(dict: JSONDictionary) -> NSData? {
    guard dict.count != 0 else {
        return nil
    }
    
    return try! JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions()) as NSData?
}

func getPostString(params:[String:Any]) -> NSData {
    var data = [String]()
    for(key, value) in params {
        data.append(key + "=\(value)")
    }
    
    let postString = data.map { String($0) }.joined(separator: "&")
    
    return postString.data(using: .utf8)! as NSData
}


public func jsonResource<A>(path: String, method: Method, requestParameters: JSONDictionary, parse:  @escaping (JSONDictionary) -> A?) -> Resource<A> {
    return jsonResource(token: nil, path: path, method: method, requestParameters: requestParameters, parse: parse)
}

public func maybeAuthjsonResource<A>(path: String, method: Method, requestParameters: JSONDictionary, parse: @escaping (JSONDictionary) -> A?) -> Resource<A> {
    
    if let originToken = VUserDefaults.token.value {
        let params: NSMutableDictionary = ["token" : originToken]
        params.addEntries(from: requestParameters)
        
        return jsonResource(token: originToken, path: path, method: method, requestParameters: (params as! JSONDictionary), parse: parse)
    }
    
    return jsonResource(token: nil, path: path, method: method, requestParameters: requestParameters, parse: parse)
}

public func authJsonResource<A>(path: String, method: Method, requestParameters: JSONDictionary, parse: @escaping (JSONDictionary) -> A?) -> Resource<A>? {
    guard let originToken = VUserDefaults.token.value else {
        log.debug("No token for auth")
        // todo
        
        return nil
    }

    let params: NSMutableDictionary = ["token" : VUserDefaults.token.value!]
    params.addEntries(from: requestParameters)
    
    return jsonResource(token: originToken, path: path, method: method, requestParameters: (params as! JSONDictionary), parse: parse)
}

public func jsonResource<A>(token: String?, path: String, method: Method, requestParameters: JSONDictionary, parse: @escaping (JSONDictionary) -> A?) -> Resource<A> {
    let jsonParse: (NSData) -> A? = { data in
        if let json = decodeJSON(data: data) {
            return parse(json)
        }
        
        return nil
    }
    
    let jsonBody = encodeJSON(dict: requestParameters)
    
    let defaultHTTPHeaders: [String: String] = {
        // Accept-Encoding HTTP Header; see https://tools.ietf.org/html/rfc7230#section-4.2.3
        let acceptEncoding: String = "gzip;q=1.0, compress;q=0.5"
        
        // Accept-Language HTTP Header; see https://tools.ietf.org/html/rfc7231#section-5.3.5
        let acceptLanguage = NSLocale.preferredLanguages.prefix(6).enumerated().map { index, languageCode in
            let quality = 1.0 - (Double(index) * 0.1)
            return "\(languageCode);q=\(quality)"
            }.joined(separator: ", ")
        
        // User-Agent Header; see https://tools.ietf.org/html/rfc7231#section-5.5.3
        let userAgent: String = {
            if let info = Bundle.main.infoDictionary {
                let executable = info[kCFBundleExecutableKey as String] as? String ?? "Unknown"
                let bundle = info[kCFBundleIdentifierKey as String] as? String ?? "Unknown"
                let version = info[kCFBundleVersionKey as String] as? String ?? "Unknown"
                let os = ProcessInfo.processInfo.operatingSystemVersionString
                let scale = UIScreen.main.scale
                
                let mutableUserAgent = NSMutableString(string: "\(executable)/\(bundle) (\(version); iOS \(os); Scale/\(scale))") as CFMutableString
                let transform = NSString(string: "Any-Latin; Latin-ASCII; [:^ASCII:] Remove") as CFString
                
                if CFStringTransform(mutableUserAgent, nil, transform, false) {
                    return mutableUserAgent as String
                }
            }
            
            return "NetworkManager"
        }()
        
        return [
            "Accept-Encoding": acceptEncoding,
            "Accept-Language": acceptLanguage,
            "User-Agent": userAgent,
            "Content-Type": "application/x-www-form-urlencoded"]
    }()
    
    return Resource(path: path, method: method, requestBody: jsonBody, headers: defaultHTTPHeaders, parse: jsonParse)
}

func query(parameters: [String: Any]) -> String {
    var components: [(String, String)] = []
    for key in Array(parameters.keys).sorted(by: <) {
        let value: AnyObject! = parameters[key] as AnyObject!
        components += queryComponents(key: key, value: value)
    }
    
    return (components.map{"\($0)=\($1)"} as [String]).joined(separator: "&")
}

