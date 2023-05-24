//
//  TabItemViewModifier.swift
//
//
//  Created by Zijie on 18.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

public struct TabItemViewModifier<Selection: Hashable, V: View>: ViewModifier {
    @Environment(\.tabItemSelectionHashValue) private var selectionHashValue
    private let item: Selection
    @ViewBuilder private let itemBuilder: () -> V

    public init(item: Selection, @ViewBuilder itemBuilder: @escaping () -> V) {
        self.item = item
        self.itemBuilder = itemBuilder
    }

    public func body(content: Content) -> some View {
        Group {
            if selectionHashValue == item.hashValue {
                content
            } else {
                Color.clear
            }
        }
        .preference(key: ItemsPreferenceKey.self, value: [item])
        .preference(
            key: ItemViewBuilderPreferenceKey.self,
            value: [
                item: AnyItemViewBuilder(
                    selectedItemHashValue: selectionHashValue,
                    item: item,
                    content: { AnyView(VStack(spacing: 0, content: itemBuilder)) }
                )
            ]
        )
    }
}
