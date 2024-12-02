//
//  EditPersonViewController.swift
//  CoreDataProject
//
//  Created by DISEÑO on 27/11/24.
//

import UIKit
import CoreData

class EditPersonViewController: UIViewController {
    
    
    @IBOutlet weak var nameEditTextField: UITextField!
    
    var personUpdate: Person?
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()

        
    }
    
    func connectBD() -> NSManagedObjectContext{
        let delegate = UIApplication.shared.delegate as! AppDelegate
        
        return delegate.persistentContainer.viewContext
    }
    func configureTextField(){
        nameEditTextField.text = personUpdate?.name
    }
    
    func editPerson(){
        let context = connectBD()
        personUpdate?.setValue(nameEditTextField.text, forKey: "name")
        
        do{
            try context.save()
            navigationController?.popViewController(animated: true)
            print("Se actualizo el usuario persona")
        } catch let error as NSError{
            print("Error al actualizar: \(error.localizedDescription)")
        }
    }
    
    
    @IBAction func didTapEdit(_ sender: UIButton) {
        editPerson()
    }
    
    
    
}
