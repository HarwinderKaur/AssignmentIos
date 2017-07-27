//
//  ContactUsViewController.swift
//  PracticeFirebase
//
//  Created by Ramandeep Singh on 2017-07-24.
//  Copyright © 2017 Ramandeep Singh. All rights reserved.
//

import UIKit
import MessageUI

class ContactUsViewController: UIViewController, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate {
    var phoneNumber : String!
    var emailId : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneNumber = "+1 123 456 7890"
        emailId = "test@gmail.com"
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Contact Us"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func emailContact(_ sender: UIButton) {
        sendEmail(email: "ramandsb@gmail.com")
    }
    

    @IBAction func callContact(_ sender: UIButton) {
        makePhoneCall()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func sendEmail()
    {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "Hello from iOS Programming"
            controller.recipients = [self.emailId!]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func makePhoneCall()
    {
        if let phoneCallURL:URL = URL(string: "tel:\(String(describing: self.phoneNumber!))")
        {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                let alertController = UIAlertController(title: "Lambton", message: "Are you sure you want to call \n\(String(describing: self.phoneNumber!))?", preferredStyle: .alert)
                let yesPressed = UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                    application.open(phoneCallURL)
                })
                let noPressed = UIAlertAction(title: "No", style: .default, handler: { (action) in
                    
                })
                alertController.addAction(yesPressed)
                alertController.addAction(noPressed)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
    func sendEmail(email: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            mail.setMessageBody("<p>Write Your body content here</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismiss(animated: true, completion: nil)
    }
    

}
