//
//  StorageManager.swift
//  MovieApp
//
//  Created by Halil Bakar on 1.09.2023.
//

import Foundation
import RealmSwift

protocol RealmManagerProtocol {
    func create<T: Object>(_ object: T, onError: (RealmError) -> ())
    func getAll<T: Object>(_ object: T.Type) -> [T]
    func update<T: Object>(_ object: T, with dictionary: [String: Any?], onError: (RealmError) -> ())
    func delete<T: Object>(_ object: T, onError: (RealmError) -> ())
}

final class RealmManager: RealmManagerProtocol {
    
    static let shared = RealmManager()
    private init() {}
    
    private let realm = try! Realm()

    func create<T: Object>(_ object: T, onError: (RealmError) -> ()) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("Error creating object: \(error.localizedDescription)")
            onError(.addFailed)
        }
    }
    
    func getAll<T: Object>(_ object: T.Type) -> [T] {
        return Array(realm.objects(T.self))
    }
    
    func update<T: Object>(_ object: T, with dictionary: [String: Any?], onError: (RealmError) -> ()) {
        do {
            try realm.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            print("Error updating object: \(error.localizedDescription)")
            onError(.updateFailed)
        }
    }

    func delete<T: Object>(_ object: T, onError: (RealmError) -> ()) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print(error.localizedDescription)
            onError(.deleteFailed)
        }
    }
    
    func deleteAll(onError: (RealmError) -> ()) {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print(error.localizedDescription)
            onError(.deleteFailed)
        }
    }
}

