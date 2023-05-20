//
//  TabItemSelectionHashValueEnvironmentKey.swift
//
//
//  Created by Zijie on 20.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

struct TabItemSelectionHashValueEnvironmentKey: EnvironmentKey {
    static var defaultValue: Int? = nil
}

extension EnvironmentValues {
    var tabItemSelectionHashValue: Int? {
        get { self[TabItemSelectionHashValueEnvironmentKey.self] }
        set { self[TabItemSelectionHashValueEnvironmentKey.self] = newValue }
    }
}
