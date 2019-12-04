//
//  Item.swift
//  ToDoListWithPersisting
//
//  Created by Elena Kulakova on 2019-12-03.
//  Copyright © 2019 Elena Kulakova. All rights reserved.
//

import Foundation

class Item: Encodable {
    var title: String = ""
    var done: Bool = false
}
