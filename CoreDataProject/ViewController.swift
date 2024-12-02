//
//  ViewController.swift
//  CoreDataProject
//
//  Created by DISEÑO on 27/11/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func connectBD() -> NSManagedObjectContext{
        let delegate = UIApplication.shared.delegate as! AppDelegate
        
        return delegate.persistentContainer.viewContext
    }
    
    func savePerson(){
        let context = connectBD()
        let entityPerson = NSEntityDescription.insertNewObject(forEntityName: "Person", into: context) as! Person
        entityPerson.name = nameTextField.text
        
        do{
            try context.save()
            clearTextField()
            print("Se guardo la persona")
        }catch let error as NSError{
            print("Error al guardar: \(error.localizedDescription)")
        }
    }
    
    func clearTextField(){
        nameTextField.text = ""
        nameTextField.becomeFirstResponder()
    }
    

    @IBAction func didTapRegister(_ sender: UIButton) {
        savePerson()
    }
    
}

