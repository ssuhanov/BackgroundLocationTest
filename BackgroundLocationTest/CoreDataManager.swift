//
//  CoreDataManager.swift
//  BackgroundLocationTest
//
//  Created by Serge Sukhanov on 2/24/18.
//  Copyright © 2018 Serge Sukhanov. All rights reserved.
//

import CoreData

typealias BooleanResultCompletion = (Bool, Error?) -> Void

class CoreDataManager {
    private init() {}
    static let shared = CoreDataManager()
    
    fileprivate lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BackgroundLocationTest")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            error.map { print("Load persisten stores failed with error \($0.localizedDescription)") }
        })
        return container
    }()
    
    func saveContext(completion: BooleanResultCompletion? = nil) {
        var contextDidSave = false
        var saveError: Error?
        
        do {
            try persistentContainer.viewContext.save()
            contextDidSave = true
        } catch {
            saveError = error
        }
        
        completion?(contextDidSave, saveError)
    }
}

extension NSManagedObject {
    private static func entityDescription() -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: String(describing: self), in: CoreDataManager.shared.persistentContainer.viewContext)
    }
    
    private static func createPrivate<T: NSManagedObject>() -> T? {
        let managedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
        if let entityDescription = entityDescription() {
            return T(entity: entityDescription, insertInto: managedObjectContext)
        }
        
        return nil
    }
    
    static func create() -> Self? {
        return createPrivate()
    }
    
    static func findAll() -> [NSManagedObject]? {
        let managedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: self))
        if let results = try? managedObjectContext.fetch(fetchRequest) {
            return results as? [NSManagedObject]
        }
        
        return nil
    }
    
    static func deleteAll() {
        let managedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
        findAll()?.forEach { managedObjectContext.delete($0) }
    }
}
