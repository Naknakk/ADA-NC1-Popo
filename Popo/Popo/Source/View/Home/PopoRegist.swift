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
        NavigationStack { // 없애기
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 24) {
                    ImagePickerButton
                    TextFieldSection(text: $popo.name,
                                     textLimit: 10,
                                     sectionTitle: "이름",
                                     caption: "애정을 담은 별명도 좋습니다.",
                                     placeHolder: "이름을 입력해주세요.",
                                     isEssential: true)
                    TextFieldSection(text: $popo.keyword,
                                     textLimit: 30,
                                     sectionTitle: "키워드",
                                     caption: "그 사람을 표현할 간단한 키워드를 나열해주면 됩니다.",
                                     placeHolder: "ex) 초록, 빈티지, 최고 ENFP, ...",
                                     isEssential: false)
                    LikeToggleSection
                    Spacer()
                }
                .padding()
            }
            .contentMargins(.bottom, 36, for: .scrollContent)
            .navigationTitle(editTargetIndex == nil ? "나의 Popo 추가하기"
                                                    : "수정하기")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    CancelButton
                }
                ToolbarItem(placement: .topBarTrailing) {
                    RegisterButton
                }
            }
            .background {
                Image("PopoBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
        .dismissKeyboard()
    }
}

extension PopoRegist {
    var ImagePickerButton: some View {
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
    
    var LikeToggleSection: some View {
        Toggle(isOn: $popo.isLiked) {
            Text("즐겨찾기")
                .foregroundStyle(.popoBlack)
                .font(.headline)
        }
        .tint(.popoGreen)
    }
    
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
