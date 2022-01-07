//
//  ContentView.swift
//  CoreDataDemo
//
//  Created by DSIAdmin on 1/7/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    // fetch results of person class
    // sortDescriptors allow us to sort the fetchedResults
    // The predicate allows us to filter, in this case, it only shows the Person objects with name 'Joe'
//    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "age", ascending: true)],
//                  predicate: NSPredicate(format: "name contains[c] 'joe'")) var people: FetchedResults<Person>
    
    @State var people = [Person]()
    @State var filterByText = ""
    
    @FetchRequest(sortDescriptors: []) var families: FetchedResults<Family>
    
    var body: some View {
        
        VStack{
            Button(action: addItem){
                Label {
                    Text("Add Item")
                } icon: {
                    Image(systemName: "plus")
                }
            }
            
            TextField("Filter Text", text: $filterByText)
            .border(Color.black, width: 1)
            .padding()
// uncomment this if using the filter
//            List{
//                ForEach(people){ person in
//
//                    // Updating data using .onTapGesture, this works because we already have a reference to the person object and can save again onTap
//                    Text("\(person.name ?? "No name"), age: \(person.age)")
//                        .onTapGesture {
//                            // Updating core data
//                            person.name = "Joe"
//                            try! viewContext.save()
//                            // Deleting core data
//                            //viewContext.delete(person)
//                            //try! viewContext.save()
//                        }
//                }
//            }
            List{
                ForEach(families){ family in
                    
                    // Updating data using .onTapGesture, this works because we already have a reference to the person object and can save again onTap
                    Text("\(family.name ?? ""), member count: \(family.members?.count ?? 0)")
                }
            }
            
        }
        
        //        NavigationView {
        //            List {
        //                ForEach(items) { item in
        //                    NavigationLink {
        //                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
        //                    } label: {
        //                        Text(item.timestamp!, formatter: itemFormatter)
        //                    }
        //                }
        //                .onDelete(perform: deleteItems)
        //            }
        //            .toolbar {
        //                ToolbarItem(placement: .navigationBarTrailing) {
        //                    EditButton()
        //                }
        //                ToolbarItem {
        //                    Button(action: addItem) {
        //                        Label("Add Item", systemImage: "plus")
        //                    }
        //                }
        //            }
        //            Text("Select an item")
        //        }
    }
    
    // function establishing a relationship from person to family
    func sampleCodePersonSide(){
        let f = Family(context: viewContext)
        f.name = "Collins Family"
        
        // Establish the Persons relationship with the Collins family
        let p = Person(context: viewContext)
        p.family = f
        
        // save
        try! viewContext.save()
    }
    
    // function establishing a relationship from family to person
    func sampleCodeFamilySide(){
        let f = Family(context: viewContext)
        f.name = "Collins Family"
        
        let p = Person(context: viewContext)
        f.addToMembers(p)
        
        // Save
        try! viewContext.save()
    }
    
    // Function to fetch data
    func fetchData(){
        
        // Create fetch request
        let request = Person.fetchRequest()
        
        // Set sort descriptors and predicates
        request.sortDescriptors = [NSSortDescriptor(key: "age", ascending: true)]
        request.predicate = NSPredicate(format: "name contains %@", filterByText)
        
        // Execute the fetch and present the results
        // execute it in a main thread since we are updating the UI
        DispatchQueue.main.async {
            do {
                let results = try viewContext.fetch(request)
                
                // Update the state property
                self.people = results
            }
            catch{
                print(error.localizedDescription)
            }

        }
    }
    
    // Function to add data coreData and save it
    private func addItem() {
        
        let family = Family(context: viewContext)
        family.name = String("Family #\(Int.random(in:0...20))")
        
        let numberOfMembers = Int.random(in: 0...5)
        
        for _ in 0...numberOfMembers {
            // creating a new person object
            let p = Person(context: viewContext)
            p.age = Int64(Int.random(in: 0...20))
            p.name = "Tom"
            p.family = family
        }
        // Save the data into core data
        do{
            try viewContext.save()
        }
        catch{
            // Error with saving
        }
        
        
        //        withAnimation {
        //            let newItem = Item(context: viewContext)
        //            newItem.timestamp = Date()
        //
        //            do {
        //                try viewContext.save()
        //            } catch {
        //                // Replace this implementation with code to handle the error appropriately.
        //                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        //                let nsError = error as NSError
        //                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        //            }
        //        }
    }
    
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
