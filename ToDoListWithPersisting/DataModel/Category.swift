//
//  Category.swift
//  ToDoListWithPersisting
//
//  Created by Elena Kulakova on 2019-12-09.
//  Copyright © 2019 Elena Kulakova. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
