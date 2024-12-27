//
//  TextEditorRoundedCornerStyle.swift
//  CRUD
//
//  Created by Enxhi Qemalli on 27.12.24.
//

import SwiftUI

struct TextEditorRoundedCornerStyle: ViewModifier {
    let minHeight: CGFloat

    func body(content: Content) -> some View {
        content
            .frame(minHeight: minHeight)
            .padding(4)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
            )
    }
}
