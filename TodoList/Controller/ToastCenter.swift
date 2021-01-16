//
//  ToastController.swift
//  TodoList
//
//  Created by 김형석 on 2021/01/16.
//

import SwiftUI

// Toast를 위한 싱글톤 패턴의 Toast Controller
class ToastCenter: ObservableObject {
    // Toast를 띄위게 하기 위한 Flag 변수
    @Published var isAddToast = false
    @Published var isModifyToast = false
    
    init() { }
}
