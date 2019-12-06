//
//  Data.swift
//  ToDoListWithPersisting
//
//  Created by Elena Kulakova on 2019-12-06.
//  Copyright © 2019 Elena Kulakova. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}
