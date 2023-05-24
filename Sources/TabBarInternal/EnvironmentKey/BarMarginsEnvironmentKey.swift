//
//  BarMarginsEnvironmentKey.swift
//
//
//  Created by Zijie on 18.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

struct BarMarginsEnvironmentKey: EnvironmentKey {
    static var defaultValue: EdgeInsets? { nil }
}

extension EnvironmentValues {
    public var tabBarMargins: EdgeInsets? {
        get { self[BarMarginsEnvironmentKey.self] }
        set { self[BarMarginsEnvironmentKey.self] = newValue }
    }
}
