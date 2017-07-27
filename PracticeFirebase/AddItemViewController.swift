//
//  AddItemViewController.swift
//  PracticeFirebase
//
//  Created by Ramandeep Singh on 2017-07-19.
//  Copyright © 2017 Ramandeep Singh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AddItemViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var itemNameTf: UITextField!
    
    @IBOutlet weak var itemTypeTf: UITextField!
    
    @IBOutlet weak var quantityTf: UITextField!
    
    
    @IBOutlet weak var priceTf: UITextField!
    
    
    @IBOutlet weak var imageurlTf: UITextField!
    
 var refStudent: DatabaseReference!
    
     let Imagepicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Imagepicker.delegate = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
       

        refStudent = Database.database().reference().child("items");
        
        // Do any additional setup after loading the view.
        //updateStudent()
        //deleteStudent(id: "-KomaHnqStBFhCgAE9i1")
         //getStudentRecords()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func insertData(_ sender: UIButton) {
        
        addStudent()
    }
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        Imagepicker.allowsEditing = false
        Imagepicker.sourceType = .photoLibrary
        Imagepicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        Imagepicker.modalPresentationStyle = .popover
        present(Imagepicker, animated: true, completion: nil)
        
        
        
        // Your action
    }
    
    func addStudent(){
        //generating a new key inside artists node
        //and also getting the generated key
        let key = refStudent.childByAutoId().key
        
        //creating artist with the given values
        let student = ["id":key,
                       "itemName": itemNameTf.text!,
                       "itemType": itemTypeTf.text!,
                       "itemQuantity": quantityTf.text!,
                       "itemPrice": priceTf.text!,
                       "itemImageUrl": "https://firebasestorage.googleapis.com/v0/b/assignmentios-c7298.appspot.com/o/fan.png?alt=media&token=72a80fee-25ad-4676-95d8-8045a67a293c"
                       
            
        ]
        
        //adding the artist inside the generated unique key
        refStudent.child(key).setValue(student)
        
        //displaying message
        print("Item Added")
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        imageView.contentMode = .scaleAspectFit //3
        imageView.image = chosenImage //4
        dismiss(animated:true, completion: nil) //5
        
        let imageData = UIImageJPEGRepresentation(imageView.image!, 1)
        //        i.setValue(imageData as NSObject?, forKey: "movieImage")
        
        
    }
    
    func getStudentRecords()
    {
        //observing the data changes
        refStudent.observe(DataEventType.value, with: { (snapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                //iterating through all the values
                for student in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let studentObject = student.value as? [String: AnyObject]
                    let id  = studentObject?["id"]
                    let studentId  = studentObject?["sid"]
                    let studentFName  = studentObject?["itemName"]
                    let studentLName = studentObject?["itemType"]
                    let itemquantity = studentObject?["itemQuantity"]
                    let itemprice = studentObject?["itemPrice"]
                    let itemimageurl = studentObject?["itemImageUrl"]
//                    print("\(id) -- \(studentId) -- \(studentFName) -- \(studentLName)")
                }
                
            }
        })
    }
    
    func updateStudent(){
        //generating a new key inside artists node
        //and also getting the generated key
        let key = "-KomaHnqStBFhCgAE9i1"
        //creating artist with the given values
        let student = ["id":key,
                       "sid":"1",
                       "firstName": "Updated",
                       "lastName": "Patel"
        ]
        
        //adding the artist inside the generated unique key
        refStudent.child(key).setValue(student)
        
        //displaying message
        print("Student Updated")
    }
    
    func deleteStudent(id:String){
        refStudent.child(id).setValue(nil)
        
        //displaying message
        print("Student Deleted")
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
