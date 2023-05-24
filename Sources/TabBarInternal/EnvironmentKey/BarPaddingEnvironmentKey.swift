//
//  BarPaddingEnvironmentKey.swift
//
//
//  Created by Zijie on 18.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

struct BarPaddingEnvironmentKey: EnvironmentKey {
    static var defaultValue: EdgeInsets? { nil }
}

extension EnvironmentValues {
    public var tabBarPadding: EdgeInsets? {
        get { self[BarPaddingEnvironmentKey.self] }
        set { self[BarPaddingEnvironmentKey.self] = newValue }
    }
}
