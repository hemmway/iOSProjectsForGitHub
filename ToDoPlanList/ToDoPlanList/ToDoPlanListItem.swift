//
//  ToDoPlanListItem.swift
//  ToDoPlanList
//
//  Created by Ivan Kurhanskyi on 10/30/16.
//  Copyright © 2016 Ivan Kurhanskyi. All rights reserved.
//

import Foundation

class ToDoPlanListItem {
    var text = ""
    var checked = false
    
    
    func toggleChecked() {
        checked = !checked
    }
}
