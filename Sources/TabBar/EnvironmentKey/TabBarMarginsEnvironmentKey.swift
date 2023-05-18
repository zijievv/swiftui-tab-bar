//
//  TabBarMarginsEnvironmentKey.swift
//
//
//  Created by Zijie on 18.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

struct TabBarMarginsEnvironmentKey: EnvironmentKey {
    static var defaultValue: EdgeInsets { .init(top: 8, leading: 0, bottom: 8, trailing: 0) }
}

extension EnvironmentValues {
    var tabBarMargins: EdgeInsets {
        get { self[TabBarMarginsEnvironmentKey.self] }
        set { self[TabBarMarginsEnvironmentKey.self] = newValue }
    }
}

extension View {
    public func tabBarMargins(
        top: CGFloat? = nil,
        leading: CGFloat? = nil,
        bottom: CGFloat? = nil,
        trailing: CGFloat? = nil
    ) -> some View {
        environment(
            \.tabBarMargins,
            .init(top: top ?? 8, leading: leading ?? 0, bottom: bottom ?? 8, trailing: trailing ?? 0)
        )
    }

    public func tabBarMargins(_ edgeInsets: EdgeInsets) -> some View {
        environment(\.tabBarMargins, edgeInsets)
    }
}
