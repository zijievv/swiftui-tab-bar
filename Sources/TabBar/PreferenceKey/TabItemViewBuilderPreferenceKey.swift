//
//  TabItemViewBuilderPreferenceKey.swift
//
//
//  Created by Zijie on 18.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

struct TabItemViewBuilderPreferenceKey<Selection: Hashable>: PreferenceKey {
    static var defaultValue: [Selection: BuilderWrapper] { [:] }
    static func reduce(value: inout [Selection: BuilderWrapper], nextValue: () -> [Selection: BuilderWrapper]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }

    struct BuilderWrapper: Equatable {
        let id = UUID()
        let content: () -> AnyView

        static func == (
            lhs: TabItemViewBuilderPreferenceKey<Selection>.BuilderWrapper,
            rhs: TabItemViewBuilderPreferenceKey<Selection>.BuilderWrapper
        ) -> Bool {
            lhs.id == rhs.id
        }
    }
}
