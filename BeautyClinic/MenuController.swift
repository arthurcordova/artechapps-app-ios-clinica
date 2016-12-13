//
//  MenuController.swift
//  BeautyClinic
//
//  Created by Arthur on 12/12/16.
//  Copyright © 2016 Matheus Nonaka. All rights reserved.
//

import UIKit


class ContainerViewController: SlideMenuController {
    
    override func awakeFromNib() {
        if let controller = self.storyboard?.instantiateViewControllerWithIdentifier("Main") {
            self.mainViewController = controller
        }
        if let controller = self.storyboard?.instantiateViewControllerWithIdentifier("Left") {
            self.leftViewController = controller
        }
        super.awakeFromNib()
    }
    
}
