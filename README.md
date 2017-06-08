# StatUpCodingChallenge
A simple notepad application posting to an AWS SNS topic.

This is a simple application in which the user can type a message.  On load, the application makes an API call to get the word of the day from dictionary.com.  

When the user types in that word, two things happen: 

A toast message is shown to notify user that he has just typed the Word of the day and should shake the device. Simultaneously, 
the existing text entered by the user as well as his name along with the Word of the day API output 
and the URL to the source repository are posted to an AWS SNS topic.

Once the device is shaken, a message above the keyboard shows the word of the day for 5 seconds.  If the message is clicked, the definition of the word is shown in a dialog.

In addition to the message editor, the user can edit his or her name from a settings dialog.


The API at http://developer.wordnik.com/ is used.

An AWS SDK library with Cognitio support is used along with the following credentials.  

Identity Pool ID:
us-west-2:0c57a6ca-b882-4ca7-ab96-d2cac360a80c and 
Region:
us-west-2.  
SNS topic to publish to: 
arn:aws:sns:us-west-2:327210751071:statup-challenge-push

The application supports devices of different sizes.

Before running the application, run pod install to install the dependencies using Cocoapods and then Clean, Build and Run the application.
