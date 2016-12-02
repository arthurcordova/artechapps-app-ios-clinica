//
//  NovoAgendamento.swift
//  BeautyClinic
//
//  Created by Arthur on 30/11/16.
//  Copyright © 2016 Matheus Nonaka. All rights reserved.
//

import UIKit

class NovoAgendamento: UIViewController {

    @IBOutlet var card: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //card.layer.cornerRadius = 5
        card.layer.shadowColor = UIColor.blackColor().CGColor
        card.layer.shadowOffset = CGSizeZero
        card.layer.shadowOpacity = 0.5
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
