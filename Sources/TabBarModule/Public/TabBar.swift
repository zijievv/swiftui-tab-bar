//
//  TabBar.swift
//
//
//  Created by Zijie on 18.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

public struct TabBar<Selection, Content>: View where Selection: Hashable, Content: View {
    @Environment(\.tabBarAnimationBuilder) private var animationBuilder
    @Environment(\.tabBarItemsAlignment) private var itemsAlignment
    @Environment(\.tabBarTransition) private var barTransition
    @Environment(\.tabBarShapeStyle) private var shapeStyle
    @Environment(\.tabBarFillStyle) private var fillStyle
    @Environment(\.tabBarSpacing) private var barSpacing
    @Environment(\.tabBarMargins) private var barMargins
    @Environment(\.tabBarPadding) private var barPadding
    @Environment(\.tabBarShadow) private var barShadow
    @Environment(\.tabBarShape) private var barShape
    @State private var items: [Selection] = []
    @State private var tabItemBuilders: [Selection: AnyItemViewBuilder<Selection>] = [:]
    @State private var width: CGFloat = 0
    @Binding private var selection: Selection
    @Binding private var visibility: Visibility
    @StateObject private var keyboardObserver: KeyboardObserver = .shared
    private let content: () -> Content

    public init(
        selection: Binding<Selection>,
        visibility: Binding<Visibility> = .constant(.automatic),
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._selection = selection
        self._visibility = visibility
        self.content = content
    }

    public var body: some View {
        ZStack(content: content)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .safeAreaInset(edge: .bottom, alignment: .center, spacing: barSpacing, content: tabBar)
            .mesurementSize(of: \.width, to: TabBarViewWidthPreferenceKey.self)
            .onPreferenceChange(TabBarViewWidthPreferenceKey.self) { self.width = $0 }
            .onPreferenceChange(ItemsPreferenceKey<Selection>.self) { self.items = $0 }
            .onPreferenceChange(ItemViewBuilderPreferenceKey<Selection>.self) { self.tabItemBuilders = $0 }
            .environment(\.tabItemSelectionHashValue, selection.hashValue)
            .animation(animationBuilder(isVisible), value: isVisible)
    }

    @ViewBuilder
    private func tabBar() -> some View {
        Group {
            if isVisible {
                HStack(alignment: itemsAlignment, spacing: 0) {
                    ForEach(items, id: \.hashValue, content: tab(item:))
                }
                .padding(margins)
                .background(alignment: .top) { GeometryReader(content: backgroundBoard(with:)) }
                .padding(padding)
                .transition(barTransition)
            }
        }
        .mesurementSize(of: \.height, to: TabBarHeightPreferenceKey.self)
    }

    @ViewBuilder
    private func tab(item: Selection) -> some View {
        if let builder = tabItemBuilders[item]?.content {
            builder()
                .contentShape(Rectangle())
                .onTapGesture { selection = item }
                .frame(width: itemWidth)
        }
    }

    private func backgroundBoard(with geo: GeometryProxy) -> some View {
        let filledShape = mainBarShape.fill(shapeStyle, style: fillStyle)
        return AnyView(filledShape)
            .frame(height: isDefaultShape ? geo.size.height + geo.safeAreaInsets.bottom : geo.size.height)
            .shadow(color: barShadow.color, radius: barShadow.radius, x: barShadow.x, y: barShadow.y)
    }

    private var mainBarShape: any Shape { barShape ?? Rectangle() }
    private var isDefaultShape: Bool { barShape == nil }
    private var margins: EdgeInsets { barMargins ?? .init(top: 8, leading: 0, bottom: 8, trailing: 0) }

    private var padding: EdgeInsets {
        guard !isDefaultShape else { return .init(top: barPadding?.top ?? 0, leading: 0, bottom: 0, trailing: 0) }
        return barPadding ?? .init(top: 0, leading: 0, bottom: 0, trailing: 0)
    }

    private var itemWidth: CGFloat {
        (width - padding.leading - padding.trailing - margins.leading - margins.trailing) / CGFloat(items.count)
    }

    private var isVisible: Bool {
        switch visibility {
        case .automatic:
            return !keyboardObserver.keyboardWillShow
        case .visible:
            return true
        case .hidden:
            return false
        }
    }
}
