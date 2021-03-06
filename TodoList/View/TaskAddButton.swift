//
//  TaskAddButton.swift
//  TodoList
//
//  Created by 김형석 on 2021/01/13.
//

import SwiftUI
import PartialSheet

struct TaskAddButton: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var partialSheet : PartialSheetManager
    @ObservedObject var toastCenter: ToastCenter
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                Button(action: {
                    self.partialSheet.showPartialSheet({
                        print("Partial sheet가 비활성화되었습니다!")
                    }) {
                        TaskModal(isNew: true, toastCenter: self.toastCenter)
                    }
                }, label: {
                    Image(systemName: "plus")
                        .frame(width: 60, height: 60)
                        .foregroundColor(Color.white)
                })
                .background(Color(red: 18/255, green: 184/255, blue: 134/255))
                .cornerRadius(38.5)
                .padding()
                .padding(.bottom, 50)
                .shadow(color: Color.black.opacity(0.3),
                        radius: 3,
                        x: 3,
                        y: 3)
            }
        }
    }
}
