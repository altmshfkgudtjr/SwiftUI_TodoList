//
//  ContentView.swift
//  TodoList
//
//  Created by 김형석 on 2021/01/12.
//

import SwiftUI
import CoreData
import PartialSheet

struct ContentView: View {
    // PartialSheet을 사용하기 위한 설정 (import PartialSheet가 필요하다.)
    // PartialSheet와 관련된 모든 것을 사용하기 위해서는 해당 라이브러리 import가 필요하다. 라고 레퍼런스에 적혀있음.
    // 왜냐하면 Modal이 보여지기 위해서는 해당 공유자원을 수정해야 되기 때문이다.
    @EnvironmentObject var partialSheet : PartialSheetManager
    // CoreData에 접근하기 위한 설정
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "isDone == %@", NSNumber(value: false)),
        animation: .default
    ) private var taskList: FetchedResults<Task>

    var body: some View {
        Group {
            Text("전체 할 일")
            List {
                ForEach(taskList) { task in
                    TaskRow(task: task)
                }
                .onDelete(perform: self.deleteTask)
            }
            Button(action: self.addTask) {
                Text("할 일 추가")
            }
        }
        .addPartialSheet()
        // [TODO] navigation 또는 Group으로 전체를 한 번 감싸고, 거기에 해당 메소드를 걸어줘야 한다.
    }
    
    /* body에서 사용할 메소드 선언 */
    
    // 할 일 추가
    func addTask() {
        let newTask = Task(context: viewContext)
        newTask.id = UUID()
        newTask.title = "계획된 일"
        newTask.brief = ""
        newTask.isToday = false
        newTask.isDone = false
        
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    // 할 일 삭제
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

// ContentView 미리보기를 위한 설정
// Persistence에 미리보기를 위한 dump 데이터를 Preview로 보여지도록 한다.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
