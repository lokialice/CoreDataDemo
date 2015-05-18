//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Macbook Pro MD102 on 5/11/15.
//  Copyright (c) 2015 Macbook Pro MD102. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    
    @IBOutlet var txtUserName: UITextField!
    @IBOutlet var txtPassword: UITextField!
    
    @IBAction func btnSave(sender: UIButton) {
       println("Save Button Pressed \(txtUserName.text)")
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        var newUser: AnyObject = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: context)
        newUser.setValue(txtUserName.text, forKey: "username")
        newUser.setValue(txtPassword.text, forKey: "password")
        
        context.save(nil)
        
        println(newUser)
        println("Object Save")
        
    }
    
    @IBAction func btnLoad(sender: UIButton) {
        println("Load Button Pressed \(txtPassword.text)")
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext!
       var request = NSFetchRequest(entityName: "User")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "username = %@","" + txtUserName.text)
        
        var result:NSArray = context.executeFetchRequest(request, error: nil)!

        if(result.count > 0){
            var res: AnyObject = result[0] as AnyObject
            txtUserName.text = res.valueForKey("username") as! String
            txtPassword.text = res.valueForKey("password") as! String
            
            
//            for res in result{
//                println(res)
//            }
        }else {
            println("0 Result Returned...Potenial error")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

