//
//  ItemsPreferenceKey.swift
//
//
//  Created by Zijie on 18.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

public struct ItemsPreferenceKey<Selection: Hashable>: PreferenceKey {
    public static var defaultValue: [Selection] { [] }

    public static func reduce(value: inout [Selection], nextValue: () -> [Selection]) {
        value.append(contentsOf: nextValue())
    }
}
