//
//  TabBarPaddingEnvironmentKey.swift
//
//
//  Created by Zijie on 18.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

struct TabBarPaddingEnvironmentKey: EnvironmentKey {
    static var defaultValue: EdgeInsets { .init(top: 0, leading: 0, bottom: 0, trailing: 0) }
}

extension EnvironmentValues {
    var tabBarPadding: EdgeInsets {
        get { self[TabBarPaddingEnvironmentKey.self] }
        set { self[TabBarPaddingEnvironmentKey.self] = newValue }
    }
}

extension View {
    public func tabBarPadding(
        top: CGFloat? = nil,
        leading: CGFloat? = nil,
        bottom: CGFloat? = nil,
        trailing: CGFloat? = nil
    ) -> some View {
        environment(
            \.tabBarPadding,
            .init(top: top ?? 0, leading: leading ?? 0, bottom: bottom ?? 0, trailing: trailing ?? 0)
        )
    }

    public func tabBarPadding(horizontal: CGFloat? = nil, vertical: CGFloat? = nil) -> some View {
        environment(
            \.tabBarPadding,
            .init(top: vertical ?? 0, leading: horizontal ?? 0, bottom: vertical ?? 0, trailing: horizontal ?? 0)
        )
    }

    public func tabBarPadding(_ edgeInsets: EdgeInsets) -> some View {
        environment(\.tabBarPadding, edgeInsets)
    }
}
