//
//  EditProfileView.swift
//  PassGuard
//

import SwiftUI

struct EditProfileView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var iconString = Accounts_Array[ContentView().GLB_Account_Id].ProfilePictureString
    @State var username = Accounts_Array[ContentView().GLB_Account_Id].AccountUsername
    
    func CheckActiveColor(_ icon: String) -> Color {
        if icon == iconString {
            return .blue
        }
        return .gray
    }
    
    
    var body: some View {
        VStack {
            Spacer()
            Text("Select a profile icon:")
                .scaleEffect(1.1)
                .padding(.bottom, 10)
            
            //Previewing all possible user icons whcih the user can choose from
            HStack {
                Spacer()
                
                //Default icon
                Button(action: {
                    iconString = "person.crop.circle"
                    ProfileView().update = true
                }, label: {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 70)
                        .foregroundColor(CheckActiveColor("person.crop.circle"))
                })
                
                //Pawprint
                Button(action: {
                    iconString = "pawprint.circle"
                    ProfileView().update = true
                }, label: {
                    Image(systemName: "pawprint.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 70)
                        .foregroundColor(CheckActiveColor("pawprint.circle"))
                })
                
                //Leaf
                Button(action: {
                    iconString = "leaf.circle"
                    ProfileView().update = true
                }, label: {
                    Image(systemName: "leaf.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 70)
                        .foregroundColor(CheckActiveColor("leaf.circle"))
                })
                
                //Star
                Button(action: {
                    iconString = "star.circle"
                    ProfileView().update = true
                }, label: {
                    Image(systemName: "star.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 70)
                        .foregroundColor(CheckActiveColor("star.circle"))
                })
                Spacer()
            }.padding(.bottom)
            
            //Textbox for user to change their username (cannot be another users username)
            Form {
                Section (header: Text("Edit Master Username")){
                    HStack {
                        TextField("editMasterUsername", text: $username, prompt: Text("Enter New Master Username"))
                        Image(systemName: "pencil").foregroundColor(.blue)
                    }
                }
            }.cornerRadius(22)
            Spacer()
            Text("").padding(.top, 350)
        }.toolbar {
            
            //Button to save all changes made
            Button("Save") {
                
                //Checks if the entered username is unique
                if Check_Valid_Account(username) {
                    Accounts_Array[ContentView().GLB_Account_Id].AccountUsername = username
                }
                
                Accounts_Array[ContentView().GLB_Account_Id].ProfilePictureString = iconString
                ContentView().Accounts_Array_String = makeAccountsString(Accounts_Array)
                presentationMode.wrappedValue.dismiss()
                presentationMode.wrappedValue.dismiss()
            }
        }.padding().navigationBarTitle("Edit Profile")
    }
}

//Previewer
struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
