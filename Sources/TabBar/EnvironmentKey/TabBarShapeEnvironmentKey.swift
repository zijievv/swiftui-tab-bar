//
//  TabBarShapeEnvironmentKey.swift
//
//
//  Created by Zijie on 18.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

struct TabBarShapeEnvironmentKey: EnvironmentKey {
    static var defaultValue: (any Shape)? = nil
}

extension EnvironmentValues {
    var tabBarShape: (any Shape)? {
        get { self[TabBarShapeEnvironmentKey.self] }
        set { self[TabBarShapeEnvironmentKey.self] = newValue }
    }
}

extension View {
    public func tabBarShape(_ shape: any Shape) -> some View {
        environment(\.tabBarShape, shape)
    }
}
