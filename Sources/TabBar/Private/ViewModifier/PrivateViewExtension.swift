//
//  PrivateViewExtension.swift
//
//
//  Created by Zijie on 18.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<V: View>(_ predicate: @autoclosure () -> Bool, modifier: @escaping (Self) -> V) -> some View {
        if predicate() {
            modifier(self)
        } else {
            self
        }
    }

    func mesurementSize<Key: PreferenceKey>(
        of path: KeyPath<CGSize, CGFloat>,
        to key: Key.Type
    ) -> some View where Key.Value == CGFloat {
        modifier(SizeMesurementViewModifier(path: path, key: key))
    }
}
