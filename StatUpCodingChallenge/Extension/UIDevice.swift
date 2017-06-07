//
//  UIDevice.swift
//  StatUpCodingChallenge
//
//  Created by Syed Sabir Salman on 6/6/17.
//  Copyright © 2017 Syed Sabir Salman. All rights reserved.
//

import UIKit

extension UIDevice {
    
    /*
     http://stackoverflow.com/questions/24869481/detect-if-app-is-being-built-for-device-or-simulator-in-swift
     */
    static func isIOSSimulator() -> Bool {
        #if ( arch(i386) || arch(x86_64) ) && os(iOS)
            return true
        #else
            return false
        #endif
    }
    
    /*
     http://stackoverflow.com/questions/26028918/ios-how-to-determine-iphone-model-in-swift
     */
    func extendedModel() -> String {
        return machineModel2ExtendedModel(machineModel())
    }
    
    fileprivate func machineModel() -> String {
        if let key = "hw.machine".cString(using: String.Encoding.utf8) {
            var size: Int = 0
            sysctlbyname(key, nil, &size, nil, 0)
            var machine = [CChar](repeating: 0, count: Int(size))
            sysctlbyname(key, &machine, &size, nil, 0)
            return String(cString: machine)
        }
        
        return model
    }
    
    /*
     Device model mappings taken from: http://www.enterpriseios.com/wiki/iOS_Devices
     */
    fileprivate func machineModel2ExtendedModel(_ machineModel: String) -> String {
        var extendedModel: String
        
        switch machineModel {
        case "iPhone1,1": extendedModel = "iPhone 2G"
        case "iPhone1,2": extendedModel = "iPhone 3G"
        case "iPhone2,1": extendedModel = "iPhone 3GS"
        case "iPhone3,1": extendedModel = "iPhone 4 (GSM)"
        case "iPhone3,2": extendedModel = "iPhone 4 (GSM / 2012)"
        case "iPhone3,3": extendedModel = "iPhone 4 (CDMA)"
        case "iPhone4,1": extendedModel = "iPhone 4S"
        case "iPhone5,1": extendedModel = "iPhone 5 (GSM)"
        case "iPhone5,2": extendedModel = "iPhone 5 (GSM+CDMA)"
        case "iPhone5,3": extendedModel = "iPhone 5c (GSM)"
        case "iPhone5,4": extendedModel = "iPhone 5c (GSM+CDMA)"
        case "iPhone6,1": extendedModel = "iPhone 5s (GSM)"
        case "iPhone6,2": extendedModel = "iPhone 5s (GSM+CDMA)"
        case "iPhone7,1": extendedModel = "iPhone 6 Plus"
        case "iPhone7,2": extendedModel = "iPhone 6"
        case "iPhone8,1": extendedModel = "iPhone 6s"
        case "iPhone8,2": extendedModel = "iPhone 6s Plus"
        case "iPod1,1": extendedModel = "iPod Touch 1G"
        case "iPod2,1": extendedModel = "iPod Touch 2G"
        case "iPod3,1": extendedModel = "iPod Touch 3G"
        case "iPod4,1": extendedModel = "iPod Touch 4G"
        case "iPod5,1": extendedModel = "iPod Touch 5G"
        case "iPod6,1": extendedModel = ""  // Does not exist
        case "iPod7,1": extendedModel = "iPod Touch 6G"
        case "iPad1,1": extendedModel = "iPad"
        case "iPad2,1": extendedModel = "iPad 2 (WiFi)"
        case "iPad2,2": extendedModel = "iPad 2 (GSM)"
        case "iPad2,3": extendedModel = "iPad 2 (CDMA)"
        case "iPad2,4": extendedModel = "iPad 2 (WiFi)"
        case "iPad2,5": extendedModel = "iPad Mini (WiFi)"
        case "iPad2,6": extendedModel = "iPad Mini (GSM)"
        case "iPad2,7": extendedModel = "iPad Mini (GSM+CDMA)"
        case "iPad3,1": extendedModel = "iPad 3 (WiFi)"
        case "iPad3,2": extendedModel = "iPad 3 (GSM+CDMA)"
        case "iPad3,3": extendedModel = "iPad 3 (GSM)"
        case "iPad3,4": extendedModel = "iPad 4 (WiFi)"
        case "iPad3,5": extendedModel = "iPad 4 (GSM)"
        case "iPad3,6": extendedModel = "iPad 4 (GSM+CDMA)"
        case "iPad4,1": extendedModel = "iPad Air (WiFi)"
        case "iPad4,2": extendedModel = "iPad Air (Cellular)"
        case "iPad4,4": extendedModel = "iPad Mini 2 (WiFi)"
        case "iPad4,5": extendedModel = "iPad Mini 2 (Cellular)"
        case "iPad4,6": extendedModel = "iPad Mini 2 (China Model)"
        case "iPad4,7": extendedModel = "iPad Mini 3 (WiFi)"
        case "iPad4,8": extendedModel = "iPad Mini 3 (Cellular)"
        case "iPad4,9": extendedModel = "iPad Mini 3 (China Model)"
        case "iPad5,1": extendedModel = "iPad Mini 4 (WiFi)"
        case "iPad5,2": extendedModel = "iPad Mini 4 (Cellular)"
        case "iPad5,3": extendedModel = "iPad Air 2 (WiFi)"
        case "iPad5,4": extendedModel = "iPad Air 2 (Cellular)"
        case "iPad6,7": extendedModel = "iPad Pro (WiFi)"
        case "iPad6,8": extendedModel = "iPad Pro (Cellular)"
        case "i386": extendedModel = "\(model) i386 Simulator"
        case "x86_64": extendedModel = "\(model) x86_64 Simulator"
            
        default: extendedModel = model
        }
        
        return extendedModel
    }
}
