//
//  HeaderTableViewCell.swift
//  ContactListTask
//
//  Created by Zhora Babakhanyan on 6/23/22.
//

import UIKit

// MARK: Table View Cell Delegate -
protocol HeaderTableViewCellDelegate: AnyObject {
    func toggleSection(section: Int)
}

class HeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sectionNameLabel: UILabel!
    @IBOutlet weak var sectionItemsCountLabel: UILabel!
    var headerSection: Int!
    
    weak var delagate: HeaderTableViewCellDelegate?
    
    override func awakeFromNib() {
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func cellConfiguration(element: cellHeaderDataModel, section: Int, listCount: Int) {
        self.sectionNameLabel.text = element.headerTitle
        self.headerSection = section
        self.sectionItemsCountLabel.text = "\(listCount)"
    }
    
    @IBAction func headerTapButtonAction(_ sender: Any) {
        delagate?.toggleSection(section: self.headerSection)
    }
}
