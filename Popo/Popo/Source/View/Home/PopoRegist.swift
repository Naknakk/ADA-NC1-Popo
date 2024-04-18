//
//  RegistPopo.swift
//  Popo
//
//  Created by 이윤학 on 4/17/24.
//

import SwiftUI

struct PopoRegist: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var modelData: ModelData
    
    @Binding var popo: Popo
    @Binding var editTargetIndex: Int?
    @Binding var needResort: Bool
    
    @State private var isImagePickerDisplayed = false
    @State var image: Image? = Image("Default")
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 24) {
                    imagePicker
                    textfieldSection(text: $popo.name,
                                     textLimit: 10,
                                     sectionTitle: "이름",
                                     caption: "애정을 담은 별명도 좋습니다.",
                                     placeHolder: "이름을 입력해주세요.",
                                     isEssential: true)
                    textfieldSection(text: $popo.keyword,
                                     textLimit: 30,
                                     sectionTitle: "키워드",
                                     caption: "그 사람을 표현할 간단한 키워드를 나열해주면 됩니다.",
                                     placeHolder: "ex) 초록, 빈티지, 최고 ENFP, ...",
                                     isEssential: false)
                    likeSection
                    Spacer()
                }
                .padding()
            }
            .contentMargins(.bottom, 36, for: .scrollContent)
            .navigationTitle(editTargetIndex == nil ? "나의 Popo 추가하기" : "수정하기")
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

extension PopoRegist {
    var imagePicker: some View {
        HStack {
            Spacer()
            ZStack(alignment: .bottomTrailing) {
                Button {
                    isImagePickerDisplayed = true
                } label : {
                    popo.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .contextMenu {
                    Button(role: .destructive) {
                        image = nil
                    } label: {
                        Text("이미지 삭제")
                    }
                }
                
                Button {
                    isImagePickerDisplayed = true
                } label : {
                    Image(systemName: "camera.fill")
                        .foregroundStyle(.white)
                        .font(.title3)
                        .padding(8)
                        .background(Color.popoGreen)
                        .clipShape(Circle())
                        .offset(x: 12, y: 6)
                }
            }
            .sheet(isPresented: $isImagePickerDisplayed) {
                ImagePicker(selectedImage: $image)
            }
            
            Spacer()
        }
        .onChange(of: image) { _, _ in
            popo.image = image ?? Image("Default")
        }
        
    }
    
    func textfieldSection(text: Binding<String>, textLimit: Int, sectionTitle: String, caption: String, placeHolder: String, isEssential: Bool) -> some View {
        return VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 2) {
                Text(sectionTitle)
                if isEssential {
                    Text("*")
                        .foregroundStyle(.popoPink)
                }
            }
            .font(.headline)
            
            Text(caption)
                .font(.caption)
                .foregroundStyle(.popoBlack.opacity(0.6))
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
                .padding(.top, 4)
                .onChange(of: text.wrappedValue) { _, _ in
                    if text.wrappedValue.count > textLimit {
                        text.wrappedValue = String(text.wrappedValue.prefix(textLimit))
                        HapticManager.instance.notification(type: .warning)
                    }
                }
                .padding(.top, 4)
            HStack {
                Spacer()
                Text("\(text.wrappedValue.count) / \(textLimit)")
                    .font(.caption)
                    .foregroundStyle(text.wrappedValue.count >= textLimit ? .popoPink : .popoBlack.opacity(0.6))
            }
        }
        .foregroundStyle(.popoBlack)
    }
    
    var likeSection: some View {
        Toggle(isOn: $popo.isLiked) {
            Text("즐겨찾기")
                .foregroundStyle(.popoBlack)
                .font(.headline)
        }
        .tint(.popoGreen)
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
            if let index = editTargetIndex {
                needResort = modelData.needResort(by: popo, at: index)
                modelData.updateBasicInfo(popo: popo, index: index)
            } else {
                needResort = true
                modelData.popos.append(popo)
            }
            
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Text(editTargetIndex == nil ? "등록" : "수정")
                .fontWeight(.semibold)
        }
        .disabled(popo.name.isEmpty)
    }
}

#Preview {
    PopoRegist(popo: .constant(Popo()), editTargetIndex: .constant(nil), needResort: .constant(true))
        .environmentObject(ModelData())
}
