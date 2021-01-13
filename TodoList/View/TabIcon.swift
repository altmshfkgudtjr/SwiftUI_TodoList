//
//  TabIcon.swift
//  TodoList
//
//  Created by 김형석 on 2021/01/13.
//

import SwiftUI

struct TabIcon: View {
    var type: TodoType
    
    var body: some View {
        switch type {
        case TodoType.TODAY:
            VStack {
                Image(systemName: "sun.max")
                Text("오늘")
            }
        case TodoType.INCOMPLETE:
            VStack {
                Image(systemName: "doc.text")
                Text("계획")
            }
        case TodoType.DONE:
            VStack {
                Image(systemName: "checkmark")
                Text("완료")
            }
        case TodoType.ALL:
            VStack {
                Image(systemName: "tray.full")
                Text("전체")
            }
        }
    }
}
