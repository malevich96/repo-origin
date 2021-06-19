//
//  SettingsSinglton.swift
//  VK1_App
//
//  Created by Анатолий Левин on 15.06.2021.
//

import UIKit

class SettingsSinglton {
    
    static var shared = SettingsSinglton()
    
    static let notificationName = Notification.Name(rawValue: "SettingsViewChenged")
    
    var borderWidth:CGFloat = 3
    var cornerRadius:CGFloat = 35
    var borderColor:CGColor = CGColor(srgbRed: 94/255, green: 170/255, blue: 241/255, alpha: 1)
    
    
    var shadowRadius:CGFloat = 8
    var shadowOpacity:Float = 1
    var shadowColor:CGColor = CGColor(srgbRed: 180/255, green: 156/255, blue: 246/255, alpha: 1)
    
    
    public func notificate() {
        NotificationCenter.default.post(name: SettingsSinglton.notificationName, object: nil)
    }
}
