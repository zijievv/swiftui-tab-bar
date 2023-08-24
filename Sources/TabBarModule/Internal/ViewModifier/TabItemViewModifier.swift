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

struct TabItemViewModifier<Selection: Hashable, V: View>: ViewModifier {
    @Environment(\.tabItemSelectionHashValue) private var selectionHashValue
    private let item: Selection
    @ViewBuilder private let itemBuilder: () -> V
    private let actionWillSelect: ActionWillSelect?

    init(item: Selection, @ViewBuilder itemBuilder: @escaping () -> V, actionWillSelect: ActionWillSelect?) {
        self.item = item
        self.itemBuilder = itemBuilder
        self.actionWillSelect = actionWillSelect
    }

    func body(content: Content) -> some View {
        content
            .opacity(selectionHashValue == item.hashValue ? 1 : 0)
            .disabled(!(selectionHashValue == item.hashValue))
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
            .preference(
                key: ItemActionWillSelectPreferenceKey.self,
                value: [
                    item: TabItemAction(selectedItemHashValue: selectionHashValue, item: item, action: actionWillSelect)
                ]
            )
    }
}
