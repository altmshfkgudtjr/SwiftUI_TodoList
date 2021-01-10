//
//  Utils.swift
//  TodoBox
//
//  Created by 김형석 on 2021/01/10.
//

import Foundation

func getNow() -> String {
    let now = Date()
    
    let date = DateFormatter()
    date.dateFormat = "yyyy-MM-dd"
    
    return date.string(from: now)
}
