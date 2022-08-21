//
//  ContactViewController.swift
//  ContactListTask
//
//  Created by Zhora Babakhanyan on 6/24/22.
//

import UIKit

class ContactViewController: UIViewController {

    @IBOutlet weak var fullNameOutlet: UILabel!
    @IBOutlet weak var phoneNumberOutlet: UILabel!
    @IBOutlet weak var emailOutlet: UILabel!
    
    var contact = ContactModel(full_name: "No Resault",
                               phone_number: "No Resault",
                               email: "No Resault")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.controllerConfiguration(contact: contact)
    }
    
    // Setting Up Controller

    func controllerConfiguration(contact : ContactModel){
        if contact.full_name != " " {
            self.fullNameOutlet.text = contact.full_name
        }else{
            self.fullNameOutlet.text = "Name Not Registered"
            self.fullNameOutlet.textColor = .red
        }

        if contact.phone_number != "" {
            self.phoneNumberOutlet.text = contact.phone_number
        }else{
            self.phoneNumberOutlet.text = "Phone Number Not Registered"
            self.phoneNumberOutlet.textColor = .red
        }

        if contact.email != " " {
            self.emailOutlet.text = contact.email
        }else{
            self.emailOutlet.text = "Email Not Registered"
            self.emailOutlet.textColor = .red
        }
    }
}
