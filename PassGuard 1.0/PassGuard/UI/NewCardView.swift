//
//  NewCardView.swift
//  PassGuard
//

import SwiftUI

struct NewCardView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var nname:String = ""                                                        //New Name for card
    @State private var nusername:String = ""                                                    //New Username for card
    @State private var npassword:String = ""                                                    //New Password for card
    @State private var nurl:String = ""                                                         //New URL for card
    
    @State private var notPossible = false                                                      //Flag: Determines if any field is left empty
    @State var isfav = false                                                                    //'Favourite' Preference for new card
    
    var body: some View {
        VStack {
            Form {
                Section (header: Text("Name")) {
                    TextField("Name", text: $nname)                                             //Card name text field
                }
                
                Section(header: Text("URL")) {
                    HStack {
                        Text("https://").foregroundColor(.gray)                                 //URL autofill
                        TextField("Web Address", text: $nurl)                                   //Domain name field
                    }
                    if !checkURL(nurl) {
                        Text("You have entered an invalid URL").foregroundColor(.red)
                    }
                }
                
                Section (header: Text("Username")) {
                    TextField("Username", text: $nusername)                                     //Username text field
                }
                
                Section (header: Text("Password")) {
                    TextField("Password", text: $npassword)                                     //Password text field
                    Button ("Generate a password") {
                        npassword = generatePassword()
                    }
                }
                
                Section (header: Text("Password Strength")) {
                    Text(String(Find_Strength(npassword))).foregroundColor(Find_Colour(Find_Strength(npassword)))   //Strength of new password
                }
                
                if notPossible {
                    Text("You must enter a value for all fields").foregroundColor(.red)         //Empty field(s) warning
                }
            }
            
            //Button to create a new card and add it to the Cards_Array
            Button {
                if nname != "" && nusername != "" && npassword != "" && nurl != "" {
                    notPossible = false
                    if checkURL(nurl) {
                        Create_New_Card(nname, nusername, npassword, isfav, "https://" + removeSpaces(nurl))
                        Update_Card_Ids()
                        presentationMode.wrappedValue.dismiss()                                 //Send the user back to the main menu if successful
                    }
                }
                else {
                    notPossible = true                                                          //Raise the notPossible flag if any field is empty
                }
            } label: {
                
                if nname == "" || nusername == "" || npassword == "" || nurl == "" || !checkURL(nurl) {
                    Text("Create Card").bold()
                        .frame(width: 350, height: 44, alignment: .center)
                        .cornerRadius(50)
                        .background(.gray)
                        .foregroundColor(.white).cornerRadius(22)
                }
                else {
                    Text("Create Card").bold()
                        .frame(width: 350, height: 44, alignment: .center)
                        .cornerRadius(50)
                        .background(.blue)
                        .foregroundColor(.white).cornerRadius(22)
                }
                
            }
            .padding()
            .disabled(nname == "" || nusername == "" || npassword == "" || nurl == "" || !checkURL(nurl))   //Disable button if any field is invalid
            
        }.toolbar {
            //Toggle for favourite preference for new card being created
            Button(action: {
                isfav.toggle()
            }, label: {
                if isfav {
                    Image(systemName: "star.fill")
                }
                else {
                    Image(systemName: "star")
                }
            })
        }
    }
}

//Previewer
struct NewCardView_Previews: PreviewProvider {
    static var previews: some View {
        NewCardView()
    }
}
