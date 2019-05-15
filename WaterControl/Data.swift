//
//  Data.swift
//  WaterControl
//
//  Created by Владимир on 15.05.2019.
//  Copyright © 2019 Siporoz. All rights reserved.
//

import Foundation

class Singletonn {
    
    static let shared = Singletonn()
    var number = UserDefaults.standard.integer(forKey: "Progress")
    
    func saveData(){
        
        UserDefaults.standard.set(number, forKey: "Progress")
        UserDefaults.standard.synchronize()
        
        
    }
    
    func loadData(){
        UserDefaults.standard.integer(forKey: "Progress")
        number = UserDefaults.standard.integer(forKey: "Progress")
    }
}
