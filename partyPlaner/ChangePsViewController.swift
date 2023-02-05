//
//  ChangePsViewController.swift
//  partyPlaner
//
//  Created by iMac on 13/4/2022.
//

import UIKit
import Alamofire
class ChangePsViewController: UIViewController {
    @IBOutlet weak var oldpasswordTextFiled: UITextField!
    @IBOutlet weak var newpassword: UITextField!
    @IBOutlet weak var repeatPasswordTexxtfiled: UITextField!
    @IBOutlet weak var SaveChangeBtnPs: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        SaveChangeBtnPs.layer.cornerRadius = 20
        SaveChangeBtnPs.layer.masksToBounds = true
        
        oldpasswordTextFiled.isSecureTextEntry = true
        newpassword.isSecureTextEntry = true
        repeatPasswordTexxtfiled.isSecureTextEntry = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func updateAction(_ sender: Any) {
        self.updatePassword()
    }
    private func updatePassword(){
        if (controlNewPassword() && controlOldPassword()) {
            let auth = UserSignIn(id: UserDefaults.standard.string(forKey: "id") ?? "", password: newpassword.text ?? "")
            let authObject = auth.toJson(usersignIn: auth)
            let url = WebServiceURL.baseUrl + EndPoint.updatePassword
            var request = URLRequest(url: URL(string: url)!)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = HTTPMethod.post.rawValue
            request.httpBody = authObject
            AF.request(request).validate(statusCode: 200..<300).responseJSON { response in
                switch response.result {

                case .success :
                    self.showAlertInvalidsignUp(title: "alert", message: "mot de passe modifiée")
                 
                case .failure :
                    
                    self.showAlertInvalidsignUp(title: "alert", message: "mot de passe non modifieé")
                    print(response.response?.statusCode)
                }
            }
            
        }
        else {
            self.showAlertInvalidsignUp(title: "alert", message: "probléme serveur")
        }
    }
    func controlOldPassword()-> Bool{
        if (self.oldpasswordTextFiled.text == UserDefaults.standard.string(forKey: "password")){
            return true
        }
        else {
            return false
        }
        
    }
    func controlNewPassword()->Bool{
        if (newpassword.text == repeatPasswordTexxtfiled.text){
            return true
        }
        else {
            return false
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
