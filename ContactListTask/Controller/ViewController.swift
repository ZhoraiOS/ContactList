//
//  ViewController.swift
//  ContactListTask
//
//  Created by Zhora Babakhanyan on 6/21/22.
//

import UIKit
import Contacts

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var allContactList = [ContactModel]()
    var dublicatedNumbersContactList = [ContactModel]()
    var dublicatedNamesContactList = [ContactModel]()
    var withoutNamesContactList = [ContactModel]()
    var withoutPhoneNumberContactList = [ContactModel]()
    var withoutMailContactList = [ContactModel]()
    
    var contactsHeader = [cellHeaderDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchContectData()
        self.tableView.register(UINib(nibName: "ContactRowTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "ContactRowTableViewCell")
        
        self.tableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "HeaderTableViewCell")
        
        let allContactListHeader = cellHeaderDataModel(headerTitle: "All ", contactsCount: self.allContactList.count, contactsList: self.allContactList, isExpanded: false)
        
        let dublicatedNumbersContactListHeader = cellHeaderDataModel(headerTitle: "Dublicated Numbers ", contactsCount: self.dublicatedNumbersContactList.count, contactsList: self.dublicatedNumbersContactList, isExpanded: false)
        
        let dublicatedNamesContactListHeader = cellHeaderDataModel(headerTitle: "Dublicated Names ", contactsCount: self.dublicatedNamesContactList.count, contactsList: self.dublicatedNamesContactList, isExpanded: false)
        
        
        let withoutNamesContactListHeader = cellHeaderDataModel(headerTitle: "Without Name", contactsCount: self.withoutNamesContactList.count, contactsList: self.withoutNamesContactList, isExpanded: false)
        
        let withoutPhoneNumberContactList = cellHeaderDataModel(headerTitle: "Without PhoneNumber ", contactsCount: self.withoutPhoneNumberContactList.count, contactsList: self.withoutPhoneNumberContactList, isExpanded: false)
        
        let withoutMailContactList = cellHeaderDataModel(headerTitle: "Without Mail ", contactsCount: self.withoutMailContactList.count, contactsList: self.withoutMailContactList, isExpanded: false)
        
        self.contactsHeader.append(allContactListHeader)
        self.contactsHeader.append(dublicatedNamesContactListHeader)
        self.contactsHeader.append(dublicatedNumbersContactListHeader)
        self.contactsHeader.append(withoutNamesContactListHeader)
        self.contactsHeader.append(withoutPhoneNumberContactList)
        self.contactsHeader.append(withoutMailContactList)
    }
    
    func fetchContectData(){
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { (granted, err) in
          
            if let err = err {
                print("Error \(err)")
                return
            }
            
            if granted {
                let keys = [CNContactGivenNameKey,CNContactFamilyNameKey,CNContactGivenNameKey,CNContactPhoneNumbersKey,CNContactEmailAddressesKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
               
                do {
                    request.sortOrder = CNContactSortOrder.userDefault

                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPinterIfYouWantToStopEnumeating) in
                        let phone_number = contact.phoneNumbers.first?.value.stringValue ?? ""
                        let email = contact.emailAddresses.first?.value ?? " "
                        let full_name = "\(contact.givenName) \(contact.familyName)"
                        let contact_model = ContactModel(full_name: full_name, phone_number: phone_number, email: email as String)
                        
                        self.allContactList.append(contact_model)
                        
                    })

                    // MARK: ducblicated Names  -
                    let dublicatedNamesContactListDictionery = Dictionary(grouping: self.allContactList, by: {$0.full_name}).filter{$1.count > 1}.keys
                    let dublicatedNumbersContactList = Dictionary(grouping: self.allContactList, by: {$0.phone_number}).filter{$1.count > 1}.keys

                    for i in self.allContactList {
                        if dublicatedNamesContactListDictionery.contains(i.full_name){
                            if i.full_name != "" {
                                self.dublicatedNamesContactList.append(i)
                            }
                        }
                        if dublicatedNumbersContactList.contains(i.phone_number) {
                            if i.phone_number != "" {
                                self.dublicatedNumbersContactList.append(i)
                            }
                        }
                    }

                    
                    //MARK: Without Name  -
                    for contactWithoutName in self.allContactList {
                        if contactWithoutName.full_name == " " {
                            self.withoutNamesContactList.append(contactWithoutName)
                        }
                    }
         
                    // MARK: Without Phone Number -
                    for contactWithoutPhoneNumber in self.allContactList {
                        if contactWithoutPhoneNumber.phone_number == "" {
                            self.withoutPhoneNumberContactList.append(contactWithoutPhoneNumber)
                        }
                    }
                    
                    // MARK: Without email -
                    for contactWithoutEmail in self.allContactList {
                        if contactWithoutEmail.email == " " {
                            self.withoutMailContactList.append(contactWithoutEmail)
                        }
                    }
                     self.tableView.reloadData()
                  
                }catch let err{
                       print("Faild to enumarate contacts \(err)")
                }
            }
            else {
                print("Accsess Denied")
            }
        }
    }
}



// MARK: Table View Delegate -

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contactsHeader.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contactsHeader[section].isExpanded ? self.contactsHeader[section].contactsList.count : 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as! HeaderTableViewCell
        cell.cellConfiguration(element: contactsHeader[section], section: section, listCount: contactsHeader[section].contactsCount)
        cell.delagate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactRowTableViewCell", for: indexPath) as! ContactRowTableViewCell
        cell.cellConfiguration(element: contactsHeader[indexPath.section].contactsList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContactViewController") as! ContactViewController
        vc.contact = contactsHeader[indexPath.section].contactsList[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
}

// MARK: Cell Delegate -
extension ViewController: HeaderTableViewCellDelegate {
    func toggleSection(section: Int) {
        self.contactsHeader[section].isExpanded = !self.contactsHeader[section].isExpanded
        self.tableView.reloadData()
    }
}
