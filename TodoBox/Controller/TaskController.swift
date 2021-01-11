//
//  TaskController.swift
//  TodoBox
//
//  Created by 김형석 on 2021/01/11.
//

import Foundation
import SwiftUI
import CoreData

class TaskController: ObservableObject {
    @Environment(\.managedObjectContext) private var moc
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
    
    // 전체 태스크 반환
    func all() -> FetchedResults<Task> {
        return taskList
    }
    // 오늘 태스크 반환
    func today() -> FetchedResults<Task> {
        return taskTodayList
    }
    // 완료 태스크 반환
    func done() -> FetchedResults<Task> {
        return taskDoneList
    }
    
    // 태스크 추가
    func addTask(title: String, subTitle: String?, isToday: Bool) {
        let task = Task(context: self.moc)
        task.id = UUID()
        task.title = title
        task.subTitle = subTitle
        task.isToday = isToday
        task.isDone = false
        
        try? self.moc.save()
    }
    
    // 태스크 삭제
    func deleteTask(at indexSet: IndexSet) {
        print("태스크 삭제")
    }
    
    // 오늘 태스크 삭제
    func deleteTaskToday(at indexSet: IndexSet) {
        print("오늘 태스크 삭제")
    }
    
    // 완료 태스크 삭제
    func deleteTaskDone(at indexSet: IndexSet) {
        print("완료 태스크 삭제")
    }
    
    // 오늘 할 일 추가
    func addTodayTask(at indexSet: IndexSet) {
        for index in indexSet {
            let task = taskTodayList[index]
            task.isToday = true
            
            try? self.moc.save()
        }
    }
    
    // 오늘 할 일 제거
    func taskController(at indexSet: IndexSet) {
        for index in indexSet {
            let task = taskTodayList[index]
            task.isToday = false
            
            try? self.moc.save()
        }
    }
    
    init() {
        // anything
    }
}
