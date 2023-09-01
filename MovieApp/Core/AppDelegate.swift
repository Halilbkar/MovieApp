//
//  AppDelegate.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import UIKit
import FirebaseCore
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
//        let config = Realm.Configuration(
//            schemaVersion: 2, // Yeni şema sürümü
//            migrationBlock: { migration, oldSchemaVersion in
//                if oldSchemaVersion < 2 {
//                    // Yapılan değişiklikleri burada tanımlayın
//                    // Örneğin, yeni alanların eklenmesi
//                    migration.enumerateObjects(ofType: FavoritesMoviesModel.className()) { oldObject, newObject in
//                        newObject?["release_date"] = "" // Varsayılan değer atayabilirsiniz
//                        newObject?["vote_average"] = 0.0 // Varsayılan değer atayabilirsiniz
//                    }
//                }
//            }
//        )
//        Realm.Configuration.defaultConfiguration = config
        
//        let config = Realm.Configuration(
//            schemaVersion: 2, // Yeni şema sürümünü burada belirtin
//            migrationBlock: { migration, oldSchemaVersion in
//                // Geçiş işlemi kodunu tanımlayın (gerekirse)
//            }
//        )
//        Realm.Configuration.defaultConfiguration = config
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

