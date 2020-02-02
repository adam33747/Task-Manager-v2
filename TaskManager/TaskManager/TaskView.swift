//
//  TaskView.swift
//  TaskManager
//
//  Created by Adam Hu on 1/8/20.
//  Copyright © 2020 Adam Hu. All rights reserved.
//

import SwiftUI

struct TaskView: View {
    var title:String = ""
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    var urgency:String = ""
    var due:Date = Date()
    var index:Int16 = 0
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text(title).fontWeight(.light)
                    .font(.headline)
                //Text("\(index)")
                if self.urgency == "   Very important   " {
                   Text("  Very Important  ")
                    .fontWeight(.medium)
                        .padding(1.5)
                    .background(Color.red)
                    .cornerRadius(10)
                    .foregroundColor(Color("white"))
                    .font(.caption)
                }
                
                if self.urgency == "  Important  " {
                   Text("  Important  ")
                    .fontWeight(.medium)
                        .padding(1.5)
                    .background(Color.orange)
                    
                    .cornerRadius(10)
                    .foregroundColor(Color("white"))
                    .font(.caption)
                }
                if self.urgency == " Not important " {
                    Text("  Not Important  ")
                    .fontWeight(.medium)
                        
                        .padding(1.5)
                    .background(Color.yellow)
                    .cornerRadius(10)
                        .foregroundColor(Color("white"))
                    .font(.caption)
                }
            
                if self.urgency == "Optional" {
                    Text("  Optional  ")
                    .fontWeight(.medium)
                        .padding(1.5)
                    .background(Color.green)
                    .cornerRadius(10)
                    .foregroundColor(Color("white"))
                    .font(.caption)
                }
                Text("\(due, formatter: TaskView.taskDateFormat)").fontWeight(.light)
                
            }
        }
        
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
    }
}
