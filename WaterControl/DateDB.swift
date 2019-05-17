//
//  DateDB.swift
//  WaterControl
//
//  Created by Владимир on 16.05.2019.
//  Copyright © 2019 Siporoz. All rights reserved.
//


import Foundation
import RealmSwift

class newData: Object {
    @objc dynamic var countWater: String?
    @objc dynamic var date: String?
}
