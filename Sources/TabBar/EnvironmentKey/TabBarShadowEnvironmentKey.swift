//
//  TabBarShadowEnvironmentKey.swift
//
//
//  Created by Zijie on 18.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

struct TabBarShadowEnvironmentKey: EnvironmentKey {
    static var defaultValue: Shadow = .init(color: .clear, radius: 0, x: 0, y: 0)

    struct Shadow {
        let color: Color
        let radius: CGFloat
        let x: CGFloat
        let y: CGFloat
    }
}

extension EnvironmentValues {
    var tabBarShadow: TabBarShadowEnvironmentKey.Shadow {
        get { self[TabBarShadowEnvironmentKey.self] }
        set { self[TabBarShadowEnvironmentKey.self] = newValue }
    }
}

extension View {
    public func tabBarShadow(
        color: Color = .init(.sRGBLinear, white: 0, opacity: 0.33),
        radius: CGFloat,
        x: CGFloat = 0,
        y: CGFloat = 0
    ) -> some View {
        environment(\.tabBarShadow, .init(color: color, radius: radius, x: x, y: y))
    }
}
