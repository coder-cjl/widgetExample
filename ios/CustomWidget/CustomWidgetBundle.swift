//
//  CustomWidgetBundle.swift
//  CustomWidget
//
//  Created by 雷子 on 2023/7/6.
//

import WidgetKit
import SwiftUI

@main
struct CustomWidgetBundle: WidgetBundle {
    
    @WidgetBundleBuilder
    var body: some Widget {
        SmallWidget()
        MediumWidget()
        LargeWidget()
        InlineWidget()
        TargetCircular()
    }
}
