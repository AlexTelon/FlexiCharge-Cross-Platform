# FlexiCharge-Cross-Platform
## Architecture
### Stacked Architecture
TODO
https://www.filledstacks.com/post/flutter-and-provider-architecture-using-stacked/

## Services
Used mostly when accessing the API and making requests
https://www.filledstacks.com/post/services-in-code-and-how-to-use-them-in-flutter/

## LocalData
A class that enables us to save variables into an object that we can access from anywhere. Unified place to find common variables used on several occasions across the whole app.

## Models
A way to map data to a class. Used to map json-objects from the API into usable data-classes.

# Workflow
Documentation about how certain actions are performed within the app, steps needed and in what order etc.
## Connect to charger
When a valid charger ID has been entered we want to reserve the charger during the payment process.
Then, we create a transaction session and recive a transaction object back from the API.
This transaction object contains a transactionID that we need when getting a authentication token from Klarna.
The authentication token from Klarna can then be used to update our transaction object that verifies that our transaction was successful.

In snappingsheet_viewmodel.dart, the connect function solves this.
