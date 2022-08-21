//
//  ContactModel.swift
//  ContactListTask
//
//  Created by Zhora Babakhanyan on 6/21/22.
//

import Foundation


enum contactType {
    case allContacts
    case dublicatedName
    case dublicatedPhoneNumber
    case withoutName
    case withoutPhoneNumber
    case withoutEmail
}

struct ContactModel {
    
    var full_name: String
    var phone_number: String
    var email: String
    
}
