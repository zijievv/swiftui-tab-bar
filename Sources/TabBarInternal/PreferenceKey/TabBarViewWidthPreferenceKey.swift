//
//  TabBarViewWidthPreferenceKey.swift
//
//
//  Created by Zijie on 20.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

public struct TabBarViewWidthPreferenceKey: PreferenceKey {
    public static var defaultValue: CGFloat = .zero

    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}
