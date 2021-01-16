//
//  ContentView.swift
//  TodoList
//
//  Created by 김형석 on 2021/01/12.
//

import SwiftUI
import CoreData
import PartialSheet
import ToastSwiftUI

struct ContentView: View {
    // PartialSheet을 사용하기 위한 설정 (import PartialSheet가 필요하다.)
    // PartialSheet와 관련된 모든 것을 사용하기 위해서는 해당 라이브러리 import가 필요하다. 라고 레퍼런스에 적혀있음.
    // 왜냐하면 Modal이 보여지기 위해서는 해당 공유자원을 수정해야 되기 때문이다.
    @EnvironmentObject var partialSheet : PartialSheetManager
    @ObservedObject var toastCenter: ToastCenter  = ToastCenter()
    
    // 현재 탭 tag를 지정해준다. 이 부분을 안하면 partialSheet이 열릴 때,
    // 초기화가 되는 버그가 발생할 수 있다.
    @State private var currentTab = 1
    
    var body: some View {
        NavigationView {
            ZStack {
                TabView(selection: $currentTab) {
                    TaskList(type: TodoType.TODAY)
                        .tabItem({ TabIcon(type: TodoType.TODAY) }).tag(1)
                    TaskList(type: TodoType.INCOMPLETE)
                        .tabItem({ TabIcon(type: TodoType.INCOMPLETE) }).tag(2)
                    TaskList(type: TodoType.DONE)
                        .tabItem({ TabIcon(type: TodoType.DONE) }).tag(3)
                    TaskList(type: TodoType.ALL)
                        .tabItem({ TabIcon(type: TodoType.ALL) }).tag(4)
                }
                TaskAddButton()
            }
            .navigationBarColor(UIColor(red: 18/255, green: 184/255, blue: 134/255, alpha: 1))
            
            .navigationBarTitle("투두리스트")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Link("NB#log", destination: URL(string: "https://altmshfkgudtjr.github.io/")!)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: {
                            self.partialSheet.showPartialSheet({
                                print("Partial sheet가 비활성화되었습니다!")
                            }) {
                                TaskModal(isNew: true)
                            }
                        }, label: {
                            Text("할 일 추가하기")
                        })
                        Text("제작자. NB")
                    }
                    label: {
                        Image(systemName: "ellipsis")
                            .padding(.vertical, 10)
                    }
                }
            }
        }
        .addPartialSheet()
        .toast(isPresenting: $toastCenter.isAddToast, message: "추가 완료", icon: .success)
        .toast(isPresenting: $toastCenter.isModifyToast, message: "수정 완료", icon: .success)
    }
}




// ContentView 미리보기를 위한 설정
// Persistence에 미리보기를 위한 dump 데이터를 Preview로 보여지도록 한다.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11 Pro Max")
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(PartialSheetManager())
        // preview를 위해서 PersistenceController의 preview의 container을 가져온다.
        // preview를 우히ㅐ서 sheetManager을 PartialSheetManger()으로 생성하여 설정한다.
    }
}
