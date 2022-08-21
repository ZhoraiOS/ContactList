//
//  CellHeaderDataModel.swift
//  ContactListTask
//
//  Created by Zhora Babakhanyan on 6/23/22.
//

import Foundation

struct cellHeaderDataModel {
    var headerTitle : String
    var contactsCount: Int
    var contactsList : [ContactModel]
    var isExpanded: Bool
}
