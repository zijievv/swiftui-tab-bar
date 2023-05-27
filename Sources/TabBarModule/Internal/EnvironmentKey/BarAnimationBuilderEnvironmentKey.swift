//
//  BarAnimationBuilderEnvironmentKey.swift
//
//
//  Created by Zijie on 23.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

struct BarAnimationBuilderEnvironmentKey: EnvironmentKey {
    static var defaultValue: (Bool) -> Animation? { { _ in .none } }
}

extension EnvironmentValues {
    var tabBarAnimationBuilder: (Bool) -> Animation? {
        get { self[BarAnimationBuilderEnvironmentKey.self] }
        set { self[BarAnimationBuilderEnvironmentKey.self] = newValue }
    }
}
