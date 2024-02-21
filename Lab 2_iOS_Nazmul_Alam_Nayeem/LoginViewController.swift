//  ViewController.swift
//  Lab 2_Fanshawe College_iOS_Nazmul_Alam_Nayeem
//  Created by Nazmul Alam Nayeem on 2024-01-25.


import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    private let welcomeSegue = "goToWelcome"
    private var userId:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
                    return
                }
                
                Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                    guard let strongSelf = self else { return }
                    
                    if let error = error {
                        strongSelf.displayAlert(title: "Sorry, Error!", message: error.localizedDescription)
                        return
                    }
                    
                    strongSelf.navigateToWelcome()
                }
            }
            
            private func navigateToWelcome() {
                performSegue(withIdentifier: welcomeSegue, sender: self)
            }
            
            @objc func textFieldChange(_ textField: UITextField) {
                refreshUI()
            }
            
            func setUI() {
                loginButton.isEnabled = false
                loginButton.backgroundColor = UIColor.systemGray
                emailTextField.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
                passwordTextField.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
                refreshUI()
                passwordTextField.isSecureTextEntry = true
                emailErrorLabel.isHidden = true
                passwordErrorLabel.isHidden = true
                emailTextField.placeholder = "someone@somewhere.com"
                passwordTextField.placeholder = "Password"
            }
            
            func refreshUI() {
                let emptyEmail = emailTextField.text?.isEmpty ?? true
                let emptyPassword = passwordTextField.text?.isEmpty ?? true
                loginButton.isEnabled = !(emptyEmail || emptyPassword)
                loginButton.backgroundColor = loginButton.isEnabled ? UIColor.systemIndigo : UIColor.gray
                emailErrorLabel.isHidden = !emptyEmail
                passwordErrorLabel.isHidden = !emptyPassword || emailTextField.isFirstResponder
                emailErrorLabel.text = emptyEmail ? "Please enter your email" : ""
                emailErrorLabel.textColor = UIColor.red
                passwordErrorLabel.text = emptyPassword ? "Please enter your password" : ""
                passwordErrorLabel.textColor = UIColor.red
            }
            
            func displayAlert(title: String, message: String) {
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(ok)
                
                present(alertController, animated: true, completion: nil)
            }
            
            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if segue.identifier == welcomeSegue {
                    if let userId = Auth.auth().currentUser?.uid,
                       let email = Auth.auth().currentUser?.email {
                        let destination = segue.destination as! WelcomeViewController
                        destination.userId = userId
                        destination.email = email
                    }
                }
            }
   
    
    
        }
