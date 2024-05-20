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
                    TextFieldSection(text: $title,
                                     textLimit: 10,
                                     sectionTitle: "제목",
                                     caption: nil,
                                     placeHolder: "제목을 입력해주세요.",
                                     isEssential: true)
                    TextFieldSection(text: $description,
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
                    CancelButton
                }
                ToolbarItem(placement: .topBarTrailing) {
                    RegisterButton
                }
            }
        }
        .dismissKeyboard()
    }
}

extension PopoRecordRegist {
    var CancelButton: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Text("취소")
        }
        .tint(.popoPink)
    }
    
    var RegisterButton: some View {
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
