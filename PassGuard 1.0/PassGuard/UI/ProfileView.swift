//
//  ProfileView.swift
//  PassGuard
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var account = Accounts_Array[ContentView().GLB_Account_Id]                                  //Refering to the Account that is currently logged in
    @State public var profilePictureString = Accounts_Array[ContentView().GLB_Account_Id].ProfilePictureString
    @State var cards = Cards_Array
    
    @State var deleting = false                                                                 //Flag: Deleting account info and attached cards
    @State public var update = false
    
    var body: some View {
        
        ZStack {
            VStack {
                //Profile picture
                Image(systemName: profilePictureString)    //Show user profile Icon
                    .resizable()
                    .foregroundColor(.gray)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 120, alignment: .center)
                    .clipShape(Circle())
                
                //Username of master account
                Form {
                    
                    Section (header: Text("Usage")) {
                        HStack {
                            Text("Cards:")
                            Text(String(numberOfCards())).bold()                                    //Number of cards the user has
                        }
                        HStack {
                            Text("KB:")
                            Text(String(findSizeOfCards())).bold()                                  //Total capacity used by account (Account + Cards)
                        }
                    }
                    if HasWeakPassword() {
                        Section (header: Text("Cards with weak Passwords").foregroundColor(.red)) {
                            List(cards, id:\.id) {card in
                                //From all cards that match the users ID:
                                if card.Account_ID == ContentView().GLB_Account_Id {
                                    //If the favourites button is on: only show the favourite cards, otherwise: show all cards
                                    if card.passwordStrength < 5 {
                                        VStack (alignment: .leading) {
                                            Text(card.cardName)                                                                 //Display the name of the card
                                            Text(String(card.passwordStrength))
                                                .bold()
                                                .foregroundColor(Find_Colour(card.passwordStrength))     //Display the strength of the password
                                        }
                                        
                                    }
                                }
                            }
                        }
                    }
                    
                }.cornerRadius(20)
                Text("")
                
                Spacer()
                
                //Delete Account and Data button
                Button(action: {
                    deleting = true
                }, label: {
                    Text("Delete Account and Data").bold()
                        .frame(width: 350, height: 44, alignment: .center)
                        .background(.red)
                        .foregroundColor(.white)
                        .cornerRadius(22)
                    
                })
                Spacer()
            }
            
            //Confirming deletion of current card
            if deleting {
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
                                Button(action: {
                                    deleting = false
                                }, label: {
                                    Image(systemName: "xmark").foregroundColor(.red)
                                })
                                Text("          ")
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
                            Text("Delete Account?")
                                .bold()
                            Text("")
                            Text("")
                            Text("This will delete the account")
                            Text("and all its cards.")                                  //Getting confirmation to delete account and cards
                            Text("Do you wish to continue?")
                            Text("")
                            Text("")
                            
                            HStack {
                                Spacer()
                                Button(action: {
                                    deleting = false
                                }, label: {
                                    Text("Cancel").foregroundColor(.blue)
                                })
                                Spacer()
                                Button(action: {
                                    deleting = false
                                    deleting = false
                                    deleteAccountData()                                               //Deleteing all associated data
                                    ContentView().numAccounts -= 1                                    //Minus 1 account from total number of account count
                                    ContentView().Logged_In = false                                   //Loggout
                                    
                                }, label: {
                                    Text("Delete").foregroundColor(.red)
                                })
                                Spacer()
                            }
                        }
                    }
                    Spacer()
                    Spacer()
                }
            }
            
        }.onDisappear {
            deleting = false
        }
        .padding()
        .navigationBarTitle(account.AccountUsername)
        
        //Edit Profile Button
        .toolbar {
            NavigationLink(destination: {
                EditProfileView()
            }, label: {
                Image(systemName: "pencil")
            })
        }
    }
}

//Previewer
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
