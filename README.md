# JetFuel Take Home Exercise

Although I am experienced with objective-c I had decided to do this assignment in Swift due to the Time Constraint, and Syntax Simplicity.

## Process WalkThrough
I began by looking thoroughly throw the JSON and pasting it into a lint to address what each component refers to. After I got a solid feel for the API, I began to look through the Sketch File to see which components went into each object.
   - First thing I noticed is that there is a `CollectionView` within the `TableCell` and I handled it by having custom classes for both Views
   - After setting the `datasource` and `delegate` to the `RootViewController` I began adding the individual UI Elements into the Views
   - I then added the button functionality using the `UIPasteBoard` for copying the link and `Photos` for saving media to the user library
   - In order to notify the user that the media has been saved, or the link has been copied, I utilized the `SwiftNotice` library for simple toast alerts.
   - When implementing the inline video I used the `MPMoviePlayerController` to play media full screen

## Bonus Responses
##### Can you add pull-to-refresh?
I used the UIRefreshControl default library in UIKit to conduct another API call to the endpoint and to refresh the TableView after the new data has been downloaded

##### What steps can you take to optimize the load time of cover photos? How about the scroll performance?
For optimizing the load time of the photos a library like `SDWebImage` can be used to cache the photos before load and placing a placeholder image while the image downloads. For improving the scrolling performance on the backend side, pagination can be used to split up `campaigns` and `medias` to display only a set amount of data at the same time. Then dynamically loading the new data values once the end of the `TableView` or `CollectionView` are reached. In terms of the frontend, reusable cells that are preregistered into the `TableView` or `CollectionView` to improve performance.
