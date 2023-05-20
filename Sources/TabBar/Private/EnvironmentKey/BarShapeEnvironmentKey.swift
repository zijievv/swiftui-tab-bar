//
//  BarShapeEnvironmentKey.swift
//
//
//  Created by Zijie on 18.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

struct BarShapeEnvironmentKey: EnvironmentKey {
    static var defaultValue: (any Shape)? = nil
}

extension EnvironmentValues {
    var tabBarShape: (any Shape)? {
        get { self[BarShapeEnvironmentKey.self] }
        set { self[BarShapeEnvironmentKey.self] = newValue }
    }
}
