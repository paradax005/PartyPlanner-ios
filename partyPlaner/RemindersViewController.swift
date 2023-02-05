//
//  RemindersViewController.swift
//  partyPlaner
//
//  Created by Apple Esprit on 19/4/2022.
//
import UserNotifications
import UIKit

class RemindersViewController: UIViewController {
    
    @IBOutlet var table: UITableView!
    
    var models = [MyReminder]()

    override func viewDidLoad() {
        super.viewDidLoad()

        table.delegate = self
        table.dataSource = self
        }
    @IBAction func didTapAdd(){
        guard let  VC = storyboard?.instantiateViewController(withIdentifier: "add") as? AddEventSViewController else {
            
            return
        }
        VC.title = "New Reminder"
        VC.navigationItem.largeTitleDisplayMode = .never
        VC.completion = { title , body , date in
            DispatchQueue.main.async{
                self.navigationController?.popToRootViewController(animated: true)
                let new = MyReminder(title: title, date: date, indentidier: "id_\(title)")
                self.models.append(new)
                self.table.reloadData()
                
                
                let content = UNMutableNotificationContent()
                content.title = title
                content.sound = .default
                content.body = body
                
                let targetDate = date
                let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents( [.year,.month,.day,.hour,.minute,.second] , from: targetDate),
                                                            repeats: false)
                let request = UNNotificationRequest(identifier: "some-Long-id", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
                    if error != nil {
                        print("somthing went wrong")
                        
                    }
                })
            }
        }
        navigationController?.pushViewController(VC, animated: true)
        
    }
    @IBAction func didTapTest(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert , .badge, .sound, ], completionHandler: {success, error in
            if success{
                self.scheduleTest()
                
            }
            else if  error != nil {
                print("error occurend")
                
            }
        })
        
        
    }
    func scheduleTest(){
        let content = UNMutableNotificationContent()
        content.title = "ahla bik"
        content.sound = .default
        content.body = "MY LONG BODY .MY LONG BODY .MY LONG BODY ."
        
        let targetDate = Date().addingTimeInterval(10)
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents( [.year,.month,.day,.hour,.minute,.second] , from: targetDate),
                                                    repeats: false)
        let request = UNNotificationRequest(identifier: "some-Long-id", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
            if error != nil {
                print("somthing went wrong")
                
            }
        })
    }
 

}
extension RemindersViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}


extension RemindersViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celll", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].title
        let date = models[indexPath.row].date
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, dd , YYYY at hh:mm a "
        cell.detailTextLabel?.text = formatter.string(from: date)
        return cell
    }
    
    
}


struct  MyReminder{
    let title: String
    let date: Date
    let indentidier: String
}

