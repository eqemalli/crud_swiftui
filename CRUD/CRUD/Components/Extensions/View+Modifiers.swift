//
//  View+Modifiers.swift
//  CRUD
//
//  Created by Enxhi Qemalli on 27.12.24.
//

import Foundation

import SwiftUI

extension View {
    func styledTextEditor(minHeight: CGFloat) -> some View {
        self.modifier(TextEditorRoundedCornerStyle(minHeight: minHeight))
    }
}
