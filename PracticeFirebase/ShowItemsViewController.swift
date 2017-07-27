//
//  ShowItemsViewController.swift
//  PracticeFirebase
//
//  Created by Ramandeep Singh on 2017-07-20.
//  Copyright © 2017 Ramandeep Singh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import CoreData

class ShowItemsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    let textCellIdentifier = "tableCell"
    var refStudent: DatabaseReference!
     var users:[NSManagedObject] = []
     var dataitems: [DataModel] = []
    
    var countObjs: [String] = []
    
        override func viewDidLoad() {
        super.viewDidLoad()
                    refStudent = Database.database().reference().child("items");
             getStudentRecords()
        
        
            print(dataitems.count)
            tableView.delegate=self
            tableView.dataSource=self
//            tabBarController?.tabBar.items![1].badgeValue = "2"

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
            fetchData()
        tabBarController?.tabBar.items![1].badgeValue = String(countObjs.count)
        

    }

    
    func getStudentRecords()
    {
        //observing the data changes
        refStudent.observe(DataEventType.value, with: { (snapshot) in
            
            self.dataitems.removeAll()

            print("Get student records")
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                //iterating through all the values
                for student in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let studentObject = student.value as? [String: AnyObject]
                    let id  = studentObject?["id"] as! String
                    
                    let itemName  = studentObject?["itemName"] as! String
                    let itemType = studentObject?["itemType"] as! String
                    let itemquantity = studentObject?["itemQuantity"] as! String
                    let itemprice = studentObject?["itemPrice"] as! String
                    let itemimageurl = studentObject?["itemImageUrl"] as! String
                  
                    let models = DataModel(id: id, itemName: itemName, itemType: itemType,itemQuantity: itemquantity,itemPrice: itemprice,itemImageUrl: itemimageurl)
                    
                    self.dataitems.append(models)
                    
                    print(self.dataitems.count)
                    self.tableView.reloadData()
                    
                    

                    
                }
                
            }
        })
        
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
        return dataitems.count
       

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:ItemsTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: textCellIdentifier) as! ItemsTableViewCell
        
        cell.itemLbl?.text = dataitems[indexPath.row].getItemName()
        
        print("hello??????????????????")
        print(self.dataitems.count)
        
        
        //        cell.myImageView?.image = UIImage(data: films[indexPath.row].getPosterImage() as! Data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
                let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "itemDetails") as! ItemDetailsViewController
                nextViewController.index = indexPath.row
                nextViewController.list = self.dataitems
        //
                navigationController?.pushViewController(nextViewController, animated: true)
        print("hello click")
        print(dataitems[indexPath.row].getItemName())
        //        
    }
    
    
    func fetchData() {
        countObjs.removeAll()

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
            
                
                countObjs.append((m as! Cart).itemid!)
                
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
