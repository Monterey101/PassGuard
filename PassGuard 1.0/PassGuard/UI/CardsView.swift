//
//  CardsView.swift
//  PassGuard
//

import SwiftUI

struct CardsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State public var cards = Cards_Array                                                       //Retreving cards from Cards_Array to display them
    
    @State var showFavourites: Bool = false                                                     //Holds user preference to only show favourite cards
    @State var showSearch = false                                                               //Holds user preference to search cards
    
    @State var headerName = "All Cards"
    
    @State var searchItem = ""                                                                  //Name of Card the user is searching for
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                //Shows placeholder if user has no cards
                if !UserHasCards() {
                    Spacer()
                    Image(systemName: "lock.shield")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150, alignment: .center)
                        .foregroundColor(.gray)
                        .opacity(0.5)
                    Text("Press the + button to start")
                        .foregroundColor(.gray)
                    Spacer()
                    Spacer()
                }
                
                //If user wishes to show search through their cards:
                else if showSearch {
                    Form {
                        
                        //Display a search bar to enter the name of the card they are searching for
                        HStack {
                            TextField("searchItem", text: $searchItem, prompt: Text("Search Cards"))
                            Spacer()
                            Image(systemName: "magnifyingglass").foregroundColor(.blue)
                        }
                        
                        //Show a list of cards that match the search item
                        Section (header: Text("Search Results")){
                            List(cards, id:\.id) {card in
                                //From all cards that match the users ID:
                                //If the search item is empty: show all cards, otherwise: show cards that match the search item (but only those which are favourites if the 'Favourites only' button has been selected)
                                
                                if (searchItem == "" && card.Account_ID == ContentView().GLB_Account_Id && ((showFavourites && card.isFavourite)
                                                                                                            || (!showFavourites)))
                                    
                                    ||                                                              //OR
                                    
                                    (card.Account_ID == ContentView().GLB_Account_Id && card.cardName.lowercased().contains(searchItem.lowercased())
                                     && ((showFavourites && card.isFavourite) || (!showFavourites))) {
                                    
                                    NavigationLink(destination: CardDetailView(card: card), label: {
                                        VStack (alignment: .leading) {
                                            Text(card.cardName)                                     //Display the name of the card
                                            Text(card.URL)                                          //Display the URL it is used for
                                        }
                                    })
                                    
                                }
                            }.onAppear {
                                Update_Card_Ids()                                                   //Update the cards whenever they appear to the user
                            }
                        }
                    }
                }
                else {
                    
                    Form {
                        
                        Section (header: Text(headerName)) {
                            List(cards, id:\.id) {card in
                                //From all cards that match the users ID:
                                if card.Account_ID == ContentView().GLB_Account_Id {
                                    //If the favourites button is on: only show the favourite cards, otherwise: show all cards
                                    if (showFavourites && card.isFavourite) || !showFavourites {
                                        NavigationLink(destination: CardDetailView(card: card), label: {
                                            VStack (alignment: .leading) {
                                                Text(card.cardName)                                     //Display the name of the card
                                                Text(card.URL)                                          //Display the URL it is used for
                                            }
                                        })
                                        
                                    }
                                }
                            }
                        }
                    }
                }
                //Each time the main menu appears or is refreshed: update the id's and read from the updated Cards_Array
            }.onAppear {
                Update_Card_Ids()
                cards = Cards_Array
            }.refreshable {
                Update_Card_Ids()
                cards = Cards_Array
            }
            
            .onDisappear {
            }.navigationBarTitle("Cards").toolbar {
                //Toolbar in top right corner
                HStack {
                    
                    //Toggle to only show favourites
                    Button(action: {
                        showFavourites.toggle()
                        if headerName == "Favourites" {
                            headerName = "All Cards"
                        }
                        else {
                            headerName = "Favourites"
                        }
                    }, label: {
                        if showFavourites {
                            Image(systemName: "star.fill")
                        }
                        else {
                            Image(systemName: "star")
                        }
                    })
                    
                    //Toggle to search through cards
                    Button(action: {
                        showSearch.toggle()
                    }, label: {
                        if showSearch {
                            Image(systemName: "magnifyingglass.circle.fill")
                        }
                        else {
                            Image(systemName: "magnifyingglass.circle")
                        }
                    })
                    
                    //View profile button
                    NavigationLink(destination: ProfileView(), label: {
                        Image(systemName: Accounts_Array[ContentView().GLB_Account_Id].ProfilePictureString)    //Getting current user profile picture
                    })
                }
            }
            
            //Button to take user to create a new card on a different page
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink (destination: {
                        NewCardView().navigationTitle("New Card")
                    }, label: {
                        ZStack {
                            Circle()
                                .fill(.blue)
                                .frame(width: 70, height: 70)
                                .shadow(radius: 35)
                            Image(systemName: "plus")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.white)
                        }
                    })
                    
                    
                }
            }.padding()
        }
    }
}

//Previewer
struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        CardsView()
    }
}
