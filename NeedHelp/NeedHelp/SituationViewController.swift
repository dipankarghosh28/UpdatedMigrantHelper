//
//  SituationViewController.swift
//  NeedHelp
//
//  Created by Dipankar Ghosh on 5/23/18.
//  Copyright © 2018 Dipankar Ghosh. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import CoreLocation
import FirebaseStorage
import FirebaseDatabase
import FirebaseFirestore

class SituationViewController: UIViewController {
    var ref: DatabaseReference?
    var refdb: DatabaseReference?
    let db1 = Firestore.firestore()
    var databaseHandle: DatabaseHandle?
    var postData = [String]()
    
    //MAP
    
    struct globalvariable
    {
        static var myStruct = String()
    }
    
    let manager = CLLocationManager()
    var lat  = ""
    var long = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
