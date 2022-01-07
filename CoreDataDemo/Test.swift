//
//  Test.swift
//  CoreDataDemo
//
//  Created by DSIAdmin on 1/7/22.
//

import Foundation

// This is how you reference the persistence controller
//let a = PersistenceController
//a.container

// returns instance of the persistence conroller so you dont have to make a bunch of instances, allows you to access the same instance wherever you are
// let a = PersistenceController.shared
// All crud operations are done on viewContext, this is how you reference
let a = PersistenceController.shared.container.viewContext
