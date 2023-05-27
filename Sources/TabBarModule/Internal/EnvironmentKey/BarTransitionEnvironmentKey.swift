//
//  BarTransitionEnvironmentKey.swift
//
//
//  Created by Zijie on 23.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

struct BarTransitionEnvironmentKey: EnvironmentKey {
    static var defaultValue: AnyTransition { .identity }
}

extension EnvironmentValues {
    var tabBarTransition: AnyTransition {
        get { self[BarTransitionEnvironmentKey.self] }
        set { self[BarTransitionEnvironmentKey.self] = newValue }
    }
}
