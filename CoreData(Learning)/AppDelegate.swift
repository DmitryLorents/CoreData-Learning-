//
//  AppDelegate.swift
//  CoreData(Learning)
//
//  Created by Mac on 04.02.2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let managedObject = Customer()
        managedObject.name = "OOO AvtoVaz"
        let name = managedObject.name
        print("Name: \(name ?? "no data")")
        

        //describe Entity
//        let entityDescription = NSEntityDescription.entity(forEntityName: "Customer", in: viewContext)
//
//        //create newObject
//        let managedObject = NSManagedObject(entity: entityDescription!, insertInto: viewContext)
//
//        // set attribute to context
//        managedObject.setValue("MDI2B LLC", forKey: "name")
//
//        //read attribute from context
//        let name = managedObject.value(forKey: "name")
//        print("Name: \(name ?? "n/a")")
//
//        //save object
//        saveContext()
//
//        //getting data from storage
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Customer")
//        do {
//            let results = try self.viewContext.fetch(fetchRequest)
//            for result in results as! [Customer] {
//                print("Name-\(result.name ?? "no data")")
//            }
//        } catch {
//            print(error)
//        }
        
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

    func saveContext() {
        CoreDataManager.instance.saveContext()
    }
}

