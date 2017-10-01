//
// Created by Юрий Трыков on 24.08.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import Foundation
import Swinject

final class ApplicationAssembly {

    //Use default dependency
    class var assembler: Assembler {
        return try! Assembler(assemblies: [
            ServiceComponentsAssembly()
        ])
    }

    var assembler: Assembler

    //If you want use custom Assembler
    init(with assemblies: [Assembly]) {
        assembler = try! Assembler(assemblies: assemblies)
    }

}
