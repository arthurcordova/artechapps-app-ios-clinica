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
    @IBOutlet var tvProcedimento: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //card.layer.cornerRadius = 5
        card.layer.shadowColor = UIColor.blackColor().CGColor
        card.layer.shadowOffset = CGSizeZero
        card.layer.shadowOpacity = 0.5
        // Do any additional setup after loading the view.
        
        textFieldDidBeginEditing(tvProcedimento)
        
        
        
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        print("TextField did begin editing method called")
    }
    func textFieldDidEndEditing(textField: UITextField) {
        print("TextField did end editing method called")
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        print("TextField should begin editing method called")
        return true;
    }
    func textFieldShouldClear(textField: UITextField) -> Bool {
        print("TextField should clear method called")
        return true;
    }
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        print("TextField should snd editing method called")
        return true;
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        print("While entering the characters this method gets called")
        return true;
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("TextField should return method called")
        textField.resignFirstResponder();
        return true;
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
