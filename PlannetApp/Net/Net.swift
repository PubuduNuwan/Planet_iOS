//
//  Net.swift
//  PlannetApp
//
//  Created by user on 2022-05-27.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol RequestBuilder {
    func build(net : Net, method : HTTPMethod,session : Alamofire.Session) -> DataRequest
}

enum ActionType {
    case normal
    case upload
    case download
}

class Net {
    
    var url : String!
    var parameters : Parameters?
    var body : Data?
    var method = HTTPMethod.get
    var action = ActionType.normal
    fileprivate var token : String?
    var encoding : ParameterEncoding = URLEncoding.default
    var dataRequest : DataRequest?
    var responseData : Data?
    var requestBuilder : RequestBuilder!
    var onCompletion : ((_ json : Data) -> ())?
    var onError : ((_ error : AFError) -> ())?
    var header : HTTPHeaders {
        get {
            var header = HTTPHeaders()
            if let tk = token {
                header["Authentication"] = tk
            }
            return header
        }
    }
    var session = Alamofire.Session.default
    
    
    init(url : String,method : HTTPMethod,parameters : Parameters? = nil) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.requestBuilder = AFRequestBuilder()
    }
    
    func perform() {
        switch self.action {
        case .normal:
            dataRequest = requestBuilder.build(net: self, method: method, session: session)
        case .upload:
            print("")
        case .download:
            print("")
        }
        process()
    }
    
    private func process(){
        self.dataRequest?.validate(statusCode: 200..<300).responseData { response in
            switch response.result {
            case .success:
                self.success(response.data!)
            case let .failure(error):
                self.responseData = response.data
                self.error(error)
            }
        }
    }
    
    func success(_ data : Data){
        self.onCompletion?(data)
    }
    
    func error(_ error : AFError){
        self.onError?(error)
    }
}

class AFRequestBuilder : RequestBuilder {
    func build(net: Net, method: HTTPMethod, session: Session) -> DataRequest {
        return AF.request(net.url,
                          method: net.method,
                          parameters: net.parameters,
                          encoding: net.encoding,
                          headers: net.header)
    }
}


