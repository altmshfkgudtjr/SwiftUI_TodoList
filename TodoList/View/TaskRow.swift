//
//  TaskRow.swift
//  TodoList
//
//  Created by 김형석 on 2021/01/12.
//

import SwiftUI
import PartialSheet

struct TaskRow: View {
    @EnvironmentObject var partialSheet : PartialSheetManager
    @ObservedObject var toastCenter: ToastCenter
    
    var task: Task
    
    var body: some View {
        Button(action: {
            self.partialSheet.showPartialSheet({
                print("Partial sheet가 비활성화되었습니다!")
            }) {
                TaskModal(isNew: false, task: task, toastCenter: self.toastCenter)
            }
        }, label: {
            VStack(alignment: .leading) {
                Text(task.title ?? "불러오는 중입니다...")
                if (task.brief != "") {
                    Text(task.brief ?? "")
                        .font(.system(size: 14))
                        .foregroundColor(Color.gray)
                }
            }
        })
    }
}
