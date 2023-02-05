//
//  ViewController.swift
//  partyPlaner
//
//  Created by Apple Esprit on 7/4/2022.
//

import UIKit
import AuthenticationServices
import GoogleSignIn
import Alamofire
class ViewController: UIViewController {
    
    
   
    
    @IBOutlet weak var GETSTART: UIButton!
    @IBOutlet weak var emailTextfiled : UITextField!
    @IBOutlet weak var passwordTextfiled : UITextField!
    @IBOutlet weak var viewLoding : UIView!
    @IBOutlet weak var indicator : UIActivityIndicatorView!
    
    private let signInButton = ASAuthorizationAppleIDButton()
    let signInConfig = GIDConfiguration.init(clientID: "578471318331-k8g892orlbqpc2vgo4plohn4b27e5bh4.apps.googleusercontent.com")
    var basURl = "https://https-partyplaner-onrender-com.onrender.com"
    override func viewDidLoad() {
        passwordTextfiled.isSecureTextEntry = true
        
        
     //function
   
        super.viewDidLoad()
        //view.addSubview(signInButton)
       // signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        viewLoding.isHidden = true
        indicator.isHidden = true
        GETSTART.layer.cornerRadius = 8
        GETSTART.layer.masksToBounds = true
        AF.request("https://httpbin.org/get").response  { response in
            debugPrint(response)
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInButton.frame = CGRect(x: 0,y: 0,width: 250,height: 50)
        signInButton.center = view.center
    }

 
    @IBAction func SignInWithGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }

            // If sign in succeeded, display the app's main content View.
          }
    }
    @IBAction func BTnStarted(_ sender: Any) {
        if emailTextfiled.text == "" || passwordTextfiled.text == ""{
            self.showAlertInvalidLogin(title: "alert", message: "empty field ! ")
        }
        else {
            UserDefaults.standard.set(emailTextfiled.text, forKey: "email")
            viewLoding.isHidden = false
            indicator.isHidden = false
            indicator.startAnimating()
            let auth = UserAuthentificate(email: emailTextfiled.text!, password: passwordTextfiled.text!)
            let authObject = auth.toJson(userAuthentificate: auth)
            let url = WebServiceURL.baseUrl + EndPoint.signIn
            var request = URLRequest(url: URL(string: url)!)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = HTTPMethod.post.rawValue
            request.httpBody = authObject
            AF.request(request).validate(statusCode: 200..<300).responseJSON { response in
                switch response.result {

                case .success :
                    self.viewLoding.isHidden = true
                    self.indicator.isHidden = true
                    self.indicator.stopAnimating()
                    UserDefaults.standard.set(self.passwordTextfiled.text, forKey: "password")
                    print(response.value)
                    let jsonData = try! JSONSerialization.data(withJSONObject: response.value)
                    do {
                        var payloadUser  = try JSONDecoder().decode(User.self, from: jsonData)
                        print(payloadUser.email)
                        UserDefaults.standard.set(payloadUser.name, forKey: "name")
                        UserDefaults.standard.set(payloadUser.age, forKey: "age")
                        UserDefaults.standard.set(payloadUser.phone, forKey: "phone")
                        UserDefaults.standard.set(payloadUser.id,forKey: "id")
                    } catch {
                        print("Decoding Error : \(error)")
                    }
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
                case .failure :
                    self.viewLoding.isHidden = true
                    self.indicator.isHidden = true
                    self.indicator.stopAnimating()
                    self.showAlertInvalidLogin(title: "alert", message: "utilisateur non trouver")
                    print(response.response?.statusCode)
                }
            }
        }
        
    }
    
    @IBAction func SignUpBtn(_ sender: Any) {
        
    }
    
    @IBAction func signInFb(_ sender: Any) {
    }
    
    
    
    @objc func didTapSignIn(){
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName,.email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
        
    }
    
}

extension ViewController: ASAuthorizationControllerDelegate{
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("failed!")
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential :
            let firstName = credentials.fullName?.givenName
            let lastName = credentials.fullName?.familyName
            let email = credentials.email
        
            break
        default:
            break
        }
    }
    func showAlertInvalidLogin(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "fermer", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
    
    
    
}
