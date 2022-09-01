//
//  ContentView.swift
//  todolist20220821
//
//  Created by いーま on 2022/08/21.
//

import SwiftUI

struct TaskData{
    var title:String
    var completed:Bool
    var id = UUID()
}

struct ContentView: View {
    
    @State var appendTask:Bool = false
    @State var taskList:Array<TaskData> = []
    @State var task:String = ""
    @State var rowCnt:Int = 0
    
    var body: some View {
        if self.appendTask {
            NavigationView{
                List{
                    TextField("タスクを入力してください", text: $task)
                    
                    HStack{
                        Spacer()
                        Button(action: {
                            print("確定")
                            if task != ""{
                                taskList.append(TaskData(title: task, completed: false))
                                task = ""
                                appendTask.toggle()
                            }
                        }){
                            Text("確定")
                        }.foregroundColor(Color.blue)
                        Spacer()
                        
                    }
                    
                }.navigationTitle("追加")
                    .navigationBarItems(leading: Button(action: {
//                        print("戻る")
                        appendTask.toggle()
                    }){
                        Image(systemName: "lessthan")
                    })
            }
        }else{
            NavigationView{
                VStack{
                    List(0..<taskList.count, id:\.self){ index in
                        Button(action:{
//                            print("ボタンが押されたよ")
                            
                            taskList[index].completed.toggle()
                        }){
                            HStack{
                                Image(systemName:taskList[index].completed ? "checkmark.circle.fill" : "circle")
                                Text(taskList[index].title)
                            }
                        }.foregroundColor(.black)
                    }.navigationTitle("ToDoリスト")
                        .navigationBarItems(leading: Button(action: {
                            self.rowCnt = taskList.count
                            for i in 0..<taskList.count{
                                print((self.rowCnt - 1) - i)
                                if taskList[(self.rowCnt - 1) - i].completed{
                                    taskList.remove(at: (self.rowCnt - 1) - i)
                                }
                                
                            }
                        }){
                            Text("削除")
                        }, trailing: Button(action: {
                            appendTask.toggle()
                        }){
                            Text("追加")
                        })
                }
            }
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
