
import UIKit

class ToDoListViewController: UITableViewController {

    var array = ["ajay", "aman", "sachin", "pradeep"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

