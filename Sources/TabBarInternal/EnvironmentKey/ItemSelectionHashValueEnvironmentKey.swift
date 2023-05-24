//
//  ItemSelectionHashValueEnvironmentKey.swift
//
//
//  Created by Zijie on 20.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

struct ItemSelectionHashValueEnvironmentKey: EnvironmentKey {
    static var defaultValue: Int? { nil }
}

extension EnvironmentValues {
    public var tabItemSelectionHashValue: Int? {
        get { self[ItemSelectionHashValueEnvironmentKey.self] }
        set { self[ItemSelectionHashValueEnvironmentKey.self] = newValue }
    }
}
