//
//  BarSpacingEnvironmentKey.swift
//
//
//  Created by Zijie on 18.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

struct BarSpacingEnvironmentKey: EnvironmentKey {
    static var defaultValue: CGFloat? = nil
}

extension EnvironmentValues {
    var tabBarSpacing: CGFloat? {
        get { self[BarSpacingEnvironmentKey.self] }
        set { self[BarSpacingEnvironmentKey.self] = newValue }
    }
}

extension View {
    /// Sets extra distance placed between the TabBar and the content view, or `nil` to use the default amount of spacing.
    public func tabBarSpacing(_ spacing: CGFloat? = nil) -> some View {
        environment(\.tabBarSpacing, spacing)
    }
}
