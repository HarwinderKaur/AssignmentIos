//
//  CartViewController.swift
//  PracticeFirebase
//
//  Created by Ramandeep Singh on 2017-07-20.
//  Copyright © 2017 Ramandeep Singh. All rights reserved.
//

import UIKit
import Foundation
import CoreData
import Firebase
import FirebaseDatabase

class CartViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITabBarControllerDelegate  {

    @IBOutlet weak var tableView: UITableView!
    var users:[NSManagedObject] = []
     var refStudent: DatabaseReference!
    var items:[DataModel] = []
    let textCellIdentifier = "cartCell"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate=self
        tableView.dataSource=self
        self.tabBarController?.delegate = self
        fetchData()
        refStudent = Database.database().reference().child("carts");

        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        items.removeAll()
        fetchData()
        tableView.reloadData()
        tabBarController?.tabBar.items![1].badgeValue = String(items.count)
        

        

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
        print("jndsjndd hello")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:CartTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: textCellIdentifier) as! CartTableViewCell
        
        cell.cartLbl?.text = items[indexPath.row].getItemName()
        
        
        print("hello??????????????????")
        
        
        //        cell.myImageView?.image = UIImage(data: films[indexPath.row].getPosterImage() as! Data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "showDetails") as! ShowDetailsViewController
        //        nextViewController.index = indexPath.row
        //        nextViewController.list = films
        //
        //        navigationController?.pushViewController(nextViewController, animated: true)
        print("hello click")
        print(items[indexPath.row].getItemName())
        //        
    }

    @IBAction func proceedTocheckout(_ sender: UIButton) {
        
        addStudent()
       
        
        
    }
    
    
    func addStudent(){
        //generating a new key inside artists node
        //and also getting the generated key
        
        
        //creating artist with the given values
        
        let alertController = UIAlertController(title: "Are you sure?", message: "You want to purchase items?", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .cancel,handler: {(alert: UIAlertAction!) in self.actionHandler()})
        alertController.addAction(okayAction)
        self.present(alertController, animated: true, completion: nil)
        
      
    }

    
    func actionHandler()  {
        for ele in items{
            let key = refStudent.childByAutoId().key
            let cart = ["orderid":key,
                        "id": ele.getId(),
                        "itemName": ele.getItemName(),
                        "itemType": ele.getItemType(),
                        "itemQuantity": ele.getItemQuantity(),
                        "itemPrice": ele.getItePrice(),
                        "itemImageUrl": ele.getItemImage()
           ]

            //adding the artist inside the generated unique key
            refStudent.child(key).setValue(cart)
        }
        
        
        //displaying message
        print("Items Added")
        
        clearCoreData()
        items.removeAll()
        self.tableView.reloadData()
        tabBarController?.tabBar.items![1].badgeValue = String(items.count)
        
       
    }
    
   
    
    func clearCoreData() {
        
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Cart")
        
        //3
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        do {
            users = try managedContext.fetch(fetchRequest)
            for m in users
            {
               managedContext.delete(m)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        do {
            // Save Managed Object Context
            try managedContext.save()
//            self.items.removeAll()
        } catch {
            print("Unable to save managed object context.")
        }
        
        
        
       
            }
    
    
    
    
    
    func fetchData() {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                
                return
        }
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Cart")
        
        //3
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        do {
            users = try managedContext.fetch(fetchRequest)
            for m in users
            {
                print("//////////////////////////////////////////////////////////////// ")
                print((m as! Cart).itemid!)
                print((m as! Cart).itemname!)
                print((m as! Cart).itemtype!)
                
                let models = DataModel(id: (m as! Cart).itemid!, itemName: (m as! Cart).itemname!, itemType: (m as! Cart).itemtype!, itemQuantity: (m as! Cart).itemQuantity!,itemPrice: (m as! Cart).itemPrice!,itemImageUrl: (m as! Cart).itemImageUrl!)
                
                items.append(models)
                
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
