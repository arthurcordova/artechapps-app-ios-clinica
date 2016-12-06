//
//  Dashboard.swift
//  BeautyClinic
//
//  Created by Arthur on 05/12/16.
//  Copyright © 2016 Matheus Nonaka. All rights reserved.
//

import UIKit

class Dashboard: UIViewController {
    
    @IBOutlet var card1: UIView!
    @IBOutlet var card2: UIView!
    @IBOutlet var card3: UIView!
    @IBOutlet var card4: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        card1.layer.cornerRadius = 5
        
        card2.layer.cornerRadius = 5
        
        card3.layer.cornerRadius = 5
        
        card4.layer.cornerRadius = 5
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
