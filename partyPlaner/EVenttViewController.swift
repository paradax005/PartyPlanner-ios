//
//  EVenttViewController.swift
//  partyPlaner
//
//  Created by Apple Esprit on 19/4/2022.
//

import UIKit

class EVenttViewController: UIViewController,UITableViewDelegate , UITableViewDataSource{
    
    
    var arrNames = [String]()
    var date : Date!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let Cell = tableView.dequeueReusableCell(withIdentifier: "MyCELL", for: indexPath)
        Cell.textLabel?.text = arrNames[indexPath.row]
        return Cell
    }
    
    
    @IBOutlet weak var tableViewEv: UITableView!
    
    @IBOutlet weak var textEventName: UITextField!
    
    @IBOutlet weak var DateEvt: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewEv.delegate = self
        tableViewEv.dataSource = self
        

    }
    

    @IBAction func BtnAddEv(_ sender: Any) {
        if let text = textEventName.text{
        
            arrNames.append(text)
            let indexPath = IndexPath(row: arrNames.count - 1, section: 0)
            tableViewEv.beginUpdates()
            tableViewEv.insertRows(at: [indexPath], with: .automatic)
            tableViewEv.endUpdates()
            textEventName.text = ""
        }
    }
    
    @IBAction func BtnEditEv(_ sender: Any) {
        tableViewEv.isEditing = !tableViewEv.isEditing
        
    }
    
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        
        return true
    }
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        arrNames.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            self.arrNames.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
