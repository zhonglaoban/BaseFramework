//
//  String+Extension.swift
//  MyRill
//
//  Created by 钟凡 on 16/2/26.
//
//

import Foundation

extension String {
    public static func dateStrFromInt(_ intTime: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: intTime / 1000)
        let dfmt = DateFormatter()
        let now = Date()
        let time = NSInteger(now.timeIntervalSince(date))
        
        if (time < 60) {
            return "刚刚"
        }else if(time < 60 * 60){
            return "\(time/60)分钟前"
        }else if(time < 60 * 60 * 24){
            return "\(time/3600)小时前"
        }else if(time < 60 * 60 * 24 * 2){
            return "昨天"
        }else{
            dfmt.dateFormat = "yyyy-MM-dd";
            return dfmt.string(from: date)
        }
    }
    public static func base64StringFromImage(_ image: UIImage) -> String{
        /*
         NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
         NSString *base64Str = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
         
         return base64Str;*/
        let data = UIImageJPEGRepresentation(image, 1.0)
        
        let base64Str = data!.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
        
        return base64Str
    }
    //CFURLCreateStringByAddingPercentEscapes
    public static func urlString(_ str: String) -> String{
        let urlStr = ""
        return urlStr
    }
    public static func sizeFormate(_ size:Float) -> String {
        if size == 0 {
            return ""
        }else if size < 1024 {
            return "\(size)B"
        }else if size < 1024 * 1024 {
            return "\(String(format: "%.2f",size/1024))KB"
        }else if size < 1024 * 1024 * 1024 {
            return "\(String(format: "%.2f",size/1024/1024))MB"
        }else {
            return "\(String(format: "%.2f",size/1024/1024/1024))GB"
        }
    }
    public func isEmail() -> Bool {
        let pattern = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
        do {
            let regex: NSRegularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let matches = regex.matches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, self.characters.count))
            return matches.count > 0
        }
        catch {
            return false
        }
    }
    public func isPhoneNumber() -> Bool {
        let pattern = "^1[0-9]{10}$"
        do {
            let regex: NSRegularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let matches = regex.matches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, self.characters.count))
            return matches.count > 0
        }
        catch {
            return false
        }
    }
    public func randomStr(length:Int) -> String {
        var output = ""
        for _ in 0..<length {
            let randomNumber = arc4random_uniform(1000) % 26 + 97
            let randomChar = Character(UnicodeScalar(randomNumber)!)
            output.append(randomChar)
        }
        return output
    }
    /* 如果使用需要导入 #import <CommonCrypto/CommonDigest.h>
    public func md5() ->String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize()
        return String(format: hash as String)
    }
     */
}
