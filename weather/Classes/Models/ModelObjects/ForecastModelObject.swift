//
// Created by Юрий Трыков on 27.08.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import Foundation
import RealmSwift

class ForecastModelObject: Object {
    @objc dynamic var name = ""
    @objc dynamic var time = 0
    @objc dynamic var day = ""
    @objc dynamic var created = NSDate()
}
