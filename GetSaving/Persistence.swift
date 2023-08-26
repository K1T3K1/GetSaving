//
//  Persistence.swift
//  GetSaving
//
//  Created by Kajetan Patryk Zarzycki on 21/08/2023.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
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
    
    static var transactionPreview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for a in 0..<2 {
            let newIncome = Income(context: viewContext)
            newIncome.date = NSDate.now
            newIncome.name = "\(Int.random(in: 1..<1000000))"
            newIncome.value = 100
            newIncome.category = "Payroll"
            let newAccount = Account(context: viewContext)
            newAccount.name = "Account \(100+a)"
            newIncome.account = newAccount
        }
        for a in 0..<2 {
            let newExpense = Expense(context: viewContext)
            newExpense.date = NSDate.now
            newExpense.name = "\(Int.random(in: 1..<1000000))"
            newExpense.value = 25
            newExpense.category = "Groceries"
            let newAccount = Account(context: viewContext)
            newAccount.name = "Account \(10+a)"
            newExpense.account = newAccount
        }
        for _ in 0..<2 {
            let newExpense = Transaction(context: viewContext)
            newExpense.date = NSDate.now
            newExpense.name = "\(Int.random(in: 1..<1000000))"
            newExpense.value = 25
            newExpense.category = "Groceries"
            let newAccount = Account(context: viewContext)
            newAccount.name = "Account"
            newExpense.account = newAccount
        }
        
        for a in 0..<2 {
            let newAccount = Account(context: viewContext)
            newAccount.name = "Account \(a)"
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

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "GetSaving")
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
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
