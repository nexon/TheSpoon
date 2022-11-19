# The Spoon 

## Requirements
- This project was build with Xcode 14.1 and the minimum version of iOS 12.
- All the UI interface was made in code. No xibs/storyboard as required.

## How to compile
You just need to open the file (`TheSpoon.xcodeproj`) on Xcode and compile. This project doesn't have any 3rd parties dependencies.

## What you can do
- See the list of Restaurants
- See information like `name`, `Address`, `Price Range`, `Cousine Type` and `Rating` for each individual Restaurant
- See if a Restaurant is a Favorite for the user that is running the app.
- Be able to make a restaurant to be a favorite (clicking the Heart on the top-right corner).
- Sorting the List of Restaurants by name or Rating.

## Technical Implementation
This Project was implemented with a single `UIViewController` as an entry point that contains a list (`UITableView`) that will show the list of Restaurants.

As what kind of patterns are we using, I went for a simple `MVVM`. To architect the app. And I also add Dependency Containers, `Repositories` and Stores (Strategy Pattern).

We also have `Entities` and `DTOs`. Entities represent information in the App, while the DTOs represent the information from the backend and know how to make it available on our app.

In the `Store` we ask for the data to the backend. Giving us back the `DTOs`. After that, the `Repository` will be in charge of converting those `DTOs` into Entities that the App Layer will use to display information.

## Possible Difficulties