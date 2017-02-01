//
//  MeuCarrinhoController.swift
//  BeautyClinic
//
//  Created by Arthur on 30/01/17.
//  Copyright © 2017 Matheus Nonaka. All rights reserved.
//

import UIKit

class MeuCarrinhoController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var lblValor: UILabel!
    @IBOutlet var tableView: UITableView!
    
    let textForFirstTableView = ["Italian food", "Mexican food", "Croatian food", "Spanish food", "French food"]
    
    let namesOfFood = [["Bolognese", "Milagnese","Pizza"],
                       ["Tortilla", "Chimichanga", "Paella"],
                       ["Burek od mesa","Grah", "Janjetina"],
                       ["Tapas", "Churros", "Flan"],
                       ["Buche de Noel", "Cherry Cake", "Onion Soup"]]
    
    var ObjectNamesOfFood = [String]()
    
    @IBAction func funcBack(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true);
    }
    
    @IBAction func funcFinalizar(sender: AnyObject) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        return textForFirstTableView.count
//        
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
//        
//        cell.textLabel?.text = textForFirstTableView[indexPath.row]
//        
//        return cell
//        
//    }
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        self.ObjectNamesOfFood = self.namesOfFood[indexPath.row]
//        
//        self.performSegueWithIdentifier("Segue", sender: self)
//        
//    }
    
}
