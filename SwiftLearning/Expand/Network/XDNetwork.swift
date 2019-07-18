//
//  XDNetwork.swift
//  SwiftLearning
//
//  Created by 蔡晓东 on 2019/7/17.
//  Copyright © 2019 蔡晓东. All rights reserved.
//

import UIKit
import Alamofire

class XDNetwork: NSObject {
    /**
     *  网络请求成功闭包:(回调成功结果)
     */
    typealias NetworkSuccess = (_ response:AnyObject) -> ()
    
    /**
     *  网络请求失败闭包:(回调失败结果)
     */
    typealias NetworkFailure = (_ error:NSError) -> ()
    
    /**
     *  网络请求单例
     */
    static let shareNetwork = XDNetwork()
    
    /**
     GET 请求
     - parameter urlString:  请求URL
     - parameter parameters: 请求参数
     - parameter success:    成功回调
     - parameter failure:    失败回调
     */
//    func GET(urlString: String ,parameters: [String : AnyObject]? ,success: NetworkSuccess, failure: NetworkFailure){
//        /*
//         responseJSON:申明返回JSON类型数据
//         你也可以根据实际需求,修改返回下列类型
//         response
//         responseData
//         responseString
//         responsePropertyList
//         */
//        Alamofire.request(.GET, urlString, parameters: parameters).responseJSON { response in
//
//            switch response.result {
//
//            case .Success(let value):
//
//                //回调成功结果
//                success(value)
//
//            case .Failure(let error):
//
//                //回调失败结果
//                failure(error)
//                debugPrint(error)
//
//            }
//        }
//    }
    
    /**
     POST 请求
     - parameter urlString:  请求URL
     - parameter parameters: 请求参数
     - parameter success:    成功回调
     - parameter failure:    失败回调
     */
//    func POST(urlString: String ,parameters: [String : AnyObject]? ,success: NetworkSuccess, failure: NetworkFailure) {
//
//        Alamofire.request(.POST, urlString, parameters: parameters).responseJSON { response in
//
//            switch response.result {
//
//            case .Success(let value):
//
//                //回调成功结果
//                success(value)
//
//            case .Failure(let error):
//
//                //回调失败结果
//                failure(error)
//                debugPrint(error)
//
//            }
//        }
//    }
    
}

/**
 调用
 //MARK: - GET请求
 XHNetwork.shareNetwork.GET(URL_TEST, parameters: nil, success: { (response) in
 
 //成功
 debugPrint(response)
 
 }) { (error) in
 
 //失败
 debugPrint(error)
 }
 
 //MARK: - POST请求
 let dic = ["name":"zhang","phone":"10010"]
 XHNetwork.shareNetwork.POST(URL_TEST, parameters: dic, success: { (response) in
 
 //成功
 debugPrint(response)
 
 }) { (error) in
 
 //失败
 debugPrint(error)
 }
 */
