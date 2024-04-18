//
//  RegistPopo.swift
//  Popo
//
//  Created by 이윤학 on 4/17/24.
//

import SwiftUI

struct PopoRecordRegist: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var title: String = ""
    @State var description: String = ""
    @Binding var isEditing: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(spacing: 24) {
                    textfieldSection(text: $title,
                                     textLimit: 10,
                                     sectionTitle: "제목",
                                     caption: nil,
                                     placeHolder: "제목을 입력해주세요.",
                                     isEssential: true)
                    textfieldSection(text: $description,
                                     textLimit: 30,
                                     sectionTitle: "내용",
                                     caption: nil,
                                     placeHolder: "내용을 입력해주세요",
                                     isEssential: true,
                                     isTextEditor: true)
                    HStack {
                        Text("사진 추가")
                            .font(.headline)
                        Spacer()
                    }
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0..<9) { _ in
                                Button {
                                    //
                                } label : {
                                    RoundedRectangle(cornerRadius: 15)
                                        .frame(width: 60, height: 80)
                                        .foregroundStyle(.popoBlack.opacity(0.4))
                                }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    
                    Spacer()
                }
                .padding()
            }
            .contentMargins(.bottom, 36, for: .scrollContent)
            .navigationTitle(isEditing ? "기록 수정하기" : "기록 추가하기")
            .navigationBarTitleDisplayMode(.inline)
            .background {
                Image("PopoBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    cancelButton
                }
                ToolbarItem(placement: .topBarTrailing) {
                    registerButton
                }
            }
        }
        .dismissKeyboard()
    }
}

extension PopoRecordRegist {
    func textfieldSection(text: Binding<String>, textLimit: Int, sectionTitle: String, caption: String?, placeHolder: String, isEssential: Bool, isTextEditor: Bool = false) -> some View {
        return VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 2) {
                Text(sectionTitle)
                if isEssential {
                    Text("*")
                        .foregroundStyle(.popoPink)
                }
            }
            .font(.headline)
            if let caption = caption {
                Text(caption)
                    .font(.caption)
                    .foregroundStyle(.popoBlack.opacity(0.6))
            }
            if isTextEditor {
                TextEditor(text: text)
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
            } else {
                TextField(placeHolder, text: text)
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
                    .onChange(of: text.wrappedValue) { _, _ in
                        if text.wrappedValue.count > textLimit {
                            text.wrappedValue = String(text.wrappedValue.prefix(textLimit))
                            HapticManager.instance.notification(type: .warning)
                        }
                    }
                HStack {
                    Spacer()
                    Text("\(text.wrappedValue.count) / \(textLimit)")
                        .font(.caption)
                        .foregroundStyle(text.wrappedValue.count >= textLimit ? .popoPink : .popoBlack.opacity(0.6))
                }
            }
            
            
        }
        .foregroundStyle(.popoBlack)
    }
    
    var cancelButton: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Text("취소")
        }
        .tint(.popoPink)
    }
    
    var registerButton: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Text(isEditing ? "수정" :"등록")
                .fontWeight(.semibold)
        }
        .disabled(title.isEmpty || description.isEmpty)
    }
}

#Preview {
    PopoRecordRegist(isEditing: .constant(true))
}