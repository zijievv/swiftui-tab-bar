//
//  TabBarFillStyleEnvironmentKey.swift
//
//
//  Created by Zijie on 18.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

struct TabBarFillStyleEnvironmentKey: EnvironmentKey {
    static var defaultValue: FillStyle = .init()
}

extension EnvironmentValues {
    var tabBarFillStyle: FillStyle {
        get { self[TabBarFillStyleEnvironmentKey.self] }
        set { self[TabBarFillStyleEnvironmentKey.self] = newValue }
    }
}
