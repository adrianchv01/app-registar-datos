//
//  UserTableViewCell.swift
//  CoreDataProject
//
//  Created by DISEÑO on 27/11/24.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var person: Person?
    var viewController: UIViewController?
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = UIColor.clear
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configurePerson(person: Person, viewController: UIViewController){
        self.nameLabel.text = "Nombre: \(person.name ?? "")"
        self.person = person
        self.viewController = viewController
    }

}
