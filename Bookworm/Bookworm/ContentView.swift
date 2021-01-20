//
//  ContentView.swift
//  Bookworm
//
//  Created by Peter Khouly on 24/12/2020.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>
    
    @State var firstName = "Peter"
    @State var lastName = "Khouly"

    
    
    @FetchRequest(entity: MyEventsMock.entity(), sortDescriptors: []) var myEvents: FetchedResults<MyEventsMock>
    @State var id = "idk"
    @State var isMyEvent = false
    
    var body: some View {
        VStack {
            Spacer()
            List {
                ForEach(students, id: \.id) { student in
                    Text(student.name ?? "Unknown")
                }
            }
            GroupBox {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
            }
            GroupBox{
                Button("Add") {
    //                let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
    //                let lastNames = ["Granger","Lovegood","Potter","Weasley"]
    //
    //                let chosenFirstNames = firstNames.randomElement()!
    //                let chosenLastNames = lastNames.randomElement()!
                    
                    let student = Student(context: self.moc)
                    student.id = UUID()
                    student.name = "\(firstName) \(lastName)"
                    
                    try? self.moc.save()
                    firstName = ""
                    lastName = ""
                }
            }
            GroupBox{
                Button("Add My Event") {
//                    adding event to firebase
                    
                    let myEvent = MyEventsMock(context: self.moc)
                    myEvent.id = id //documentid
                    myEvent.isMyEvent = true
                    
                    try? self.moc.save()
                    
                    //editing sumn
                    for myEvent in myEvents {
                        if myEvent.id == id {
                            let myCurrentEvent = MyEventsMock(context: self.moc)
                            //myCurrentEvent.id = id //documentid
                            myCurrentEvent.isMyEvent = false
                            
                            try? self.moc.save()
                        }
                    }
                }
            }
            Spacer()
        }
        .onAppear {
            for myEvent in myEvents {
                if myEvent.id == id {
                    isMyEvent = myEvent.isMyEvent
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
