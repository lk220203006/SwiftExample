//
//  StatusViewModel.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/2/24.
//  Copyright © 2018年 liukun. All rights reserved.
//

import UIKit
@objcMembers
class StatusViewModel: NSObject {
    //MARK:- 定义属性
    var status:Status?
    
    //MARK:- 对数据处理的属性
    var sourceText:String?
    var createAtText:String?
    
    //MARK:- 对用户数据处理
    var verifiedImage:UIImage?
    var vipImage:UIImage?
    var profileURL:URL?
    
    //MARK:- 自定义构造函数
    init(status:Status) {
        self.status = status
        //对来源处理
        if let source = status.source, source != ""{
            let startIndex = (source as NSString).range(of: ">").location + 1
            let length = (source as NSString).range(of: "</a>").location - startIndex
            sourceText = "来自:\((source as NSString).substring(with: NSRange(location: startIndex, length: length)))"
        }
        
        //处理时间
        if let created_at = status.created_at {
            createAtText = NSDate.createDateString(createAtStr: created_at)
        }
        
        let verified_type = status.user?.verified_type ?? -1
        switch verified_type {
        case 0:
            verifiedImage = UIImage(named: "avatar_vip")
        case 2,3,5:
            verifiedImage = UIImage(named: "avatar_enterprise_vip")
        case 220:
            verifiedImage = UIImage(named: "avatar_grassroot")
        default:
            verifiedImage = nil
        }
        
        let mbrank = status.user?.mbrank ?? 0
        if mbrank > 0 && mbrank < 7 {
            vipImage = UIImage(named: "common_icon_membership_level\(mbrank)")
        }
        
        let profileUrlString = status.user?.profile_image_url ?? ""
        profileURL = URL(string: profileUrlString)
    }
}
