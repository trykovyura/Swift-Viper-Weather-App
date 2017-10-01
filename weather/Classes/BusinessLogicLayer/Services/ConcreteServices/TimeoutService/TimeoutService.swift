//
// Created by Юрий Трыков on 26.08.17.
// Copyright (c) 2017 trykov. All rights reserved.
//

import Foundation

public protocol TimeoutService {

    func startTimer(_ output: TimeoutServiceOutput?)

    func stopTimer()
}

public protocol TimeoutServiceOutput {

    func didTriggerTimer()

}

class TimeoutServiceImpl: TimeoutService {

    let defaultTimeout = 30.0

    var timer = Timer()

    func startTimer(_ output: TimeoutServiceOutput?) {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: defaultTimeout, repeats: true) {
            timer in
            output?.didTriggerTimer()
        }
    }

    func stopTimer() {
        timer.invalidate()
    }
}