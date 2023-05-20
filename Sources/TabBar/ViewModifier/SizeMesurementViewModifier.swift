//
//  SizeMesurementViewModifier.swift
//
//
//  Created by Zijie on 18.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

struct SizeMesurementViewModifier<Key: PreferenceKey>: ViewModifier where Key.Value == CGFloat {
    let path: KeyPath<CGSize, CGFloat>
    let key: Key.Type

    func body(content: Content) -> some View {
        content
            .background {
                GeometryReader { geo in
                    Color.clear.preference(key: key, value: geo.size[keyPath: path])
                }
            }
    }
}

extension View {
    func mesurementSize<Key: PreferenceKey>(
        of path: KeyPath<CGSize, CGFloat>,
        to key: Key.Type
    ) -> some View where Key.Value == CGFloat {
        modifier(SizeMesurementViewModifier(path: path, key: key))
    }
}

struct TabBarViewWidthPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}
