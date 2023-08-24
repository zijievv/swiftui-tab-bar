//
//  View+Extension.swift
//
//
//  Created by Zijie on 20.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

public typealias ActionWillSelect = () -> Void

extension View {
    public func tabItem<Selection: Hashable, V: View>(
        _ selection: Selection,
        @ViewBuilder label: @escaping () -> V,
        actionWillSelect: ActionWillSelect? = nil
    ) -> some View {
        modifier(TabItemViewModifier(item: selection, itemBuilder: label, actionWillSelect: actionWillSelect))
    }

    public func tabBarFill<S: ShapeStyle>(_ content: S, style: FillStyle = .init()) -> some View {
        self.environment(\.tabBarShapeStyle, .init(AnyShapeStyle(content)))
            .environment(\.tabBarFillStyle, style)
    }

    public func tabBarForeground<V: View>(_ content: @escaping () -> V) -> some View {
        environment(\.tabBarForegroundViewBuilder, { AnyView(content()) })
    }

    public func tabBarShape(_ shape: any Shape) -> some View {
        environment(\.tabBarShape, shape)
    }

    public func tabBarShadow(
        color: Color = .init(.sRGBLinear, white: 0, opacity: 0.33),
        radius: CGFloat,
        x: CGFloat = 0,
        y: CGFloat = 0
    ) -> some View {
        environment(\.tabBarShadow, .init(color: color, radius: radius, x: x, y: y))
    }

    public func tabBarAnimation(_ builder: @escaping (_ isTabBarVisible: Bool) -> Animation?) -> some View {
        environment(\.tabBarAnimationBuilder, builder)
    }

    public func tabBarTransition(_ t: AnyTransition) -> some View {
        environment(\.tabBarTransition, t)
    }

    /// Sets extra distance placed between the TabBar and the content view,
    /// or `nil` to use the default amount of spacing.
    public func tabBarSpacing(_ spacing: CGFloat? = nil) -> some View {
        environment(\.tabBarSpacing, spacing)
    }

    public func tabBarPadding(_ edges: Edge.Set = .all, _ length: CGFloat? = nil) -> some View {
        modifier(EdgeSetEdgeInsetsViewModifier(keyPath: \.tabBarPadding, edges: edges, length: length))
    }

    public func tabBarPadding(_ edgeInsets: EdgeInsets) -> some View {
        modifier(EdgeInsetsViewModifier(keyPath: \.tabBarPadding, edgeInsets: edgeInsets))
    }

    public func tabBarMargins(_ edges: Edge.Set = .all, _ length: CGFloat? = nil) -> some View {
        modifier(EdgeSetEdgeInsetsViewModifier(keyPath: \.tabBarMargins, edges: edges, length: length))
    }

    public func tabBarMargins(_ edgeInsets: EdgeInsets) -> some View {
        modifier(EdgeInsetsViewModifier(keyPath: \.tabBarMargins, edgeInsets: edgeInsets))
    }

    public func tabBarItemsAlignment(_ alignment: VerticalAlignment) -> some View {
        environment(\.tabBarItemsAlignment, alignment)
    }
}
