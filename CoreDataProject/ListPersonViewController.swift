//
//  ListPersonViewController.swift
//  CoreDataProject
//
//  Created by DISEÑO on 27/11/24.
//

import UIKit
import CoreData

class ListPersonViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var listPersonTableView: UITableView!
    
    var personData = [Person]()
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        showData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listPersonTableView.reloadData()
    }
    
    func connectBD() -> NSManagedObjectContext{
        let delegate = UIApplication.shared.delegate as! AppDelegate
        
        return delegate.persistentContainer.viewContext
    }
    
    func configureTableView(){
        listPersonTableView.delegate = self
        listPersonTableView.dataSource = self
        listPersonTableView.rowHeight = 60
    }
    
    func showData(){
        let context = connectBD()
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        
        do {
            personData = try context.fetch(fetchRequest)
            
            print("Se mostraron los datos en la tabla")
        } catch let error as NSError{
            
            print("Error al mostrar: \(error.localizedDescription)")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell
        let person = personData[indexPath.row]
        
        cell?.configurePerson(person: person, viewController: self)
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let context = connectBD()
        let person = personData[indexPath.row]
        
        if editingStyle == .delete{
            context.delete(person)
            
            do{
                try context.save()
                print("Se elimino el registro")
            }catch let error as NSError{
                print("Error al eliminar el registro: \(error.localizedDescription)")
            }
        }
        showData()
        listPersonTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "updateView", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "updateView"{
            if let id = listPersonTableView.indexPathForSelectedRow{
                let rowPerson = personData[id.row]
                
                let router = segue.destination as? EditPersonViewController
                
                router?.personUpdate = rowPerson
            }
        }
    }

    

}
