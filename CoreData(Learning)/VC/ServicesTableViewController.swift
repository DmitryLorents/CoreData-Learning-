//
//  ServicesTableViewController.swift
//  CoreData(Learning)
//
//  Created by Mac on 06.02.2023.
//

import UIKit
import CoreData

class ServicesTableViewController: UITableViewController {
    
    let fetchedResulltController = CoreDataManager.instance.fetchedResultController(entityName: .services, keyForSort: "name")

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResulltController.delegate = self
        
        do {
            try fetchedResulltController.performFetch()
        } catch {
            print(error)
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    //MARK: - BarButtonAction
    
    @IBAction func addServiceAction(_ sender: Any) {
        performSegue(withIdentifier: "ServicesToService", sender: nil)
    }
    

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResulltController.sections {
            return sections[section].numberOfObjects
        } else {return 0}
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if let service = fetchedResulltController.object(at: indexPath) as? Services {
            cell.textLabel?.text = service.name
            cell.detailTextLabel?.text = service.info ?? ""
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let service = fetchedResulltController.object(at: indexPath) as? Services
        performSegue(withIdentifier: "ServicesToService", sender: service)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ServicesToService" else {return}
        let controller = segue.destination as! ServiceViewController
        controller.service = sender as? Services
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let managedObject = fetchedResulltController.object(at: indexPath) as! NSManagedObject
            CoreDataManager.instance.viewContext.delete(managedObject)
            CoreDataManager.instance.saveContext()
        }
    }
    
}

extension ServicesTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                let service = fetchedResulltController.object(at: indexPath) as? Services
                let cell = tableView.cellForRow(at: indexPath)
                    cell?.textLabel?.text = service?.name
                    cell?.detailTextLabel?.text = service?.info
            }
        default: break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
