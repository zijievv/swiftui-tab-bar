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

public struct SizeMesurementViewModifier<Key: PreferenceKey>: ViewModifier where Key.Value == CGFloat {
    let path: KeyPath<CGSize, CGFloat>
    let key: Key.Type

    public func body(content: Content) -> some View {
        content
            .background {
                GeometryReader { geo in
                    Color.clear.preference(key: key, value: geo.size[keyPath: path])
                }
            }
    }
}
