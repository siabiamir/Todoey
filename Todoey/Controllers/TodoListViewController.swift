//
//  ViewController.swift
//  Todoey
//
//  Created by Amir Siabi on 12/29/17.
//  Copyright © 2017 Amir Siabi. All rights reserved.
//

import UIKit
import RealmSwift


class TodoListViewController: UITableViewController {

    
    var todoItems: Results<Item>?
    
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

//    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       

        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        

        
//        print(dataFilePath!)
        
//        let newItem = Item()
//        newItem.title = "Find Mike"
//       newItem.done = true
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "Buy Eggos"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "Destroy Demogorgon"
//        itemArray.append(newItem3)
        
//       if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
        
        
//        loadItems()
        
        
    }

    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            
            cell.textLabel?.text = item.title
            
            //        Ternary Condition
            //        value = condition ? valueItTrue : valueIfFalse
            //
            //        cell.accessoryType = item.done == true ? .checkmark : .none
            
            cell.accessoryType = item.done ? .checkmark : .none
            
            //        if item.done == true {
            //            cell.accessoryType = .checkmark
            //        } else {
            //            cell.accessoryType = .none
            //        }
            
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        

        
        return cell
        
    }
    
    //MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if let item = todoItems?[indexPath.row] {
            do {
            try realm.write {
//                realm.delete(item)
                item.done = !item.done

            }
            } catch {
                print("Error saving Status, \(error)")
            }
        }
        
        tableView.reloadData()
        
        //print(itemArray[indexPath.row])
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }

        
//        Tartib Mohem Ast !!!
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
       
        
//        todoItems[indexPath.row].done = !todoItems[indexPath.row].done
//or     itemArray[indexPath.row].done.setValue("Completed", forKey: "title")

//        saveItems()
        
//        tableView.reloadData()
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
   
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
      var textField = UITextField()
        
      let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen once the user clicks the Add item button on our UIAlert
            
            if let currentCategory = self.selectedCategory {
                do {
                   try self.realm.write {
//            let newItem = Item(context: self.context)
            let newItem = Item()
            newItem.title = textField.text!
//            newItem.done = false
//            newItem.parentCategory = self.selectedCategory
                    newItem.dateCreated = Date()
            currentCategory.items.append(newItem)
//            self.itemArray.append(newItem)
                }
                } catch {
                    print("Error saving new Items, \(error)")
                }
            }
            
            self.tableView.reloadData()
         
            
//            self.saveItems()
//            self.save(Item: newItem)
            
//            self.itemArray.append(textField.text!)
            
//            self.defaults.set(self.itemArray, forKey: "TodoListArray")
    
            
       }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Creat new Item"
            textField = alertTextField
            
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
   //MARK - Model Manupulation Methods
    
//    func saveItems () {
//
////        let encoder = PropertyListEncoder()
//
//        do {
////            let data = try encoder.encode(itemArray)
////            try data.write(to: dataFilePath!)
//
//            try context.save()
//
//        } catch {
////            print("Error encoding item array, \(error)")
//              print("Error saving context \(error)")
//    }
    
//      self.tableView.reloadData()
//}

//    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate : NSPredicate? = nil) {
    func loadItems() {
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let addtionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, addtionalPredicate])
//        } else {
//            request.predicate = categoryPredicate
//        }
//
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
//
//        request.predicate = compoundPredicate
//
//         if let data = try? Data(contentsOf: dataFilePath!) {
//            let decoder = PropertyListDecoder()
//            do {
//               itemArray = try decoder.decode([Item].self, from: data)
//            } catch {
//
//            print("Error decoding item array, \(error)")
//            }
//
//        }
//
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        do {
//            itemArray = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }

        tableView.reloadData()
    }
    
    
}

//MARK - Search bar Methods
extension TodoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        loadItems(with: request, predicate: predicate)

        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {

            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }
}
