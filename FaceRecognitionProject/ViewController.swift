//
//  ViewController.swift
//  FaceRecognitionProject
//
//  Created by Amr Elnagar on 10/11/2022.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    
    
    @IBAction func signInClicked(_ sender: Any) {
        
        // get the authentication context
        let authenticationCtxt = LAContext()
        
        // prepare for the error
        var authenticationError : NSError?
        
        // check if the device supports biometric authentication
        if authenticationCtxt.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authenticationError) {
            
            print("..... device check is ok .....")
            
            
            // trigger the authentication via biometrics
            authenticationCtxt.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Sign in with Face ID to access the App") {
                (success, error) in
                // since this is a clousre, then success: Bool will be returned if all authentication was ok, if not then error: NSError will be returned
                if success == true {
                    print(" .... performed the face id check .....")
                    
                    // since the Face ID is a separate thread, then we need to go back to the main thread
                    DispatchQueue.main.async {
                        // perform the segue
                        print(" .... before the segue .....")
                        self.performSegue(withIdentifier: "toSecondVC", sender: nil)
                        print(" .... after the segue .....")
                    }
                } else {
                    // in case of an authentication error, then display un-hide label in the main view controller and display an error message
                    DispatchQueue.main.async {
                        self.errorLabel.isHidden = false
                        self.errorLabel.text = "Authentication Error!"
                    }
                    /*
                    if self.errorLabel.isHidden {
                        self.errorLabel.isHidden = false
                        
                    }
                     */
                }
            }
                        
        }
        
        
        
    }
    
}

