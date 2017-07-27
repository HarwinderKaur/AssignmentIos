//
//  MyOrdersViewController.swift
//  PracticeFirebase
//
//  Created by Ramandeep Singh on 2017-07-24.
//  Copyright © 2017 Ramandeep Singh. All rights reserved.
//

import UIKit
import Foundation
import CoreData
import Firebase
import FirebaseDatabase

class MyOrdersViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITabBarControllerDelegate{

    @IBOutlet weak var tableView: UITableView!
   
     var users:[NSManagedObject] = []
    var refStudent: DatabaseReference!
    var items:[DataModel] = []
    let textCellIdentifier = "orderCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate=self
        tableView.dataSource=self
        self.tabBarController?.delegate = self
       
        refStudent = Database.database().reference().child("carts");
        
getStudentRecords()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        items.removeAll()
        getStudentRecords()
        tableView.reloadData()
        tabBarController?.tabBar.items![1].badgeValue = String(items.count)
        
        
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:MyordersTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: textCellIdentifier) as! MyordersTableViewCell
        
        cell.myorders?.text = items[indexPath.row].getItemName()
        
        
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

    
    func getStudentRecords()
    {
        //observing the data changes
        refStudent.observe(DataEventType.value, with: { (snapshot) in
            
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
                    
                    self.items.append(models)
                    
                    print(self.items.count)
                    self.tableView.reloadData()
                    
                    print(itemName)
                    
                    
                    
                    
                    
                }
                
            }
        })
        
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
