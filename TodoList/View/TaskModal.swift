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
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var partialSheet : PartialSheetManager
    
    var isNew: Bool
    var task: Task?
    
    @State var taskTitle: String = ""
    @State var taskBrief: String = ""
    @State var taskIsToday: Bool = false
    
    init(isNew: Bool, task: Task? = nil) {
        self.isNew = isNew
        if (!isNew) {
            self.task = task
            _taskTitle = State(initialValue: task!.title ?? "")
            _taskBrief = State(initialValue: task!.brief ?? "")
            _taskIsToday = State(initialValue: task!.isToday)
        }
    }
    
    var body: some View {
        if (isNew) {
            VStack {
                Text("할 일 계획")
                    .font(.headline)
                    .fontWeight(.bold)
                VStack {
                    HStack(alignment: .top) {
                        Image(systemName: "circle")
                            .padding(.top, 2)
                        TextField("할 일 제목", text: $taskTitle)
                            .padding(.bottom, 10)
                    }
                    HStack(alignment: .top) {
                        Image(systemName: "circle")
                            .padding(.top, 2)
                        TextField("할 일 설명 (생략 가능)", text: $taskBrief)
                            .padding(.bottom, 10)
                            .foregroundColor(.gray)
                    }
                    Toggle(isOn: $taskIsToday) {
                        HStack(alignment: .top) {
                            Image(systemName: "sun.max")
                                .padding(.top, 2)
                            Text("오늘 할 일")
                        }
                    }.padding(.bottom, 10)
                    Button(action: {
                        self.addTask()
                        self.partialSheet.closePartialSheet()
                    }, label: {
                        Text("생성하기")
                            .fontWeight(.bold)
                            .padding()
                            .foregroundColor(Color.white)
                            .frame(width: 120, height: 40.0)
                            .background(Color(red: 18/255, green: 184/255, blue: 134/255))
                            .cornerRadius(12)
                    })
                }
                .padding(.horizontal)
            }
        } else {
            VStack {
                Text("할 일 계획")
                    .font(.headline)
                    .fontWeight(.bold)
                VStack {
                    HStack(alignment: .top) {
                        Image(systemName: "circle")
                            .padding(.top, 2)
                        TextField("할 일 제목", text: $taskTitle)
                            .padding(.bottom, 10)
                    }
                    HStack(alignment: .top) {
                        Image(systemName: "circle")
                            .padding(.top, 2)
                        TextField("할 일 설명 (생략 가능)", text: $taskBrief)
                            .padding(.bottom, 10)
                            .foregroundColor(.gray)
                    }
                    Toggle(isOn: $taskIsToday) {
                        HStack(alignment: .top) {
                            Image(systemName: "sun.max")
                                .padding(.top, 2)
                            Text("오늘 할 일")
                        }
                    }.padding(.bottom, 10)
                    HStack() {
                        Button(action: {
                            self.toggleDoneTask()
                            self.partialSheet.closePartialSheet()
                        }, label: {
                            Text(task!.isDone ? "되돌리기" : "완료하기")
                                .fontWeight(.bold)
                                .padding()
                                .foregroundColor(Color.white)
                                .frame(width: 120, height: 40.0)
                                .background(Color.gray)
                                .cornerRadius(12)
                        })
                        Spacer()
                        Button(action: {
                            self.updateTask()
                            self.partialSheet.closePartialSheet()
                        }, label: {
                            Text("수정하기")
                                .fontWeight(.bold)
                                .padding()
                                .foregroundColor(Color.white)
                                .frame(width: 120, height: 40.0)
                                .background(Color(red: 18/255, green: 184/255, blue: 134/255))
                                .cornerRadius(12)
                        })
                    }
                    .padding(.top, 20.0)
                }
                .padding(.horizontal)
            }
        }
    }
    
    // 할 일 추가
    func addTask() {
        let newTask = Task(context: viewContext)
        newTask.id = UUID()
        newTask.title = taskTitle
        newTask.brief = taskBrief
        newTask.isToday = taskIsToday
        newTask.isDone = false
        
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    // 할 일 수정
    func updateTask() {
        task?.title = taskTitle
        task?.brief = taskBrief
        task?.isToday = taskIsToday
        
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    // 할 일 완료
    func toggleDoneTask() {
        task?.isDone = !task!.isDone
        
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
}

