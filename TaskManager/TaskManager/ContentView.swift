//
//  ContentView.swift
//  TaskManager
//
//  Created by Adam Hu on 1/8/20.
//  Copyright © 2020 Adam Hu. All rights reserved.
//

import SwiftUI
import UIKit
struct GradientBackgroundStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(2)
            .padding(.horizontal, 10)
            .foregroundColor(.white)
            .font(.headline)
            .background(LinearGradient(gradient: Gradient(colors: [Color("darkGreen"), Color("lightGreen")]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
        .scaleEffect(configuration.isPressed ? 0.7 : 1.0)
    }
}
struct EditStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(2)
            .padding(.horizontal, 20)
            .foregroundColor(.white)
            .font(.headline)
            .background(LinearGradient(gradient: Gradient(colors: [Color("darkGreen"), Color("lightGreen")]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
        .scaleEffect(configuration.isPressed ? 0.7 : 1.0)
    }
}
struct SaveButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color("darkGreen"), Color("lightGreen")]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
            .padding(.horizontal, 15)
        .scaleEffect(configuration.isPressed ? 0.7 : 1.0)
    }
}
struct ContentView: View {
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.urgency, ascending: true), NSSortDescriptor(keyPath: \Task.due, ascending: true)]) var tasks: FetchedResults<Task>
    @State var isEditing = false
    @State private var showingAddScreen = false
   // var i = 0
     var body: some View {
        
            NavigationView{
                
                List {
                    
                   Section(header: Text("  ")) {
                    
                          ForEach(tasks, id: \.self) { task in
                            NavigationLink(destination: DetailView(task: task)){
                                TaskView(title: task.title ?? "Unknown Title", urgency: "\(task.urgency ?? "Optional" )", due: task.due ?? Date(), index: task.index )
                                //Text("\(task.order)")
                                
                            }
                            
                            
                          }.onDelete {indexSet in
                            let deleteItem = self.tasks[indexSet.first!]
                                self.moc.delete(deleteItem)
                                do{
                                    for (index,item) in self.tasks.enumerated() {
                                      print(index,item)
                                    }
                                    try self.moc.save()
                                }catch{
                                    print(error)
                                }
                            }
                    
                    }
                }
               .navigationBarTitle("Tasks")
                    .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive)).animation(Animation.spring())
                .navigationBarItems(leading: Button(action: { self.isEditing.toggle() }){
                    Text(isEditing ? " Done " : " Edit ")
                    .fontWeight(.light)
                }.buttonStyle(GradientBackgroundStyle()),
                        trailing: Button(action: {self.showingAddScreen.toggle()}) {
                            Text(" Add ").fontWeight(.light)}.buttonStyle(GradientBackgroundStyle()))
                      .sheet(isPresented: $showingAddScreen) {
                          AddTaskView().environment(\.managedObjectContext, self.moc)
            }
               
        }
        
        
    }
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

}
