//
//  Logic.swift
//  PassGuard
//

import SwiftUI


/// Finds the correct colour based on Password Strength
func Find_Colour (_ strength: Float) -> Color {
    var colour: Color = .black
    if strength >= 9 {                                                                          //9+ => Green
        colour = .green
    }
    else if strength >= 7 {                                                                     //7+ => Yellow
        colour = .yellow
    }
    else if strength > 5 {                                                                      //Greater than 5 => Orange
        colour = .orange
    }
    else if strength <= 5 {                                                                     //5 or less => Red
        colour = .red
    }
    if strength == 0 {                                                                          //Grey if 0
        colour = .gray
    }
    return colour                                                                               //Return the colour
}

/// Logs in the user if they provide the correct username and password
func Login (_ entered_U: String, _ entered_P: String) -> Bool {                                 //Login() requires 2 inputs; a username and a password
    var Validation = false                                                                      //Validation stores T/F if the account detail are right
    var i = 0                                                                                   //i is a counter
    let length = Accounts_Array.count                                                           //counting the number of Accounts in Accounts_Array
    
    while Validation == false && i < length {                                                   //while in range of the array and NOT logged in
        
        if Accounts_Array[i].AccountUsername == entered_U {                                     //check each username if it matches input
            
            if Accounts_Array[i].AccountPassword == Encrypt(entered_P) {                        //compaire saved and input password if username exists
                
                Validation = true                                                               //raise flag that loggin in successful
                ContentView().GLB_Account_Id = i                                                //set the current user id
                ContentView().Logged_In = true
            }
        }
        i += 1                                                                                  //increment the counter
    }
    return Validation                                                                           //return the flag
}

//Add ASCII trait to chracter data type
extension Character {
    var asciiValue: Int {
        get {
            let s = String(self).unicodeScalars
            return Int(s[s.startIndex].value)
        }
    }
}

/// Check if the input value is valid (between ASCII 32 to 126 AND is not an empty string)
func Check_Valid (_ value: String) -> Bool {
    var valid = true
    for i in value {                                                                            //Looping through all characters in the input string
        
        if i.asciiValue > 126 || i.asciiValue < 32 {                                            //Checking if the character is within the allowable range
            
            valid = false                                                                       //Return false if any character is out of the range
            break
        }
    }
    if value == "" {
        valid = false                                                                           //String is invalid if it is empty
    }
    return valid                                                                                //Return if the value in valid or not
}

/// Finds how strong the input password is based on length and characters used
func Find_Strength (_ password: String) -> Float {
    var strength: Float = 0.0
    
    //Counters for each character type
    var upper: Float = 0
    var lower: Float = 0
    var num: Float = 0
    var special: Float = 0
    
    let length: Float = Float((password.count) / 2)
    
    
    if Check_Valid (password) == true {                                                         //Checks if the input value is valid
        
        for i in password {                                                                     //Loops through every character in the input string
            
            //Adding to the respective counters (with weighting)
            if i.isUppercase {
                upper += 2
            }
            else if i.isLowercase {
                lower += 1
            }
            else if i.isNumber {
                num += 2
            }
            else {
                special += 3
            }
        }
        
        strength = (upper + lower + num + special + length) / 5 * 2                             //Strength is average from: (counters + the total length)
        
        //Limits the strength to 10
        if strength > 10 {
            strength = 10
        }
    }
    return strength                                                                             //Return the strength of the password
}

/// Creates a new account, and adds it to the Accounts Array
func Create_Account (_ username: String, _ password: String) -> Bool {
    
    var success = false                                                                         //Flag: Raised if a new account has been created and added
    var double_up = false                                                                       //Flag: Raised if the username is already being used
    var i = 0
    let length = Accounts_Array.count
    
    while double_up == false && i <= length - 1 {                                               //While there is no double up and within range or array
        if Accounts_Array[i].AccountUsername == username {                                      //Checks if the username is already being used
            double_up = true                                                                    //Raise the double up flag as it already exists
        }
        i += 1
    }
    
    if double_up != true && Check_Valid(username) == true && Check_Valid(password) == true {                            //If the username is unique and both values are valid
        ContentView().GLB_Account_Id = length
        ContentView().Logged_In = true                                                                                  //Login the user
        Accounts_Array.append(Account(username, Encrypt(password), ContentView().GLB_Account_Id, "person.crop.circle")) //Create a new account and add it to the array
        success = true                                                                                                  //Raise the successful card creation flag
    }
    
    ContentView().Accounts_Array_String = makeAccountsString(Accounts_Array)                    //Update the App Storage Accounts String
    
    return success                                                                              //Return if the account creation was successful
}


/// Checks if a particular username belongs to any account currently saved
func Check_Valid_Account (_ username: String) -> Bool {
    
    var nothing_wrong = true                                                                    //Flag: If the username is valid
    var i = 0
    let length = Accounts_Array.count
    
    while nothing_wrong == true && i <= length - 1 {                                            //While username is valid AND within range
        if Accounts_Array[i].AccountUsername == username {                                      //If the username already exists
            nothing_wrong = false                                                               //Then the username is invalid
        }
        i += 1
    }
    
    return nothing_wrong                                                                        //Return if the username is valid or not
}

/// Creates a new card using parameters and adds it to the cards array
func Create_New_Card (_ name: String, _ username: String, _ password: String, _ isfav: Bool, _ url: String) {
    Cards_Array.append(Card(Next_Id(), name, url, username, password, Find_Strength(password), isfav, ContentView().GLB_Account_Id))    //Create then add
    
    ContentView().Cards_Array_String = makeCardsString(Cards_Array)                             //Reset the cards string
}

var Current_Id = -1                                                                             //Next unique card ID when a new card is created

/// Finds next new card ID before all the ID's in the cards array are updated
func Next_Id () -> Int {
    Current_Id += 1
    return Current_Id
}

/// Re-assigns all card ID's again from 0
func Update_Card_Ids () {
    var index = 0
    
    for card in Cards_Array {                                                                   //Go through all cards stored in the application
        card.id = index                                                                         //Set the current card ID to the next index
        index += 1                                                                              //increment the next index by 1
    }
}

/// Checks if a card exists at a particular index
func Check_Existence(_ index: Int) -> Bool {
    var exists = false                                                                          //Flag: Raised if a card exists
    if (Cards_Array.count > index) {                                                            //If the index of the card is within range of all cards
        exists = true                                                                           //Then card exists
    }
    return exists                                                                               //Return if the card exists
}

/// Edits a card by creating a new card before replacing the old one
func Edit_Card (_ I: Int, _ Ename: String, _ Eusername: String, _ Epassword: String, _ Eurl: String, _ isfav: Bool, _ accountid: Int) {
    Cards_Array[I] = Card(I, Ename, Eurl, Eusername, Epassword, Find_Strength(Epassword), isfav, accountid) //Creating new card with edits to replace old
    
    ContentView().Cards_Array_String = makeCardsString(Cards_Array)                                         //Update cards string
}

/// Checks if the current user has at least 1 card
func UserHasCards() -> Bool {
    
    for card in Cards_Array {                                                                   //Go through all cards in the application
        if card.Account_ID == ContentView().GLB_Account_Id {                                    //If any card belongs to the current user:
            return true                                                                         //The user has at least 1 card
        }
    }
    return false
}

/// Counts the number of cards that belong to the currently logged in user
func numberOfCards () -> Int {
    var counter = 0
    
    for card in Cards_Array {                                                                   //Go through all cards in the application
        if card.Account_ID == ContentView().GLB_Account_Id {                                    //If the card belongs to the current user:
            counter += 1                                                                        //Increment the number of cards that user has
        }
    }
    return counter                                                                              //Return the number of cards the current user has
}

/// Finds and deletes all cards that belong to the currently logged in user, before erasing the account itself by making it empty
func deleteAccountData () {
    
    for card in Cards_Array {                                                                   //Go through all cards in the application
        
        if card.Account_ID == ContentView().GLB_Account_Id {                                    //If the card belongs to the current user:
            
            Cards_Array.remove(at: card.id)                                                     //Then delete the card
            Update_Card_Ids()                                                                   //Update all the card ID's
        }
        
    }
    
    //Erase the account data by setting the username and password to empty strings
    Accounts_Array[ContentView().GLB_Account_Id].AccountUsername = ""
    Accounts_Array[ContentView().GLB_Account_Id].AccountPassword = ""
    
    //Update the accounts and cards strings to reflect changes
    ContentView().Cards_Array_String = makeCardsString(Cards_Array)
    ContentView().Accounts_Array_String = makeAccountsString(Accounts_Array)
    ContentView().GLB_Account_Id = 0
}

/// Removes all spaces in a given string
func removeSpaces(_ inputValue: String) -> String {
    var out = ""
    
    for i in inputValue {                                                                       //Goes through each character in a string
        if i != " " {                                                                           //Only add the character back if it's not a space
            out += String(i)
        }
    }
    return out
}

/// Checks if the URL of a card contains the invalid " \ " character which will otherwise cause an error when reading the URL
func checkURL(_ inputValue: String) -> Bool {
    if inputValue.contains("\\") || !Check_Range(inputValue) {                                  //Checks if it contains the \ character within the string
        return false                                                                            //Returns that it is NOT valid
    }
    if inputValue.contains("{") || !Check_Range(inputValue) {                                  //Checks if it contains the \ character within the string
        return false                                                                            //Returns that it is NOT valid
    }
    if inputValue.contains("}") || !Check_Range(inputValue) {                                  //Checks if it contains the \ character within the string
        return false                                                                            //Returns that it is NOT valid
    }
    
    return true                                                                                 //Otherwise returns that it IS valid
}

/// Checks if all characters in a string are valid
func Check_Range (_ value: String) -> Bool {
    var valid = true
    for i in value {                                                                            //Looping through all characters in the input string
        
        if i.asciiValue > 126 || i.asciiValue < 32 {                                            //Checking if the character is within the allowable range
            valid = false                                                                       //Return false if any character is out of the range
            break
        }
    }
    return valid                                                                                //Return if the value in valid or not
}
