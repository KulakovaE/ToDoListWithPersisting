//
//  Item.swift
//  ToDoListWithPersisting
//
//  Created by Elena Kulakova on 2019-12-09.
//  Copyright © 2019 Elena Kulakova. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
