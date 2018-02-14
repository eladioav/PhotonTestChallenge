//
//  ViewController.swift
//  PathOfLowestCost
//
//  Created by Eladio Alvarez Valle on 2/7/18.
//  Copyright © 2018 Eladio Alvarez Valle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var rows: UITextField!
    @IBOutlet weak var cols: UITextField!
    @IBOutlet weak var values: UITextField!
    @IBOutlet weak var result: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func calculateButtonAction(_ sender: UIButton) {
        
        if let values = self.values.text {
        
            var array : [Int] = []
            var components : [String] = values.components(separatedBy: ",")
            for component in components {
                
                if let componentInt = Int(component) {
                    array.append(componentInt)
                }
            }
            
            if let rows = Int(self.rows.text!), let cols = Int(self.cols.text!){
            
                //Create class
                if let find = PathOfLowestCost(rows: rows, columns: cols, array) {
                    
                    self.result.text = "\(find.findLowestCost())"
                }
                
            }
        }
    }
    
}

