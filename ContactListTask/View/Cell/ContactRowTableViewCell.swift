//
//  ContactRowTableViewCell.swift
//  ContactListTask
//
//  Created by Zhora Babakhanyan on 6/21/22.
//

import UIKit

class ContactRowTableViewCell: UITableViewCell {

    @IBOutlet weak var contactImageOutlet: UIImageView!
    @IBOutlet weak var contactNameOutlet: UILabel!
    @IBOutlet weak var contactPhoneNumberOutlet: UILabel!
    @IBOutlet weak var contactEmailOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
// Cell Configuration
    func cellConfiguration(element: ContactModel) {
        self.contactNameOutlet.text = element.full_name
        self.contactPhoneNumberOutlet.text = element.phone_number
        self.contactEmailOutlet.text = element.email
    }
}
