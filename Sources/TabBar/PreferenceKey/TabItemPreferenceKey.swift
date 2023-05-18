//
//  TabItemPreferenceKey.swift
//
//
//  Created by Zijie on 18.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

struct TabItemPreferenceKey<Selection: Hashable>: PreferenceKey {
    static var defaultValue: [Selection] { [] }
    static func reduce(value: inout [Selection], nextValue: () -> [Selection]) {
        value.append(contentsOf: nextValue())
    }
}
