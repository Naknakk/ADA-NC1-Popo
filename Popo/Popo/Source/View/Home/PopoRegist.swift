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
    
    @State private var popo: Popo = Popo()
    @State private var isImagePickerDisplayed = false
    @State private var image: Image? = nil
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 24) {
                    imagePicker
                    nameTextFieldSection
                    keywordTextFieldSection
                    likeSection
                    Spacer()
                }
                .padding()
            }
            .background(Color.popoBrown30)
            .navigationTitle("나의 Popo 추가하기")
            .navigationBarTitleDisplayMode(.inline)
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
            Button {
                isImagePickerDisplayed = true
            } label : {
                ZStack(alignment: .bottomTrailing) {
                    Rectangle()
                        .frame(width: 150, height: 200)
                        .foregroundStyle(.gray.opacity(0.3))
                        .overlay {
                            Image(systemName: "person.fill")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(.white.opacity(0.85))
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                    image?
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                    Image(systemName: "camera.fill")
                        .foregroundStyle(.white)
                        .font(.title3)
                        .padding(8)
                        .background(Color.popoGreen)
                        .clipShape(Circle())
                        .offset(x: 12, y: 6)
                }
            }
            .fullScreenCover(isPresented: $isImagePickerDisplayed) {
                ImagePicker(selectedImage: $image)
            }
            Spacer()
        }
        .onChange(of: image) { _, _ in
            popo.image = image ?? Image("Default")
        }
    }
    
    var nameTextFieldSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 2) {
                Text("이름")
                Text("*")
                    .foregroundStyle(.popoPink)
            }
            .font(.headline)
           
            Text("애정을 담은 별명도 좋습니다.")
                .font(.caption)
                .foregroundStyle(.popoBlack.opacity(0.6))
            TextField("이름을 입력해주세요.", text: $popo.name)
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
                .onChange(of: popo.name) { _, _ in
                    if popo.name.count > 10 {
                        popo.name = String(popo.name.prefix(10))
                        HapticManager.instance.notification(type: .error)
                    }
                }
                .padding(.top, 4)
            HStack {
                Spacer()
                Text("\(popo.name.count) / 10")
                    .font(.caption)
                    .foregroundStyle(popo.name.count >= 10 ? .popoPink.opacity(0.6) : .popoBlack.opacity(0.6))
            }
        }
    }
    
    var keywordTextFieldSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("키워드")
                .font(.headline)
            Text("그 사람을 표현할 간단한 키워드를 나열해주면 됩니다.")
                .font(.caption)
                .foregroundStyle(.popoBlack.opacity(0.6))
            TextField("ex) 초록, 빈티지, 최고 ENFP, ...", text: $popo.keyword)
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
                .onChange(of: popo.keyword) { _, _ in
                    if popo.keyword.count > 25 {
                        popo.keyword = String(popo.keyword.prefix(25))
                        HapticManager.instance.notification(type: .error)
                    }
                }
                .padding(.top, 4)
            HStack {
                Spacer()
                Text("\(popo.keyword.count) / 25")
                    .font(.caption)
                    .foregroundStyle(popo.keyword.count >= 25 ? .popoPink.opacity(0.6) : .popoBlack.opacity(0.6))
            }
        }
    }
    
    var likeSection: some View {
        Toggle(isOn: $popo.isLiked) {
            Text("즐겨찾기")
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
            modelData.popos.append(popo)
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Text("등록")
        }
        .disabled(popo.name.isEmpty ? true : false)
    }
}

#Preview {
    PopoRegist()
        .environmentObject(ModelData())
}
