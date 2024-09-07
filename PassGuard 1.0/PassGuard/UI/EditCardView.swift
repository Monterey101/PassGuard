//
//  EditCardView.swift
//  PassGuard
//


import SwiftUI

struct Edit_Card_View: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var card: Card
    
    @State var ename:String                                                                     //Edited Card Name
    @State var eusername:String                                                                 //Edited Username
    @State var epassword:String                                                                 //Edited Password
    @State var eurl:String                                                                      //Edited URL
    @State var isfav = false                                                                    //Edited Favourites status
    
    @State private var notPossible = false                                                      //Flag: Determines if any field is empty
    @State var showInfo = false                                                                 //Flag: User decides to view password strength info
    
    var body: some View {
        ZStack {
            VStack {
                Form {
                    //Card Name field
                    Section (header: Text("Name")) {
                        TextField("Name", text: $ename, prompt: Text(card.cardName))
                    }
                    
                    //URL field
                    Section(header: Text("URL")) {
                        TextField("URL", text: $eurl, prompt: Text(card.URL))
                        if !checkURL(eurl) {
                            Text("You have entered an invalid value for the URL").foregroundColor(.red)
                        }
                    }
                    
                    //Username field
                    Section (header: Text("Username")) {
                        TextField("Username", text: $eusername, prompt: Text(card.cardUsername))
                    }
                    
                    //Password field
                    Section (header: Text("Password")) {
                        TextField("Password", text: $epassword, prompt: Text(card.cardPassword))
                        Button("Generate new password") {
                            epassword = generatePassword()
                        }
                    }
                    
                    //Password Strength field
                    Section (header: Text("Password Strength")) {
                        HStack {
                            Text(String(Find_Strength(epassword))).foregroundColor(Find_Colour(Find_Strength(epassword)))
                            
                            Spacer()
                            
                            //Password Strength info button
                            Button(action: {
                                showInfo.toggle()
                            }, label: {
                                Image(systemName: "questionmark.circle")
                            })
                        }
                    }
                    
                    if ename == "" || eusername == "" || epassword == "" || eurl == "" {
                        Text("You must enter a value for all fields").foregroundColor(.red)         //Empty field(s) warning
                    }
                }
                
            }.navigationBarTitle(card.cardName).toolbar {
                //Toolbar
                HStack {
                    //Toggle favourite status of card
                    Button(action: {
                        if isfav {
                            isfav = false
                        }
                        else {
                            isfav = true
                        }
                    }, label: {
                        if isfav {
                            Image(systemName: "star.fill")
                        }
                        else {
                            Image(systemName: "star")
                        }
                    })
                    
                    //Edit card button
                    Button {
                        if ename != "" && eusername != "" && epassword != "" && eurl != "" {
                            notPossible = false
                            if checkURL(eurl) {
                                Edit_Card(card.id, ename, eusername, epassword, removeSpaces(eurl), isfav, card.Account_ID)
                                Update_Card_Ids()
                                presentationMode.wrappedValue.dismiss()                                 //Return user to main menu if successful
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                        else {
                            notPossible = true
                        }
                    } label: {
                        Text("Save")
                    }
                }
            }
            
            //Message explaining the password strength
            if showInfo {
                VStack {
                    Spacer()
                    ZStack {
                        Rectangle()
                            .fill(.white)
                            .frame(width: 300, height: 200)
                            .cornerRadius(25)
                            .shadow(radius: 25)
                        VStack {
                            HStack {
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                                Button(action: {
                                    showInfo = false
                                }, label: {
                                    Image(systemName: "xmark").foregroundColor(.red)
                                })
                                Spacer()
                            }
                            
                            Text("")
                            Text("")
                            Text("a").foregroundColor(.white)
                            Text("a").foregroundColor(.white)                                       //Matching displacement of the message
                            Text("a").foregroundColor(.white)
                            Text("")
                            Text("")
                            Text("a").foregroundColor(.white)
                            
                        }
                        VStack {
                            Text("Password Strength")
                                .bold().foregroundStyle(Color(.black))
                            Text("")
                            Text("")
                            Text("Your 'Password Strength' is").foregroundStyle(Color(.black))
                            Text("a score out of 10 showing how").foregroundStyle(Color(.black))                                   //Description of Password Strength
                            Text("secure your password is.").foregroundStyle(Color(.black))
                            Text("")
                            Text("")
                            
                            Button(action: {
                                showInfo = false
                            }, label: {
                                Text("OK").foregroundColor(.blue)
                            })
                            
                        }
                    }
                    Spacer()
                    Spacer()
                }
            }
            
        }
        
        .onAppear {
            isfav = card.isFavourite                                                            //Update favourite status when view appears to user
        }
    }
}

//Previewer
struct Edit_Card_View_Previews: PreviewProvider {
    static var previews: some View {
        Edit_Card_View(card: Cards_Array.first!, ename: "google", eusername: "something", epassword: "siufweaoiyfgwe", eurl: "hi")
    }
}
