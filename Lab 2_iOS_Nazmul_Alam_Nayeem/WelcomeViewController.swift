//  WelcomeViewController.swift
//  Lab 2_Fanshawe College_iOS_Nazmul_Alam_Nayeem
//  Created by Nazmul Alam Nayeem on 2024-02-12.

import UIKit
import FirebaseAuth

class WelcomeViewController: UIViewController {
    
    
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
//    variable that is set by LoginViewController to pass here
    var userId:String?
    var email: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userIdLabel.text = userId
        emailLabel.text = email
    }
    

    @IBAction func onLogoutTapped(_ sender: UIButton) {
        
        dismiss(animated: true)
        
    }
    

}
