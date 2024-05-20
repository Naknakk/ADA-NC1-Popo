//
//  TextFieldSection.swift
//  Popo
//
//  Created by 이윤학 on 4/25/24.
//

import SwiftUI

struct TextFieldSection: View {
    @Binding var text: String
    var textLimit: Int
    var sectionTitle: String
    var caption: String?
    var placeHolder: String
    var isEssential: Bool
    var isTextEditor: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            SectionTitle
            if let caption = caption {
                Caption(caption)
            }
            
            if isTextEditor {
                RoundBorderTextEditor
            } else {
                RoundBorderTextField
                TextLimitCounter
            }
        }
        .foregroundStyle(.popoBlack)
    }
}

extension TextFieldSection {
    var SectionTitle: some View {
        HStack(spacing: 2) {
            Text(sectionTitle)
            if isEssential {
                Text("*")
                    .foregroundStyle(.popoPink)
            }
        }
        .font(.headline)
    }
    
    func Caption(_ caption: String) -> some View {
        Text(caption)
            .font(.caption)
            .foregroundStyle(.popoBlack.opacity(0.6))
    }
    
    var RoundBorderTextEditor: some View {
        TextEditor(text: $text)
            .font(.system(size: 16))
            .padding(.vertical, 8)
            .padding(.horizontal, 6)
            .background(.white.opacity(0.85))
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .overlay{
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 2)
                    .foregroundStyle(.popoBlack.opacity(0.6))
            }
            
            .frame(height: 250)
            .padding(.top, 8)
            .onAppear(perform: {
                UITextView.appearance().backgroundColor = .clear
            })
    }
    
    var RoundBorderTextField: some View {
        TextField(placeHolder, text: $text)
            .font(.system(size: 16))
            .padding(.vertical, 8)
            .padding(.horizontal, 6)
            .background(.white.opacity(0.85))
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .overlay{
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 2)
                    .foregroundStyle(.popoBlack.opacity(0.6))
            }
            .padding(.top, 8)
            .onChange(of: text) { _, _ in
                if text.count > textLimit {
                    text = String(text.prefix(textLimit))
                    HapticManager.instance.notification(type: .warning)
                }
            }
    }
    
    var TextLimitCounter: some View {
        HStack {
            Spacer()
            Text("\(text.count) / \(textLimit)")
                .font(.caption)
                .foregroundStyle(text.count >= textLimit ? .popoPink
                                 : .popoBlack.opacity(0.6))
        }
    }
}

#Preview {
    TextFieldSection(text: .constant(""), textLimit: 25, sectionTitle: "Test", placeHolder: "Test", isEssential: true)
}
