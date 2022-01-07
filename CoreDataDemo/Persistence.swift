//
//  Persistence.swift
//  CoreDataDemo
//
//  Created by DSIAdmin on 1/7/22.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    // this property is just dummy data for the preview
    static var preview: PersistenceController = {
        // Create a new instance of persistenceController with completion handler so this dummy data doesn't get saved
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Person(context: viewContext)
            newItem.name = "Spencer"
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

    // adding private to this here makes it so that we can only access the shared instance of the PersistenceController
    private init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CoreDataDemo")
        // if inMemory is true, it won't save that data into our coreData
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
