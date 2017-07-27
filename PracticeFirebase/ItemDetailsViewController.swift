//
//  ItemDetailsViewController.swift
//  PracticeFirebase
//
//  Created by Ramandeep Singh on 2017-07-20.
//  Copyright © 2017 Ramandeep Singh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import CoreData

class ItemDetailsViewController: UIViewController,UITabBarControllerDelegate  {

    @IBOutlet weak var itemType: UILabel!
    @IBOutlet weak var itemName: UILabel!
    var refStudent: DatabaseReference!
    var countObjs: [String] = []
    
    @IBOutlet weak var itemQuantitylbl: UILabel!
    var id = ""
    var itemTypestr = ""
    var itemNamestr = ""
    var itemQuantitystr = ""
    var itemPricestr = ""
    var itemImageUrlstr = ""
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var itemPriceLbl: UILabel!
    
    
     var users:[NSManagedObject] = []
    var index = 0
    var list: [DataModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
         self.tabBarController?.delegate = self
  
        self.itemName.text = list[index].getItemName()
        self.itemType.text = list[index].getItemType()
        itemNamestr = list[index].getItemName()
        itemTypestr = list[index].getItemType()
        id = list[index].getId()
        itemPricestr = list[index].getItePrice()
        itemQuantitystr = list[index].getItemQuantity()
        itemImageUrlstr = list[index].getItemImage()
        
        self.itemQuantitylbl.text = itemQuantitystr
        self.itemPriceLbl.text = itemPricestr
        let url =  URL(string: itemImageUrlstr)!
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
               self.imageView?.image = UIImage(data: data)
                
            }
            
        }

        
        

               // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    
    

    
    @IBAction func addToCart(_ sender: UIButton) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Cart",
                                       in: managedContext)!
        
        let user = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
        
        // 3
        user.setValue(id, forKeyPath: "itemid")
        user.setValue(itemNamestr, forKeyPath: "itemname")
        user.setValue(itemTypestr, forKeyPath: "itemtype")
        user.setValue(itemQuantitystr, forKeyPath: "itemQuantity")
        user.setValue(itemPricestr, forKeyPath: "itemPrice")
        user.setValue(itemImageUrlstr, forKeyPath: "itemImageUrl")
        

        
        // 4
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        ////////////////////////////////////////////
        countObjs.removeAll()
        fetchData()
        tabBarController?.tabBar.items![1].badgeValue = String(countObjs.count)
        
        
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
