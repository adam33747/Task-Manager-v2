//
//  DetailView.swift
//  TaskManager
//
//  Created by Adam Hu on 1/8/20.
//  Copyright © 2020 Adam Hu. All rights reserved.
//

import CoreData
import SwiftUI

struct EditTaskView: View {
   // let task: Task
    @State private var showingEditScreen = false
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    //@FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.urgency, ascending: true), NSSortDescriptor(keyPath: \Task.due, ascending: true)]) var tasks: FetchedResults<Task>
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.urgency, ascending: true), NSSortDescriptor(keyPath: \Task.due, ascending: true)]) var tasks: FetchedResults<Task>
    @State var title: String = ""
    @State var desc: String = ""
    @State var urgency: String = ""
    @State var due = Date()

    let urgencies = ["   Very important   ", "  Important  ", " Not important ", "Optional"]
    @ObservedObject var task: Task
    var body: some View {
        
            
        
            NavigationView {
                       Form {
                        Section {
               //print("inside the body: some" )
                TextField("Enter a title", text: $title)//.font(.largeTitle)

                TextField("Enter description", text: $desc)
                //Text("\(self.task.due ?? Date())")
                        }
                         DatePicker("Due date", selection: $due, in: Date()...)
                Section {
                    Picker("Level of importance", selection: $urgency) {
                        ForEach(urgencies, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    
                }
                        Section {
                       Button(action: {
                        self.task.title = self.title
                        self.task.desc = self.desc
                        self.task.due = self.due
                        self.task.urgency = self.urgency
                           do {
                               try self.moc.save()
                           } catch {
                               print(error)
                           }
                           
                           self.presentationMode.wrappedValue.dismiss()
                       }) {
                           Text("Save").fontWeight(.light)}.buttonStyle(SaveButton())
                       Button("Cancel") {
                                                                 self.presentationMode.wrappedValue.dismiss()
                                                             }.buttonStyle(SaveButton())
                }
                       
                }
    }.onAppear(perform: {
        self.title = self.task.title ?? ""
        self.desc = self.task.desc ?? ""
        self.due = self.task.due ?? Date()
        self.urgency = self.task.urgency ?? "Optional"
    })
    .navigationBarTitle("Edit Task")
}


struct EditTaskView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let task = Task(context: moc) 
        task.title = "Test title"
        task.desc  = "Test Desc"
        task.urgency = "Optional"
        task.due = Date()
        return NavigationView {
            EditTaskView(task: task)
        }
    }
}

}
