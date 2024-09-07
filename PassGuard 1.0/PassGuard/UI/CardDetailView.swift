//
//  CardDetailView.swift
//  PassGuard
//

import SwiftUI

struct CardDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    var card: Card
    
    @State public var update = false                                                            //Flag: Determines if an update must occur due to changes
    @State var showInfo = false                                                                 //Flag: Determines to show info on the password strength
    @State var isfav = false                                                                    //Flag: User preference for the card to be a favourite
    @State var showPass = false                                                                 //Flag: User preference to hide/reveal the password
    
    @State var deleting = false                                                                 //Flag: Raised to signify the card is being deleted
    @State var copied = false                                                                   //Flag: Raised when user copies their password
    
    var body: some View {
        ZStack {
            Form {
                //Username
                Section (header: Text("Username")) {
                    Text(card.cardUsername)
                }
                
                //URL of the card
                Section (header: Text("URL")) {
                    Link(card.URL, destination: URL(string: card.URL)!)
                }
                
                //Password
                Section (header: Text("Password")) {
                    HStack {
                        if showPass {
                            Text(card.cardPassword)
                        }
                        else {
                            Text(getSecureString(card.cardPassword))
                        }
                        
                        Spacer()
                        
                        //Toggle to reveal / hide password
                        Button(action: {
                            showPass.toggle()
                        }, label: {
                            if showPass {
                                Image(systemName: "eye.slash")
                            }
                            else {
                                Image(systemName: "eye")
                            }
                        })
                    }
                    
                    //Button to copy password
                    Button(action: {
                        UIPasteboard.general.string = card.cardPassword
                        copied = true
                    }, label: {
                        if copied {
                            Text("Password has been copied!").foregroundColor(.green)               //Successful copy message
                        }
                        else {
                            HStack {
                                Image(systemName: "paperclip")
                                Text("Copy")
                            }
                        }
                    })
                    
                }
                
                //Password strength
                Section (header: Text("Password Strength")) {
                    HStack {
                        Text(String(Find_Strength(card.cardPassword)))                              //Find the strength using Find_Strength()
                            .foregroundColor(Find_Colour(Find_Strength(card.cardPassword)))         //Find correct colour using Find_Colour()
                            .font(.system(size: 17, weight: .bold))
                        
                        Spacer()
                        
                        //Button to show password strength info
                        Button(action: {
                            deleting = false
                            showInfo.toggle()
                        }, label: {
                            Image(systemName: "questionmark.circle")
                        })
                        //                            .alert(isPresented: $showInfo, content: {
                        //                                Alert(title: Text("Password Strength"),
                        //                                      message: Text("This number is out of 10, and shows the relative strength of your password"))
                        //                            })
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
                            Text("a").foregroundColor(.white)
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
                            Text("a score out of 10 showing how").foregroundStyle(Color(.black))
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
                                Spacer()
                                Spacer()
                                Spacer()
                                Button(action: {
                                    deleting = false
                                }, label: {
                                    Image(systemName: "xmark").foregroundColor(.red)
                                })
                                Spacer()
                            }
                            
                            Text("")
                            Text("")
                            Text("a").foregroundColor(.white)
                            Text("a").foregroundColor(.white)
                            Text("a").foregroundColor(.white)
                            Text("")
                            Text("")
                            Text("a").foregroundColor(.white)
                            
                        }
                        VStack {
                            Text("Delete this Card?")
                                .bold().foregroundStyle(Color(.black))
                            Text("")
                            Text("")
                            Text("Are you sure you wish to").foregroundStyle(Color(.black))
                            Text("delete this card? This").foregroundStyle(Color(.black))
                            Text("action cannot be undone.").foregroundStyle(Color(.black))
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
                                    if Check_Existence(card.id) == true {                               //Check the card exists
                                        Update_Card_Ids()
                                        Cards_Array.remove(at: card.id)                                 //Delete it from the array
                                        Update_Card_Ids()                                               //Reset all ID's in the array
                                        ContentView().Cards_Array_String = makeCardsString(Cards_Array) //Update the Cards_Array_String
                                        update = true
                                        Update_Card_Ids()
                                        CardsView().cards = Cards_Array
                                        presentationMode.wrappedValue.dismiss()                         //Send user back to main menu
                                    }
                                    
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
            
            
        }.navigationBarTitle(card.cardName).toolbar {
            //Toolbar:
            HStack {
                //Toggle the card to be a favourite
                Button(action: {
                    if isfav {
                        isfav = false
                        card.isFavourite = false
                    }
                    else {
                        isfav = true
                        card.isFavourite = true
                    }
                }, label: {
                    if isfav {
                        Image(systemName: "star.fill")
                    }
                    else {
                        Image(systemName: "star")
                    }
                })
                
                //Delete card button
                Button(action: {
                    showInfo = false
                    deleting.toggle()
                }, label: {
                    Image(systemName: "trash")
                })
                
                //Button to edit the card by taking the user to the Edit_Card_View
                NavigationLink (destination: {
                    Edit_Card_View(card: card, ename: card.cardName, eusername: card.cardUsername, epassword: card.cardPassword, eurl: card.URL)
                }, label: {
                    Image(systemName: "pencil")
                })
            }
            
        }.onAppear {
            isfav = card.isFavourite                                                          //Update the favourite status each time the card appears
        }.onDisappear {
            showInfo = false
            ContentView().Cards_Array_String = makeCardsString(Cards_Array)
        }
    }
}

//Previewer
struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailView(card: Cards_Array.first!)
    }
}
