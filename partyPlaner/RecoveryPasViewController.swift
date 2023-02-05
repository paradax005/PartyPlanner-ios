//
//  RecoveryPasViewController.swift
//  partyPlaner
//
//  Created by iMac on 13/4/2022.
//

import UIKit

class RecoveryPasViewController: UIViewController {

    @IBOutlet weak var NextRecoveryBtn: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        NextRecoveryBtn.layer.cornerRadius = 20
        NextRecoveryBtn.layer.masksToBounds = true

        // Do any additional setup after loading the view.
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
