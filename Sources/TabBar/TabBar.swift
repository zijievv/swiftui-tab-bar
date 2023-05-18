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
    @Environment(\.tabBarShapeStyle) private var shapeStyle
    @Environment(\.tabBarFillStyle) private var fillStyle
    @Environment(\.tabBarSpacing) private var barSpacing
    @Environment(\.tabBarPadding) private var barPadding
    @Environment(\.tabBarMargins) private var barMargins
    @Environment(\.tabBarShadow) private var barShadow
    @Environment(\.tabBarShape) private var barShape
    @State private var items: [Selection] = []
    @State private var tabItemBuilders: [Selection: TabItemViewBuilderPreferenceKey<Selection>.BuilderWrapper] = [:]
    @State private var barContainerHeight: CGFloat = 0
    @State private var barContainerWidth: CGFloat = 0
    private let selection: TabItemSelection<Selection>
    private let content: Content

    public init(selection: Binding<Selection>, @ViewBuilder content: @escaping () -> Content) {
        self.selection = .init(item: selection)
        self.content = content()
    }

    public var body: some View {
        ZStack {
            content
        }
        .environmentObject(selection)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaInset(edge: .bottom, alignment: .center, spacing: barSpacing, content: mainBar)
        .if(isDefaultBarShape) { $0.overlay(content: safeAreaBar) }
        .onPreferenceChange(TabItemPreferenceKey<Selection>.self) { self.items = $0 }
        .onPreferenceChange(TabItemViewBuilderPreferenceKey<Selection>.self) { self.tabItemBuilders = $0 }
        .onPreferenceChange(TabItemMaxHeightPreferenceKey.self) { self.barContainerHeight = $0 }
        .onPreferenceChange(TabBarContainerWidthPreferenceKey.self) { self.barContainerWidth = $0 }
    }

    private var mainBarShape: any Shape { barShape ?? Rectangle() }
    private var isDefaultBarShape: Bool { barShape == nil }
    private var tabItemWidth: CGFloat { barContainerWidth / CGFloat(items.count) }
    private var tabBarHeight: CGFloat { barContainerHeight + barMargins.top + barMargins.bottom }

    @ViewBuilder
    private func tab(item: Selection) -> some View {
        if let builder = tabItemBuilders[item]?.content {
            builder()
                .contentShape(Rectangle())
                .frame(width: tabItemWidth)
                .mesurementSize(of: \.height, to: TabItemMaxHeightPreferenceKey.self)
                .onTapGesture { selection.item = item }
        }
    }

    private func mainBar() -> some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: barContainerHeight)
                .frame(maxWidth: .infinity)
                .mesurementSize(of: \.width, to: TabBarContainerWidthPreferenceKey.self)
                .padding(barMargins)
                .background {
                    GeometryReader { geo in
                        AnyView(mainBarShape.fill(shapeStyle.in(mainBarFillRect(with: geo)), style: fillStyle))
                            .shadow(color: barShadow.color, radius: barShadow.radius, x: barShadow.x, y: barShadow.y)
                    }
                }
            HStack(spacing: 0) {
                ForEach(items, id: \.hashValue, content: tab(item:))
            }
            .offset(y: (barMargins.top - barMargins.bottom) / 2)
        }
        .padding(isDefaultBarShape ? EdgeInsets(top: barPadding.top, leading: 0, bottom: 0, trailing: 0) : barPadding)
    }

    private func mainBarFillRect(with geo: GeometryProxy) -> CGRect {
        CGRect(x: 0, y: 0, width: geo.size.width, height: geo.size.height + geo.safeAreaInsets.bottom)
    }

    private func safeAreaBar() -> some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                Spacer(minLength: 0)
                Rectangle()
                    .fill(shapeStyle.in(safeAreaBarFillRect(with: geo)), style: fillStyle)
                    .frame(height: geo.safeAreaInsets.bottom)
            }
            .ignoresSafeArea()
        }
    }

    private func safeAreaBarFillRect(with geo: GeometryProxy) -> CGRect {
        CGRect(x: 0, y: -tabBarHeight, width: geo.size.width, height: geo.safeAreaInsets.bottom + tabBarHeight)
    }
}
