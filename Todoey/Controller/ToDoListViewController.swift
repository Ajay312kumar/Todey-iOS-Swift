
import UIKit
import CoreData

class ToDoListViewController: UITableViewController {

    var array = ["ajay", "aman", "sachin", "pradeep"]
    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let datafilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            print(documentsDirectory)
        }
        
        loadItems()
        
        
        if let itemsArray = defaults.array(forKey: "TodoListKey") as? [String] {
            array = itemsArray
        }
        
//        let newItem = Item()
//        newItem.title = "ajay"
//        newItem.done = true
//        itemArray.append(newItem)
//        
//        let newItem2 = Item()
//        newItem2.title = "aman"
//        itemArray.append(newItem2)
//        
//        let newItem3 = Item()
//        newItem3.title = "sachin"
//        itemArray.append(newItem3)
    }

    
    @IBAction func addBarBtnAction(_ sender: UIBarButtonItem) {
        var textField = UITextField()

                let alert = UIAlertController(title: "Add new Todey item", message: "", preferredStyle: .alert)

                let newItem = Item(context: self.context)

                let action = UIAlertAction(title: "Add item", style: .default) { _ in
                    print("success")
                    if let newItemTitle = textField.text, !newItemTitle.isEmpty {
                        newItem.title = newItemTitle
                        self.saveItems()
                        self.loadItems() // Reload data after saving
                        self.tableView.reloadData()
                    }
                }

                alert.addTextField { (alertTextField) in
                    textField = alertTextField
                    textField.placeholder = "Create new Item"
                    print(alertTextField.text)
                }

                alert.addAction(action)
                present(alert, animated: true, completion: nil)
    }
    
    func  saveItems() {
        
        do{
            try context.save()
        }catch{
            print("error saving constext \(error)")
        }
        
        
    }
    
    func loadItems() {
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do{
            itemArray = try context.fetch(request)
        }catch{
            print("error fetching from context\(error)")
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        context.delete(itemArray[indexPath.row])
        itemArray.remove(at: indexPath.row)
        //itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        
        //tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
     
       }
    
    
    
    
}

