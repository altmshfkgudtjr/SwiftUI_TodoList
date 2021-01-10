//
//  ContentView.swift
//  TodoBox
//
//  Created by 김형석 on 2021/01/09.
//

import SwiftUI

struct ContentView: View {
    private let date = getNow()
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [],
        animation: .default
    ) var taskList: FetchedResults<Task>
    
    var body: some View {
        NavigationView {
            Text("Toolbar")
                .font(.title)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                           // 목록으로 가기 Action
                        }, label: {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("목록")
                            }
                        })
                    }
                 }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                           // 목록으로 가기 Action
                        }, label: {
                            Image(systemName: "ellipsis")
                        })
                    }
                 }
                .navigationTitle("할 일 목록")
        }
//        VStack {
//            HStack {
//                Text("\(date)")
//                    .foregroundColor(Color.gray)
//                    .padding(.leading, 20.0)
//                Spacer()
//                Button("할 일 추가") {
//                    let mockTasks = ["A", "B", "C", "D"]
//
//                    let chosenTitle = mockTasks.randomElement()!
//
//                    let task = Task(context: self.moc)
//                    task.id = UUID()
//                    task.title = "\(chosenTitle)"
//                    task.subTitle = ""
//                    task.isToday = false
//                    task.isDone = false
//
//                    try? self.moc.save()
//                }
//                .padding(.trailing, 20.0)
//            }
//            Form {
//                Text("오늘 할 일")
//                    .fontWeight(.bold)
//                List(self.taskList, id: \.id) { task in
//                    HStack {
//                        Text(task.title ?? "할일이 지정되지 않았습니다.")
//                    }
//                }
//            }
//            Form {
//                Text("계획된 할 일")
//                    .fontWeight(.bold)
//                List {
//                }
//            }
//            Form {
//                Text("완료된 일")
//                    .fontWeight(.bold)
//                List {
//                }
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
