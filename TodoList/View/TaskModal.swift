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
    
    var isNew: Bool
    var task: Task?
    
    @State var taskTitle: String = ""
    @State var taskBrief: String = ""
    @State var taskIsToday: Bool = false
    
    var body: some View {
        if (isNew) {
            VStack {
                Text("할 일 계획")
                    .font(.headline)
                    .fontWeight(.bold)
                VStack {
                    TextField("할 일 제목", text: $taskTitle)
                        .padding(.bottom, 10)
                    TextField("할 일 설명 (생략 가능)", text: $taskBrief)
                        .padding(.bottom, 10)
                    Toggle(isOn: $taskIsToday) {
                        Text("오늘 등록")
                    }.padding(.bottom, 10)
                    Button(action: {
                        self.addTask()
                    }, label: {
                        Text("생성하기")
                            .padding()
                            .foregroundColor(Color.white)
                            .frame(width: 100, height: 40.0)
                            .background(Color.blue)
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
                    TextField("할 일 제목", text: $taskTitle)
                        .padding(.bottom, 10)
                    TextField("할 일 설명 (생략 가능)", text: $taskBrief)
                        .padding(.bottom, 10)
                    Toggle(isOn: $taskIsToday) {
                        Text("오늘 등록")
                    }.padding(.bottom, 10)
                    Button(action: {
                        self.addTask()
                    }, label: {
                        Text("수정하기")
                            .padding()
                            .foregroundColor(Color.white)
                            .frame(width: 100, height: 40.0)
                            .background(Color.blue)
                            .cornerRadius(12)
                    })
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
}

