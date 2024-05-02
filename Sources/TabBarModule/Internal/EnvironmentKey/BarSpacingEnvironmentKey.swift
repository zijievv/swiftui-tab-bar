//
//  BarSpacingEnvironmentKey.swift
//
//
//  Created by Zijie on 18.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

struct BarSpacingEnvironmentKey: EnvironmentKey {
    static var defaultValue: CGFloat? { nil }
}

extension EnvironmentValues {
    var tabBarSpacing: CGFloat? {
        get { self[BarSpacingEnvironmentKey.self] }
        set { self[BarSpacingEnvironmentKey.self] = newValue }
    }
}
