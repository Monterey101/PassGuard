//
//  StorageManager.swift
//  PassGuard
//

import Foundation

/// Array of all existing users in the application
var Accounts_Array: [Account] = setAccounts(from: ContentView().Accounts_Array_String)

/// Array of all cards stored in the application
var Cards_Array: [Card] = setCards(from: ContentView().Cards_Array_String)

/// Reads the Accounts Array, and generates a string interpreation which can be stored and translated back into an array later
func makeAccountsString(_ array: [Account]) -> String{
    var fileContents = ""
    
    //Going through every account and adding each field + dilimeter after each field
    for i in array {
        fileContents += String(i.Account_ID)                                                    //Appending the id of the account
        fileContents += "\n"
        
        fileContents += i.AccountUsername                                                       //Appending the username
        fileContents += "\n"
        
        fileContents += i.AccountPassword                                                       //Appending the password
        fileContents += "\n"
        
        fileContents += i.ProfilePictureString                                                  //Appending the string of the profile picture
        fileContents += "\n"
    }
    return fileContents
}

/// Reads the Cards Array, and generates a string interpreation which can be stored and translated back into an array later
func makeCardsString(_ array: [Card]) -> String{
    var fileContents = ""
    
    //Going through every account and adding each field + dilimeter after each field
    for i in array {
        fileContents += String(i.id)                                                            //Appending the id of the card
        fileContents += "\n"
        
        fileContents += i.cardName                                                              //Appending the card name
        fileContents += "\n"
        
        fileContents += i.URL                                                                   //Appending the url
        fileContents += "\n"
        
        fileContents += Encrypt(i.cardUsername)                                                 //Appending the username
        fileContents += "\n"
        
        fileContents += Encrypt(i.cardPassword)                                                 //Appending the password
        fileContents += "\n"
        
        fileContents += String(i.passwordStrength)                                              //Appending the password strength
        fileContents += "\n"
        
        //Stores a 'T' or 'F' character for boolean value
        if i.isFavourite {                                                                      //Appending the favourite status
            fileContents += "T"
        }
        else {
            fileContents += "F"
        }
        fileContents += "\n"
        
        fileContents += String(i.Account_ID)                                                    //Appending the id of the account which made the card
        fileContents += "\n"
    }
    return fileContents
}

/// Reads the Accounts String and generates an equivilant array of accounts
func setAccounts (from accountsString: String) -> [Account] {
    var array: [Account] = []
    
    //Flags determining what field is currently being read
    var readingId = true
    var readingUsername = false
    var readingPassword = false
    var readingIcon = false
    
    //Temporary variables for each account field
    var accountID = ""
    var username = ""
    var password = ""
    var icon = ""
    
    var doneField = false
    
    //Goes through each character in string
    for i in accountsString {
        
        doneField = false
        
        //If the current field is the ID:
        if readingId == true {
            if i == "\n" {                                                                      //If it is the end of the field:
                readingId = false                                                               //Move to the next field
                readingUsername = true
            }
            else {
                accountID += String(i)                                                          //Otherwise add the character to the ID
            }
        }
        
        //If the current field is the Username:
        else if readingUsername == true {
            if i == "\n" {                                                                      //If it is the end of the field:
                readingUsername = false                                                         //Move to the next field
                readingPassword = true
            }
            else {
                username += String(i)                                                           //Otherwise add the character to the Usename
            }
        }
        
        //If the current field is the Password:
        else if readingPassword == true {
            if i == "\n" {                                                                      //If it is the end of the field:
                readingPassword = false                                                         //Move to the next field
                readingIcon = true
            }
            else {
                password += String(i)                                                           //Otherwise add the character to the Password
            }
        }
        
        //If the current field is the Icon String:
        else if readingIcon == true {
            if i == "\n" {                                                                      //If it is the end of the field:
                readingIcon = false                                                             //Move to the next field
                readingId = true
            }
            else {
                icon += String(i)                                                               //Otherwise add the character to the Icon String
            }
        }
        
        if i == "\n" {
            doneField = true                                                                    //Checks if the current field is complete
        }
        
        //If all fields have a value and the last field is complete:
        if accountID != "" && username != "" && password != "" && icon != "" && doneField == true {
            
            //Create and add an account to the array
            array.append(Account(username, password, Int(accountID)!, icon))
            
            //Reset the current account fields
            accountID = ""
            username = ""
            password = ""
            icon = ""
        }
    }
    return array                                                                                //Return the interpreted array of accounts as a string
}

/// Reads the Cards String and generates an equivilant array of cards
func setCards(from cardsString: String) -> [Card] {
    var array: [Card] = []
    
    //Flags determining what field is currently being read
    var readingId = true
    var readingCardName = false
    var readingURL = false
    var readingUsername = false
    var readingPassword = false
    var readingPasswordStrength = false
    var readingisfav = false
    var readingAccountID = false
    
    //Temperary variables for each card field
    var ID = ""
    var name = ""
    var URL = ""
    var username = ""
    var password = ""
    var passwordStrength: String = ""
    var isfav: Bool = false
    var accountID = ""
    
    var doneField = false
    
    //Goes through each character in string
    for i in cardsString {
        
        doneField = false
        
        //If the current field is the ID:
        if readingId == true {
            if i == "\n" {                                                                      //If it is the end of the field:
                readingId = false                                                               //Move to the next field
                readingCardName = true
            }
            else {
                ID += String(i)                                                                 //Otherwise add the character to the Password
            }
        }
        
        //If the current field is the Card Name:
        else if readingCardName == true {
            if i == "\n" {                                                                      //If it is the end of the field:
                readingCardName = false                                                         //Move to the next field
                readingURL = true
            }
            else {
                name += String(i)                                                               //Otherwise add the character to the Password
            }
        }
        
        //If the current field is the URL:
        else if readingURL == true {
            if i == "\n" {                                                                      //If it is the end of the field:
                readingURL = false                                                              //Move to the next field
                readingUsername = true
            }
            else {
                URL += String(i)                                                                //Otherwise add the character to the Password
            }
        }
        
        //If the current field is the Username:
        else if readingUsername == true {
            if i == "\n" {                                                                      //If it is the end of the field:
                readingUsername = false                                                         //Move to the next field
                readingPassword = true
            }
            else {
                username += String(i)                                                           //Otherwise add the character to the Password
            }
        }
        
        //If the current field is the Password:
        else if readingPassword == true {
            if i == "\n" {                                                                      //If it is the end of the field:
                readingPassword = false                                                         //Move to the next field
                readingPasswordStrength = true
            }
            else {
                password += String(i)                                                           //Otherwise add the character to the Password
            }
        }
        
        //If the current field is the Password Strength:
        else if readingPasswordStrength == true {
            if i == "\n" {                                                                      //If it is the end of the field:
                readingPasswordStrength = false                                                 //Move to the next field
                readingisfav = true
            }
            else {
                passwordStrength += String(i)                                                   //Otherwise add the character to the Password
            }
        }
        
        //If the current field is the Favourite Preference:
        else if readingisfav == true {
            if i == "\n" {                                                                      //If it is the end of the field:
                readingisfav = false                                                            //Move to the next field
                readingAccountID = true
            }
            else {
                if i == "T" {                                                                   //If the Favourite Status is 'T' (True)
                    isfav = true                                                                //Then set the temperary Favourite Status to true
                }
            }
        }
        
        //If the current field is the Account ID:
        else if readingAccountID == true {
            if i == "\n" {                                                                      //If it is the end of the field:
                readingAccountID = false                                                        //Move to the next field
                readingId = true
            }
            else {
                accountID += String(i)                                                          //Otherwise add the character to the Password
            }
        }
        
        
        if i == "\n" {
            doneField = true                                                                    //Checks if the current field is complete
        }
        
        //If all fields have a value and the last field is complete:
        if ID != "" && name != "" && username != "" && password != "" && passwordStrength != "" && accountID != "" && doneField == true {
            
            //Create and add an account to the array
            array.append(Card(Int(ID)!, name, URL, Decrypt(username), Decrypt(password), Float(passwordStrength)!, isfav, Int(accountID)!))
            
            //Reset the current account fields
            ID = ""
            name = ""
            URL = ""
            username = ""
            password = ""
            passwordStrength = ""
            isfav = false
            accountID = ""
        }
    }
    return array                                                                                //Return the interpreted array of cards as a string
}
