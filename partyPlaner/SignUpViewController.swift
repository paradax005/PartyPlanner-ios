//
//  SignUpViewController.swift
//  partyPlaner
//
//  Created by iMac on 13/4/2022.
//

import UIKit
import Alamofire
class SignUpViewController: UIViewController {
    @IBOutlet weak var NextSignupBtn: UIButton!
    @IBOutlet weak var nameTextfiled: UITextField!
    @IBOutlet weak var emailTextfiled: UITextField!
    @IBOutlet weak var passwordTextfiled: UITextField!
    @IBOutlet weak var ageTextfiled: UITextField!
    @IBOutlet weak var phoneTextfiled: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        NextSignupBtn.layer.cornerRadius = 20
        NextSignupBtn.layer.masksToBounds = true
        
        passwordTextfiled.isSecureTextEntry = true

        // Do any additional setup after loading the view.
    }
    
    func checkEmailFormat() -> Bool {
      let validate = "[a-z1-9.]+@[a-z1-9]+.[a-z]{1,3}"
      let isValidate = NSPredicate(format: "SELF MATCHES %@", validate)
      let validateEmail = isValidate.evaluate(with: emailTextfiled.text)
     return validateEmail
   }
    
    @IBAction func signUpAction(_ sender: Any) {
        if nameTextfiled.text == "" || emailTextfiled.text == "" || passwordTextfiled.text == "" || phoneTextfiled.text == "" || ageTextfiled.text == "" {
            self.showAlertInvalidLogin(title: "alert", message: "champ vide")
        }
        else if checkEmailFormat() == false {
            self.showAlertInvalidLogin(title: "alert", message: "email n'est pas valide")
        }
        else {
            setData()
        }
    }
    func showAlertInvalidLogin(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "fermer", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func setData(){
        let signInModel = UserSignIn(name: nameTextfiled.text ?? "", email: emailTextfiled.text ?? "", age: Int(ageTextfiled.text ?? "") ?? 0, phone: phoneTextfiled.text ?? "", password: passwordTextfiled.text ?? "")
        let signInObject = signInModel.toJson(usersignIn: signInModel)
        let url = WebServiceURL.baseUrl + EndPoint.sinUp
        var request = URLRequest(url: URL(string: url)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = HTTPMethod.post.rawValue
        request.httpBody = signInObject
        AF.request(request).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {

            case .success :
                self.showAlertInvalidsignUp(title: "alert", message: "utilisateur ajouter")
             
            case .failure :
                
                self.showAlertInvalidsignUp(title: "alert", message: "utilisateur non ajouter")
                print(response.response?.statusCode)
            }
        }
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
extension UIViewController{
    func showAlertInvalidsignUp(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "fermer", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
