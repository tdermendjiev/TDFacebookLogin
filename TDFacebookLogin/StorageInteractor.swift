//
//  StorageInteractor.swift
//  TDFacebookLogin
//
//  Created by Teodor Dermendzhiev on 1/18/17.
//  Copyright © 2017 Teodor Dermendzhiev. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        
        return array
    }
}

class StorageInteractor: NSObject {
    
    
    static func writeToStorage<T>(type: T.Type, data: [String: Any], update: Bool) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.create(type as! Object.Type, value: data, update: update)
        }
    }
    
    static func fetchFromStorage<T>(type: T) -> Results<Object> {
        let realm = try! Realm()
        let results = realm.objects(type.self as! Object.Type)
        return results
    }
    
    static func deleteFromStorage<T>(type: T) -> () {
        let realm = try! Realm()
        if let result = realm.objects(type.self as! Object.Type).first {
            try! realm.write {
                realm.delete(result)
            }
        }
    }
    
    static func fetchFromStorage<T>(type: T, predicate: NSPredicate) -> Results<Object> {
        let realm = try! Realm()
        let results = realm.objects(type.self as! Object.Type).filter(predicate)
        return results
    }
    
    static func updateEntity<T>(type: T.Type, key: String, value: Any, completion: (Bool) -> ()) {
        let realm = try! Realm()
        let items = realm.objects(type as! Object.Type)
        do {
            try realm.write {
                items.first?.setValue(value, forKeyPath: key)
                completion(true)
            }
        } catch {
            print("Realm update failed. Check if types match.")
            completion(false)
        }
    }
}
