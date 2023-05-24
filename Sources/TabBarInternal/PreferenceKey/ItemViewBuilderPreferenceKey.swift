//
//  ItemViewBuilderPreferenceKey.swift
//
//
//  Created by Zijie on 18.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

public struct ItemViewBuilderPreferenceKey<Selection: Hashable>: PreferenceKey {
    public static var defaultValue: [Selection: AnyItemViewBuilder<Selection>] { [:] }

    public static func reduce(
        value: inout [Selection: AnyItemViewBuilder<Selection>],
        nextValue: () -> [Selection: AnyItemViewBuilder<Selection>]
    ) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

public struct AnyItemViewBuilder<Selection: Hashable>: Hashable, Equatable {
    public let selectedItemHashValue: Int?
    public let item: Selection
    public let content: () -> AnyView

    public func hash(into hasher: inout Hasher) {
        hasher.combine(selectedItemHashValue)
        hasher.combine(item)
    }

    public static func == (lhs: AnyItemViewBuilder, rhs: AnyItemViewBuilder) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
