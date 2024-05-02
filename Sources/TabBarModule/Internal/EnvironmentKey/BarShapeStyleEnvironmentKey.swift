//
//  BarShapeStyleEnvironmentKey.swift
//
//
//  Created by Zijie on 18.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

struct BarShapeStyleEnvironmentKey: EnvironmentKey {
    static var defaultValue: AnyShapeStyle { .init(Material.bar) }
}

extension EnvironmentValues {
    var tabBarShapeStyle: AnyShapeStyle {
        get { self[BarShapeStyleEnvironmentKey.self] }
        set { self[BarShapeStyleEnvironmentKey.self] = newValue }
    }
}
