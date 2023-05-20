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

struct ItemViewBuilderPreferenceKey<Selection: Hashable>: PreferenceKey {
    static var defaultValue: [Selection: AnyItemViewBuilder<Selection>] { [:] }
    static func reduce(
        value: inout [Selection: AnyItemViewBuilder<Selection>],
        nextValue: () -> [Selection: AnyItemViewBuilder<Selection>]
    ) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

struct AnyItemViewBuilder<Selection: Hashable>: Hashable, Equatable {
    let selectedItemHashValue: Int?
    let item: Selection
    let content: () -> AnyView

    func hash(into hasher: inout Hasher) {
        hasher.combine(selectedItemHashValue)
        hasher.combine(item)
    }

    static func == (lhs: AnyItemViewBuilder, rhs: AnyItemViewBuilder) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
