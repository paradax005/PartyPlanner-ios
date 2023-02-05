//
//  AddEventSViewController.swift
//  partyPlaner
//
//  Created by Apple Esprit on 19/4/2022.
//

import UIKit
import Alamofire
class AddEventSViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet var titleField: UITextField!
    @IBOutlet var bodyField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    var fullDate : String?
    @IBOutlet weak var maxParticipantTextFiled: UITextField!
    public var completion:  ((String, String,Date ) ->Void)?
    var time : String?
    var date : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.delegate = self
        bodyField.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
        maxParticipantTextFiled.keyboardType = .numberPad

    }
    @objc func didTapSaveButton(){
        if let titleText  = titleField.text, !titleText.isEmpty,
           let bodyText  = bodyField.text, !bodyText.isEmpty{
            addEvent()
            completion?(titleText,bodyText,datePicker.date)
            
           
        }
        
    }
    private func addEvent(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let date = dateFormatter.date(from:"\(datePicker.date)" ?? "")!
        let PECDate = dateFormatter.string(from: date)
        if let date = dateFormatter.date(from: PECDate ) {
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            self.fullDate  = dateFormatter.string(from: date)
            let arrayDate = fullDate?.split(separator: " ")
            self.date = String((arrayDate?[0])!)
            self.time = String((arrayDate?[1])!)
        }
        let event = Event(eventTitle: titleField.text ?? "", venue: bodyField.text ?? "", maxParticipant: Int( maxParticipantTextFiled.text ?? "") ?? 0 , date:  self.date ?? "", time:  self.time ?? "", email: UserDefaults.standard.string(forKey: "email") ?? "")
        let eventObject = event.toJson(event: event)
        let url = WebServiceURL.baseUrl + EndPoint.event
        var request = URLRequest(url: URL(string: url)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = HTTPMethod.post.rawValue
        request.httpBody = eventObject
        AF.request(request).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {

            case .success :
                self.showAlertInvalidLogin(title: "alert", message: "evenement ajouter")
                
            case .failure :
                
                self.showAlertInvalidLogin(title: "alert", message: "evenement non ajouter")
                print(response.response?.statusCode)
            }
        }
        
    }
    func showAlertInvalidLogin(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "fermer", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
