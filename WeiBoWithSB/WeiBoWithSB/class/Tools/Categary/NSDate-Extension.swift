//
//  NSDate-Extension.swift
//  WeiBoWithSB
//
//  Created by digitalforest on 2018/2/23.
//  Copyright © 2018年 liukun. All rights reserved.
//

import Foundation

extension NSDate{
    class func createDateString(createAtStr:String) -> String {
        let createAtStr = createAtStr
        //创建时间格式化对象
        let fmt = DateFormatter()
        fmt.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
        fmt.locale = Locale(identifier: "en")
        //将字符串时间转成date类型
        guard let createDate = fmt.date(from: createAtStr) else {
            return ""
        }
        //创建当前时间
        let nowDate = Date()
        //获取时间差
        let interval = nowDate.timeIntervalSince(createDate)
        //一分钟内
        if interval < 60 {
            return "刚刚"
        }
        //1小时前
        if interval < 60 * 60 * 24{
            return "\(Int(ceil(interval/(60*60))))小时前"
            
        }
        //昨天数据
        let calendar = Calendar.current
        if calendar.isDateInYesterday(createDate){
            fmt.dateFormat = "昨天 HH:mm"
            let timestr = fmt.string(from: createDate)
            return timestr
            
        }
        //处理一年之内
        let cmps = calendar.dateComponents([Calendar.Component.year], from: createDate, to: nowDate)
        if cmps.year! < 1 {
            fmt.dateFormat = "MM-dd HH:mm"
            let timestr = fmt.string(from: createDate)
            return timestr
            
        }
        //超过1年
        fmt.dateFormat = "yyyy-MM-dd HH:mm"
        let timestr = fmt.string(from: createDate)
        return timestr
    }
}
