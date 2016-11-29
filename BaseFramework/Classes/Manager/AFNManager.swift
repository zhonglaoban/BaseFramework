//
//  AFNManager.swift
//  Relax
//
//  Created by 钟凡 on 16/9/1.
//  Copyright © 2016年 钟凡. All rights reserved.
//
//import AFNetworking

enum RequestType:Int {
    case post = 0
    case get
    case put
    case delete
}
open class AFNManager: NSObject {
    /*
    static let manager = AFHTTPSessionManager()
    static var downloadTask:URLSessionDownloadTask?
    
    static func request(_ baseURLStr:String, type:RequestType, url:String, params:[String:Any]?, success:@escaping ((Any?)->()), failure:@escaping ((Error)->())) {
        let urlStr = baseURLStr + url
        manager.requestSerializer = AFJSONRequestSerializer()
        let token = "DzFGcBFuWji/rVdkAjFnzmevkLM="
        manager.requestSerializer.setValue(token, forHTTPHeaderField: "token")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        manager.requestSerializer.httpShouldHandleCookies = true
        
        switch type {
        case .get:
            manager.get(urlStr, parameters: params, progress: { progress in
                
                }, success: { (task, response) in
                    success(response)
            }) { (task, error) in
                failure(error)
            }
            break;
        case .post:
            manager.post(urlStr, parameters: params, progress: { progress in
                
                }, success: { (task, response) in
                    success(response)
            }) { (task, error) in
                failure(error)
            }
            break;
        case .put:
            manager.put(urlStr, parameters: params, success: { (task, response) in
                success(response)
            }) { (task, error) in
                failure(error)
            }
            break;
        case .delete:
            manager.delete(urlStr, parameters: params, success: { (task, response) in
                success(response)
            }) { (task, error) in
                failure(error)
            }
            break;
        }
    }
    // MARK: - rpc
    static func baseRpcRequest(_ type:RequestType, url:String, params:[String:Any]?, success:@escaping ((Any?)->()), failure:@escaping ((Error)->())) {
        
        manager.requestSerializer = AFJSONRequestSerializer()
        let token = "/bRGox3z31rAyRm5v85smwMJWhI="
        manager.requestSerializer.setValue(token, forHTTPHeaderField: "token")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        manager.requestSerializer.httpShouldHandleCookies = true
        
        switch type {
        case .get:
            manager.get(url, parameters: params, progress: { progress in
                
                }, success: { (task, response) in
                    success(response)
            }) { (task, error) in
                failure(error)
            }
            break;
        case .post:
            manager.post(url, parameters: params, progress: { progress in
                
                }, success: { (task, response) in
                    success(response)
            }) { (task, error) in
                failure(error)
            }
            break;
        case .put:
            manager.put(url, parameters: params, success: { (task, response) in
                success(response)
            }) { (task, error) in
                failure(error)
            }
            break;
        case .delete:
            manager.delete(url, parameters: params, success: { (task, response) in
                success(response)
            }) { (task, error) in
                failure(error)
            }
            break;
        }
    }
    static func rpcRequest(_ type:RequestType, params:[String:Any]?, complete:@escaping ((Any?)->())) {
        let url = ConfigManager.rpcIp()
        AFNManager.baseRpcRequest(type, url: url, params: params, success: { (response) in
            let responseDict = response as! [String:Any]
            if (responseDict["error"] != nil) {
                let code = (responseDict["error"] as! [String:Any])["code"] as? Int
                
                if code == 401 {
                    UserDefaults.standard.set(0, forKey: ConfigManager.LOGIN_STATUS)
                    NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationManager.CHANGE_ROOTVIEWCONTROLLER), object: "Login")
                }
                complete(nil)
            }else  {
                complete(response)
            }
            }) { (error) in
                complete(nil)
                DispatchQueue.main.async(execute: {
                    ShowMessageTool.shareInstance().showTextMessage(ConfigManager.server_connect_error)
                })
        }
    }
    static func rpcDeviceRegister(_ params:[String:Any], complete:@escaping ((Any?)->())) {
        let param:[String:Any] = ["jsonrpc":"2.0", "method":"/device/info/create", "id":1, "params":[params]]
        
        AFNManager.rpcRequest(.post, params: param, complete: { (response) in
            complete(response)
        })
    }
    // MARK: 登录
    static func rpcLogin(_ params:[Any], complete:@escaping ((Any?)->())) {
        //{"jsonrpc":"2.0","method":"/login/login","id":1,"params":["zhongfan","1",false]}
        let param = ["jsonrpc":"2.0", "method":"/login/login", "id":1, "params":params] as [String : Any]
        
        AFNManager.rpcRequest(.post, params: param, complete: { (response) in
            complete(response)
        })
    }
    static func rpcLogout(_ complete:@escaping ((Any?)->())) {
        //{"jsonrpc":"2.0","method":"/login/logout","id":1}
        let param:[String : Any] = ["jsonrpc":"2.0", "method":"/login/logout", "id":1]
        
        AFNManager.rpcRequest(.post, params: param, complete: { (response) in
            complete(response)
        })
    }
    // MARK: 修改用户信息
    static func changeInfo(_ params:Any, complete:@escaping ((Any?)->())) {
        let param:[String : Any] = ["jsonrpc":"2.0", "method":"/security/user/update", "id":1, "params":[params]]
        AFNManager.rpcRequest(.post, params: param, complete: { (response) in
            complete(response)
        })
    }
    static func changePsw(_ params:Any, complete:@escaping ((Any?)->())) {
        // /security/user/updatePassword
        let param:[String : Any] = ["jsonrpc":"2.0", "method":"/security/user/updatePassword", "id":1, "params":[params]]
        
        AFNManager.rpcRequest(.post, params: param, complete: { (response) in
            complete(response)
        })
    }
    // MARK: 上传、下载
    static func uploadImage(_ image:UIImage, complete:@escaping (Any?)->()) {
        let urlStr = ConfigManager.rpcIp() + "?method=/file/fileinfo/upload"
        let param:[String:String] = ["fileName":"uploadFile","subsystem":"Security","instanceType":"User"]
        manager.requestSerializer.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        manager.post(urlStr, parameters: nil, constructingBodyWith: { formdata in
            let date = UIImagePNGRepresentation(image)
            for (key,value) in param {
                formdata.appendPart(withForm: value.data(using: String.Encoding.utf8)!, name: key)
            }
            formdata.appendPart(withFileData: date!, name: "uploadFile", fileName: "123.png", mimeType: "image/png")
            print(formdata)
        }, progress: { progress in
            print(progress)
        }, success: { (task,response) in
            complete(response)
        }, failure: { (task,error) in
            complete(nil)
        })
    }
    // MARK: 业务
    static func baseRequest(_ type:RequestType, url:String, params:[String:Any]?, complete:@escaping ((Any?)->())) {
        let baseURLStr = "http://\(ConfigManager.serverIp())/api/v2/"
        
        AFNManager.request(baseURLStr, type: type, url: url, params: params, success: { (response) in
            complete(response)
        }) { (error) in
            complete(nil)
        }
    }
    static func rpcProfessionRequests(_ url:String, params:Any, complete:@escaping ((Any?)->())) {
        //
        let param:[String : Any] = ["jsonrpc":"2.0", "method":url, "id":1, "params":params]
        
        AFNManager.rpcRequest(.post, params: param, complete: { (response) in
            complete(response)
        })
    }
    //MARK: - 文件
    static func downloadFile(_ urlStr:
        String, localFilePath:String, complete:((Any?)->())) {
        let url = URL(string: urlStr)
        let request = URLRequest(url: url!)
        if downloadTask != nil && downloadTask!.currentRequest?.url?.absoluteString == urlStr{
            downloadTask!.resume()
        }
        downloadTask = manager.downloadTask(with: request, progress: { (progress) in
            DispatchQueue.main.async(execute: {
//                self.progressLab.text = "下载中  \(progress.localizedDescription ?? "")"
//                self.downLoadView.progress = CGFloat(progress.fractionCompleted)
            })
            }, destination: { (targetPath, response) -> URL in
                
//                let fileUrl = FileModel.fileCacheURL
//                let name = response.suggestedFilename?.stringByRemovingPercentEncoding
                
                return URL(string: "")!
        }) { (response, filePath, error) in
            
        }
        downloadTask!.resume()
    }
    // MARK: - 其他
    static func getAppVersion(_ complete:@escaping ((Any?)->())) {
        //
        AFNManager.baseRequest(.get, url: "commons/version/ios", params: nil, complete: { (response) in
            complete(response)
        })
    }
    // MARK: - BMC
    static func baseBMCRequest(_ type:RequestType, url:String, params:[String:Any]?, complete:@escaping ((Any?)->())) {
        //sso=dkKsENEDxtX9rTISZlCuug==&ip=172.17.189.130&port=80
        let param:[String:Any] = ["sso":"dkKsENEDxtX9rTISZlCuug==", "ip":"172.17.189.130", "port":"80"]
        AFNManager.request(ConfigManager.defaultBMCIp, type: type, url: url, params: param, success: { (response) in
            complete(response)
        }) { (error) in
            complete(nil)
            DispatchQueue.main.async(execute: {
                ShowMessageTool.shareInstance().showTextMessage(ConfigManager.server_connect_error)
            })
        }
    }
    static func getBMCResources(_ complete:@escaping ((Any?)->())) {
        AFNManager.baseBMCRequest(.get, url: "event/resCount/1", params: nil, complete: { (response) in
            complete(response)
        })
    }
    static func getBMCResourceDetail(_ resId:String, complete:@escaping ((Any?)->())) {
        let url = "event/metric/byResId/1/" + resId
        AFNManager.baseBMCRequest(.get, url: url, params: nil, complete: { (response) in
            complete(response)
        })
    }
    static func getBMCAllWarning(_ resId:String, complete:@escaping ((Any?)->())) {
        //
        let url = "event/byResId/" + resId
        AFNManager.baseBMCRequest(.get, url: url, params: nil, complete: { (response) in
            complete(response)
        })
    }
    static func getWarnings(by type:String, complete:@escaping ((Any?)->())) {
        //
        let url = "event/byLevel/1?level=" + type
        AFNManager.baseBMCRequest(.get, url: url, params: nil, complete: { (response) in
            complete(response)
        })
    }
    static func getBMCWarningCount(_ complete:@escaping ((Any?)->())) {
        //
        AFNManager.baseBMCRequest(.get, url: "event/levelCount/1", params: nil, complete: { (response) in
            complete(response)
        })
    }
 */
}
