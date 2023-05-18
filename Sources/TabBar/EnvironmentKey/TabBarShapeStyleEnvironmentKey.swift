//
//  TabBarShapeStyleEnvironmentKey.swift
//
//
//  Created by Zijie on 18.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

struct TabBarShapeStyleEnvironmentKey: EnvironmentKey {
    static var defaultValue: AnyShapeStyle = .init(Material.bar)
}

extension EnvironmentValues {
    var tabBarShapeStyle: AnyShapeStyle {
        get { self[TabBarShapeStyleEnvironmentKey.self] }
        set { self[TabBarShapeStyleEnvironmentKey.self] = newValue }
    }
}

extension View {
    public func tabBarFill<S: ShapeStyle>(_ content: S, style: FillStyle = .init()) -> some View {
        self
            .environment(\.tabBarShapeStyle, .init(AnyShapeStyle(content)))
            .environment(\.tabBarFillStyle, style)
    }
}
