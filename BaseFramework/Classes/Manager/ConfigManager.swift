//
//  ConfigManager.swift
//  MyRill
//
//  Created by 钟凡 on 16/8/18.
//
//

import UIKit

open class ConfigManager: NSObject {
    // 服务器地址 211.64.142.84:80 111.204.215.170:99
    public static let defaultRpcIp:String = "http://172.16.3.55:9090/itone/rpc"
    public static let defaultServerIp:String = "101.201.196.29:80"
    // BMC
    public static let defaultBMCIp:String = "http://101.200.220.3:8090/api/v2/"
    // userDefoult 常量
    public static let userdefault_rpcip = "userdefault_rpcip"
    public static let userdefault_bmcip = "userdefault_bmcip"
    public static let userdefault_severip = "userdefault_severip"
    
    // alertView 常量
    public static let alertTitle_saveImage = "保存图片"
    public static let alertTitle_uploadImage = "上传图片"
    public static let alertTitle_send = "发送给朋友"
    public static let alertTitle_collect = "收藏"
    // 友盟
    public static let UM_APPKEY = "573581fee0f55a7fc10017be"
    // 极光
    public static let JG_APPKEY = "b47167a8f30c4534b79b1cf2"
    public static let uuid = NSUUID().uuidString.replacingOccurrences(of: "-", with: "")
    // useragent
    public static let USERAGENT = "Mozilla/5.0 (iPhone; CPU iPhone OS 8_1_3 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12B466 Safari/600.1.4 joint"
    // 是否登录
    public static let LOGIN_STATUS = "LOGIN_STATUS"
    // 错误消息常量
    public static let server_inner_error = "服务器内部错误"
    public static let server_connect_error = "服务器连接失败"
    
    // MARK: - method
    public static func rpcIp() -> String {
        return (UserDefaults.standard.object(forKey: userdefault_rpcip) ?? defaultRpcIp) as! String
    }
    public static func serverIp() -> String {
        return (UserDefaults.standard.object(forKey: userdefault_severip) ?? defaultServerIp) as! String
    }
    public static func bmcIp() -> String {
        return (UserDefaults.standard.object(forKey: userdefault_bmcip) ?? defaultBMCIp) as! String
    }
}
