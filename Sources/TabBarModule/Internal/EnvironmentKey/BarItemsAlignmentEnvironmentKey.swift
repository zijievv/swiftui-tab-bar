//
//  BarItemsAlignmentEnvironmentKey.swift
//
//
//  Created by Zijie on 09.06.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

struct BarItemsAlignmentEnvironmentKey: EnvironmentKey {
    static var defaultValue: VerticalAlignment { .center }
}

extension EnvironmentValues {
    var tabBarItemsAlignment: VerticalAlignment {
        get { self[BarItemsAlignmentEnvironmentKey.self] }
        set { self[BarItemsAlignmentEnvironmentKey.self] = newValue }
    }
}
