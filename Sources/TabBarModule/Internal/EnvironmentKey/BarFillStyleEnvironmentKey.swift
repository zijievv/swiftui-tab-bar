//
//  BarFillStyleEnvironmentKey.swift
//
//
//  Created by Zijie on 18.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

struct BarFillStyleEnvironmentKey: EnvironmentKey {
    static var defaultValue: FillStyle { .init() }
}

extension EnvironmentValues {
    var tabBarFillStyle: FillStyle {
        get { self[BarFillStyleEnvironmentKey.self] }
        set { self[BarFillStyleEnvironmentKey.self] = newValue }
    }
}
