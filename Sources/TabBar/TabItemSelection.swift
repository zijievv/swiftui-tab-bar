//
//  TabItemSelection.swift
//
//
//  Created by Zijie on 18.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

class TabItemSelection<Selection: Hashable>: ObservableObject {
    @Binding var item: Selection

    init(item: Binding<Selection>) {
        self._item = item
    }
}
