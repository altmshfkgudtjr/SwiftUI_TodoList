//
//  ContentView.swift
//  TodoBox
//
//  Created by 김형석 on 2021/01/09.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "isToday == NO && isDone == NO"),
        animation: .default
    ) private var taskList: FetchedResults<Task>
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "isToday == YES && isDone == NO"),
        animation: .default
    ) private var taskTodayList: FetchedResults<Task>
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "isDone == YES"),
        animation: .default
    ) private var taskDoneList: FetchedResults<Task>
    
    @ObservedObject var taskController = TaskController()
    
    private let date = getNow()
   
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("오늘 할 일")
                            .fontWeight(.bold)) {
                    ForEach(taskTodayList, id: \.id) { task in
                        HStack {
                            Text(task.title ?? "할일이 지정되지 않았습니다.")
                                .font(.body)
                        }
                    }
                    .onDelete(perform: taskController.taskController)
                }
                Spacer()
                Section(header: Text("계획된 일")
                            .fontWeight(.bold)) {
                    ForEach(taskList, id: \.id) { task in
                        HStack {
                            Text(task.title ?? "할일이 지정되지 않았습니다.")
                                .font(.body)
                        }
                    }
                    .onDelete(perform: taskController.deleteTask)
                }
                Spacer()
                Section(header: Text("완료된 일")
                            .fontWeight(.bold)) {
                    ForEach(taskDoneList, id: \.id) { task in
                        HStack {
                            Text(task.title ?? "할일이 지정되지 않았습니다.")
                                .font(.body)
                        }
                    }
                    .onDelete(perform: taskController.deleteTask)
                }
            }
                .font(.title)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                           // 목록으로 가기 Action
                        }, label: {
                            HStack {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.black)
                                Text("목록")
                                    .foregroundColor(.black)
                            }
                        })
                    }
                 }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            Button(action: {
                                taskController.addtask(title: "Test", subTitle: "-", isToday: false)
                            }, label: {
                                HStack {
                                    Text("")
                                        .foregroundColor(.black)
                                    Image(systemName: "plus.app")
                                        .foregroundColor(.black)
                                }
                            })
                            Button(action: {
                               // 목록으로 가기 Action
                            }, label: {
                                HStack {
                                    Text("")
                                        .foregroundColor(.black)
                                    Image(systemName: "ellipsis")
                                        .foregroundColor(.black)
                                }
                            })
                        }
                        
                    }
                 }
                .navigationTitle("할 일 목록")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
