//
//  TaskList.swift
//  TodoList
//
//  Created by 김형석 on 2021/01/13.
//

import SwiftUI
import PartialSheet

struct TaskList: View {
    // CoreData에 접근하기 위한 설정
    @Environment(\.managedObjectContext) var viewContext
    // PartialSheet을 사용하기 위한 설정
    @EnvironmentObject var partialSheet : PartialSheetManager
    
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "isToday == %@ && isDone == %@", NSNumber(value: true), NSNumber(value: false)),
        animation: .default
    ) private var taskTodayList: FetchedResults<Task>
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "isToday == %@ && isDone == %@", NSNumber(value: false), NSNumber(value: false)),
        animation: .default
    ) private var taskList: FetchedResults<Task>
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "isDone == %@", NSNumber(value: true)),
        animation: .default
    ) private var taskDoneList: FetchedResults<Task>
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "isDone == %@", NSNumber(value: false)),
        animation: .default
    ) private var taskAllList: FetchedResults<Task>
    
    var type: TodoType
    
    var body: some View {
        GeometryReader { g in
            ScrollView {
                switch type {
                case TodoType.TODAY:
                    Text("오늘 할 일")
                        .fontWeight(.bold)
                        .padding(.top, 24.0)
                        .foregroundColor(Color.gray)
                    if (taskTodayList.count == 0) {
                        Text("모든 일을 마쳤어요!")
                            .padding(.top, g.size.height / 2 - 80)
                            .frame(width: g.size.width)
                    } else {
                        List {
                            ForEach(taskTodayList) { task in
                                TaskRow(task: task)
                            }
                            .onDelete(perform: self.deleteTask)
                        }.frame(width: g.size.width, height: g.size.height - 60, alignment: .center)
                    }
                case TodoType.INCOMPLETE:
                    Text("계획된 일")
                        .fontWeight(.bold)
                        .padding(.top, 24.0)
                        .foregroundColor(Color.gray)
                    if (taskList.count == 0) {
                        Text("모든 일을 마쳤어요!")
                            .padding(.top, g.size.height / 2 - 80)
                            .frame(width: g.size.width)
                    } else {
                        List {
                            ForEach(taskList) { task in
                                TaskRow(task: task)
                            }
                            .onDelete(perform: self.deleteTask)
                        }.frame(width: g.size.width, height: abs(g.size.height - 60), alignment: .center)
                    }
                case TodoType.DONE:
                    Text("완료된 일")
                        .fontWeight(.bold)
                        .padding(.top, 24.0)
                        .foregroundColor(Color.gray)
                    if (taskDoneList.count == 0) {
                        Text("모든 일을 마쳤어요!")
                            .padding(.top, g.size.height / 2 - 80)
                            .frame(width: g.size.width)
                    } else {
                        List {
                            ForEach(taskDoneList) { task in
                                TaskRow(task: task)
                            }
                            .onDelete(perform: self.deleteTask)
                        }.frame(width: g.size.width, height: g.size.height - 60, alignment: .center)
                    }
                case TodoType.ALL:
                    Text("전체 할 일")
                        .fontWeight(.bold)
                        .padding(.top, 24.0)
                        .foregroundColor(Color.gray)
                    if (taskAllList.count == 0) {
                        Text("모든 일을 마쳤어요!")
                            .padding(.top, g.size.height / 2 - 80)
                            .frame(width: g.size.width)
                    } else {
                        List {
                            ForEach(taskAllList) { task in
                                TaskRow(task: task)
                            }
                            .onDelete(perform: self.deleteTask)
                        }.frame(width: g.size.width, height: abs(g.size.height - 60), alignment: .center)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    // 할 일 삭제
    // [TODO] 삭제가 잘못되고 있음. 수정할 것
    func deleteTask(at offsets: IndexSet) {
        var id: UUID = UUID()
        
        for offset in offsets {
            id = taskList[offset].id
            break
        }
        
        if let target = taskList.first(where: {$0.id == id}) {
            viewContext.delete(target)
        } else {
            print("잘못된 접근입니다.")
        }
    }
}

// 투두리스트 탭에서 사용할 타입
enum TodoType: Int {
    case TODAY = 1
    case INCOMPLETE
    case DONE
    case ALL
}
