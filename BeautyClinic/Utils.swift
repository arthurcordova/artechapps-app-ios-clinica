//
//  Utils.swift
//  BeautyClinic
//
//  Created by Matheus Nonaka on 7/1/15.
//  Copyright (c) 2015 Matheus Nonaka. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    
    func hour() -> Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Hour, fromDate: NSDate())
        let hour = components.hour

        return hour
    }
    
    
    func minute() -> Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Minute, fromDate: NSDate())
        let minute = components.minute
        
        return minute
    }
    
    func day() -> Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Day, fromDate: NSDate())
        let day = components.day
        
        return day
    }
    
    func month() -> Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Month, fromDate: NSDate())
        let month = components.month
        
        return month
    }
    
}