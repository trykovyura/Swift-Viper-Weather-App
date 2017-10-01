//
// Created by Юрий Трыков on 27.08.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import Foundation
import RealmSwift

class ForecastModelObject: Object {
    dynamic var name = ""
    dynamic var time = 0
    dynamic var day = ""
    dynamic var created = NSDate()
}