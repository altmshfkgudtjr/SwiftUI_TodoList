//
//  TodoListApp.swift
//  TodoList
//
//  Created by 김형석 on 2021/01/12.
//

import SwiftUI
import PartialSheet

@main
struct TodoListApp: App {
    // [중요] Scene 수명주기를 다루기 위해서 선언
    // 새로운 swiftUI에서는 SceneDelegate가 존재하지 않는다. 그래서 각 수명주기를 다루는 방법은 다음과 같다.
    @Environment(\.scenePhase) private var scenePhase
    // 위 구문에서 \.scenePhase에서 \. 은 keypath를 의미한다.
    
    let sheetManager: PartialSheetManager = PartialSheetManager()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            // ContentView에서 사용할 환경으로 CoreData를 등록해준다.
            // ContentView에서 사용할 환경Object로 sheetManager을 등록해준다.
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(sheetManager)
            // environmentObject 방식은 직접 뷰모델 객체를 생성하여 사용할 때에도 사용되므로 숙지하자.
        }
        .onChange(of: scenePhase) { (newScenePhase) in
            switch newScenePhase {
            case .active:
                print("장면이 이제 활성화되었습니다!")
            case .inactive:
                print("장면이 이제 비활성화되었습니다!")
            case .background:
                print("장면이 이제 배경에 있습니다!")
                // 여기서 배경이란 해당 기기의 바탕화면이다.
            @unknown default:
                // 이 부분은 추후 나올 이벤트를 위해서 예외처리
                print("Apple이 어떠한 무언가를 추가하였습니다!")
            }
        } // 해당 onChange 구문을 통해서 장면 이벤트를 다룬다.
        // 하지만, 위 방법은 UIKit를 사용하는 앱은 인식하지 못한다. 그러므로 무조건 SwiftUI를 사용하는 App만 사용이 가능하다.
        // 혹시, 베이스는 SwiftUI 이되, 부분적으로는 UIKit를 사용할 수는 없을까?
        // [TODO] SwiftUI를 베이스로 UIKit 부분적으로 사용해보기
    }
}
