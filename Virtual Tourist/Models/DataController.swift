//
//  DataController.swift
//  Virtual Tourist
//
//  Created by Felipe Ribeiro on 01/02/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    
    // MARK: - Properties
    
    static let name = "Virtual Tourist"
    let persistentContainer: NSPersistentContainer
    
    // MARK: - Computed Properties
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Shared Instance
    
    class var shared: DataController {
        struct Shared {
            static var instance = DataController(name: DataController.name)
        }
        
        return Shared.instance
    }
    
    // MARK: - Initializer
    
    init(name: String) {
        persistentContainer = NSPersistentContainer(name: name)
    }
    
    // MARK: - Helper Methods
    
    func configureContext() {
        viewContext.automaticallyMergesChangesFromParent = true
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Could not load persistent stores: \(error!.localizedDescription)")
            }
            
            self.configureContext()
            completion?()
        }
    }
}
