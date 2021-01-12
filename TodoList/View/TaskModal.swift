//
//  TaskSheet.swift
//  TodoList
//
//  Created by 김형석 on 2021/01/12.
//

import SwiftUI
import PartialSheet
// https://github.com/AndreaMiotto/PartialSheet#how-to-use 레퍼런스 참고하도록 하자!

struct TaskModal: View {
    var task: Task
    
    var body: some View {
        Group {
            Text("할 일 설정")
            Text("제목: \(task.title ?? "불러오는 중입니다")")
        }
    }
}

