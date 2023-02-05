//
//  EditProfileViewController.swift
//  partyPlaner
//
//  Created by iMac on 13/4/2022.
//

import UIKit
import Alamofire
class EditProfileViewController: UIViewController {
    @IBOutlet weak var nameEditTextFiled: UITextField!
    @IBOutlet weak var emailEditTextFiled: UITextField!
    @IBOutlet weak var ageEditTextFiled: UITextField!
    @IBOutlet weak var phoneEditTextFiled: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        nameEditTextFiled.text = UserDefaults.standard.string(forKey: "name")
        phoneEditTextFiled.text = UserDefaults.standard.string(forKey: "phone")
        ageEditTextFiled.text = String(UserDefaults.standard.integer(forKey: "age"))
        emailEditTextFiled.text = UserDefaults.standard.string(forKey: "email")
        
    }
    
    private func editProfile(){
        let userModel = User(id: UserDefaults.standard.string(forKey: "id") ?? "" , name: nameEditTextFiled.text ?? "", age: Int(ageEditTextFiled.text ?? "") ?? 0, email: emailEditTextFiled.text ?? "", phone: phoneEditTextFiled.text ?? "")
        let userObject = userModel.toJson(user: userModel)
        let url = WebServiceURL.baseUrl + EndPoint.updateUser
        var request = URLRequest(url: URL(string: url)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = HTTPMethod.post.rawValue
        request.httpBody = userObject
        AF.request(request).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {

            case .success :
                self.showAlertInvalidsignUp(title: "alert", message: "utilisateur modifier")
                UserDefaults.standard.set(self.nameEditTextFiled.text, forKey: "name")
                UserDefaults.standard.set(self.ageEditTextFiled.text, forKey: "age")
                UserDefaults.standard.set(self.phoneEditTextFiled.text, forKey: "phone")
                UserDefaults.standard.set(self.emailEditTextFiled.text,forKey: "email")
            case .failure :
                
                self.showAlertInvalidsignUp(title: "alert", message: "imposible de modifier l'utilisateur")
                print(response.response?.statusCode)
            }
        }
    }
    @IBAction func editAction(_ sender: Any) {
        self.editProfile()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
