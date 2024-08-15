import SwiftUI
import UIKit

struct ProfileView: View {
    
    @State private var image: UIImage? = nil
    @State private var imagePath: String? = nil

    @EnvironmentObject var stocksManager: StocksManager
    @EnvironmentObject var portfolioManager: PortfolioManager
    @StateObject var userManager = UserManager()
    
    @State var nickname = ""
    @State var name = ""
    @State var email = ""
    @State var phone = ""
    
    @State private var showImagePicker: Bool = false
    
    @State var editMode = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ZStack {
                    Image("profile_bg")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width - 50, height: 570)
                    
                    VStack {
                        HStack {
                            Spacer()
                            Button {
                                withAnimation {
                                    editMode = !editMode
                                }
                            } label: {
                                if editMode {
                                    Image("close_btn")
                                        .resizable()
                                        .frame(width: 32, height: 32)
                                } else {
                                    Image("edit_btn")
                                        .resizable()
                                        .frame(width: 32, height: 32)
                                }
                            }
                        }
                        .padding([.horizontal, .top])
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.width - 50, height: 570)
                    
                    VStack {
                        Button {
                            showImagePicker = true
                        } label: {
                            if let image = image {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            } else {
                                Image("profile_image")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                    .shadow(radius: 10)
                            }
                        }
                        
                        TitledTextField(title: "Nickname", text: $nickname, enabled: $editMode)
                            .padding(.horizontal)
                        TitledTextField(title: "Name", text: $name, enabled: $editMode)
                            .padding(.horizontal)
                        TitledTextField(title: "Email", text: $email, enabled: $editMode)
                            .padding(.horizontal)
                        TitledTextField(title: "Phone", text: $phone, enabled: $editMode)
                            .padding(.horizontal)
                    }
                    .frame(width: UIScreen.main.bounds.width - 50, height: 570)
                }
                
                ZStack {
                    Image("holdings_bg")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width - 50, height: 160)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Spacer()
                            Text("Your funds")
                                .font(.custom("Ubuntu-Bold", size: 18))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Text("Holding value")
                                .font(.custom("Ubuntu-Bold", size: 12))
                                .foregroundColor(.white)
                            Text("$\(portfolioManager.calculateTotalFundHoldings(stocksManager: stocksManager).formattedToTwoDecimalPlaces())")
                                .font(.custom("Ubuntu-Bold", size: 24))
                                .foregroundColor(.white)
                                .padding(.top, 1)
                            
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                }
                .frame(width: UIScreen.main.bounds.width - 50, height: 160)
                .padding()
            }
        }
        .onAppear {
            image = userManager.loadImage(fromPath: userManager.user!.avatar)
            editMode = userManager.user == nil
            nickname = userManager.user?.nickname ?? ""
            name = userManager.user?.name ?? ""
            email = userManager.user?.email ?? ""
            phone = userManager.user?.phone ?? ""        }
        .onChange(of: image) { newValue in
            if let image = image {
                imagePath = userManager.saveImage(image, forKey: "userAvatarPath")
            }
        }
        .onChange(of: editMode) { newValue in
            if !editMode {
                userManager.updateUser(nickname: nickname, name: name, email: email, phone: phone)
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $image)
        }
    }
    
}

#Preview {
    ProfileView()
        .environmentObject(StocksManager())
        .environmentObject(PortfolioManager())
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

struct TitledTextField: View {
    
    var title: String
    @Binding var text: String
    @Binding var enabled: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.custom("Ubuntu-Medium", size: 24))
                .foregroundColor(.white)
            
            TextField("trader", text: $text)
                .font(.custom("Ubuntu-Regular", size: 17))
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 12.0, style: .continuous)
                        .fill(.white)
                )
                .disabled(!enabled)
        }
    }
}
