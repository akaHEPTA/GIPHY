//
//  CoreDataManager.swift
//  GIPHY API
//
//  Created by Richard Cho on 2021-11-28.
//

import UIKit
import CoreData

class CoreDataHandler {
    
    static let shared: CoreDataHandler = CoreDataHandler()
    
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let modelName: String = "SavedGif"
    
    func getGif(ascending: Bool = false) -> [SavedGif] {
        var models: [SavedGif] = [SavedGif]()
        guard let context = context else { return models }
        let idSort: NSSortDescriptor = NSSortDescriptor(key: "id", ascending: ascending)
        let fetchRequest: NSFetchRequest<NSManagedObject>
        = NSFetchRequest<NSManagedObject>(entityName: modelName)
        fetchRequest.sortDescriptors = [idSort]
        do {
            if let fetchResult: [SavedGif] = try context.fetch(fetchRequest) as? [SavedGif] {
                models = fetchResult
            }
        } catch let error as NSError {
            print("Could not fetch: \(error), \(error.userInfo)")
        }
        return models
    }
    
    func checkGif(by id: String) -> Bool {
        guard let context = context else { return false }
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = filteredRequest(id: id)
        do {
            let result = try context.fetch(fetchRequest)
            return result.count == 1
        } catch let error as NSError {
            print("Could not fetch: \(error), \(error.userInfo)")
            return false
        }
    }
    
    func saveGif(id: String, url: String) {
        guard let context = context, let entity = NSEntityDescription.entity(forEntityName: modelName, in: context) else { return }
        guard let savedGif = NSManagedObject(entity: entity, insertInto: context) as? SavedGif else { return }
        savedGif.id = id
        savedGif.url = url
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save: \(error), \(error.userInfo)")
        }
    }
    
    func deleteGif(id: String) {
        guard let context = context else { return }
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = filteredRequest(id: id)
        do {
            let results: [SavedGif] = try context.fetch(fetchRequest) as! [SavedGif]
            if results.count != 0 {
                context.delete(results[0])
            }
        } catch let error as NSError {
            print("Could not delete: \(error), \(error.userInfo)")
        }
        
    }
    
    private func filteredRequest(id: String) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: modelName)
        fetchRequest.predicate = NSPredicate(format: "id = %@", NSString(string: id))
        return fetchRequest
    }
    
}
