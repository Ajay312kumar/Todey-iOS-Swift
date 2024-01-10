
import UIKit

class ToDoListViewController: UITableViewController {

    var array = ["ajay", "aman", "sachin", "pradeep"]
    var itemArray = [Item]()
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let itemsArray = defaults.array(forKey: "TodoListKey") as? [String] {
            array = itemsArray
        }
        
        let newItem = Item()
        newItem.title = "ajay"
        newItem.done = true
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "aman"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "sachin"
        itemArray.append(newItem3)
    }

    
    @IBAction func addBarBtnAction(_ sender: UIBarButtonItem) {
        var textField = UITextField()

            let alert = UIAlertController(title: "Add new Todey item", message: "", preferredStyle: .alert)

            let action = UIAlertAction(title: "add item", style: .default) { _ in
                print("success")
                if let newItem = textField.text, !newItem.isEmpty {
                    self.array.append(newItem)
                    self.tableView.reloadData()
                    self.defaults.set(self.array, forKey: "TodoListKey")
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
        
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
     
       }
    
}

