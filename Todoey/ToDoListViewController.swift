
import UIKit

class ToDoListViewController: UITableViewController {

    var array = ["ajay", "aman", "sachin", "pradeep"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func addBarBtnAction(_ sender: UIBarButtonItem) {
        var textField = UITextField()

            let alert = UIAlertController(title: "Add new Todey item", message: "", preferredStyle: .alert)

            let action = UIAlertAction(title: "add item", style: .default) { _ in
                print("success")
                if let newItem = textField.text, !newItem.isEmpty {
                    self.array.append(newItem)
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row]
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
               tableView.cellForRow(at: indexPath)?.accessoryType = .none
           } else {
               tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
           }
       }
    
}

