//
//  Persistence.swift
//  TodoList
//
//  Created by 김형석 on 2021/01/12.
//

import CoreData

// Persistence, 즉 '영속성' 컨트롤러이다.
// persistence는 해당 application이 종료되어도, 삭제되지 않는 지속성을 의미한다.
struct PersistenceController {
    static let shared = PersistenceController()

    // XCode에서 canvas 미리보기를 할 때, 미리보기를 보여줄 데이터이다.
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<10 {
            let newTask = Task(context: viewContext) // vieContext에 연결된 context에서 Task 생성.
            newTask.id = UUID()
            newTask.title = "계획된 일 \(i)"
            newTask.brief = ""
            newTask.isToday = false
            newTask.isDone = false
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    // 생성자
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "TodoList")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
