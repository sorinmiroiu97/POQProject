# POQProject
Just a small poc project

I used SwiftUI in this project and async/await for the first time in a small, yet easy to scale networking layer. Of course the networking layer is in a pretty basic state since the requirement didn't ask for any multipart/form-data request or anything fancy, it was a simple get request. I used async/await but provided capability for using the combine's publisher approach of making requests. Both variants work in the exact same way. I didn't use Actors because I didn't get the chance to work with them yet, but I'm eager to learn more on that.
I chose to target ios 16 for the sole purpose of using the new navigation stack api, on which I wrote a more detailed blog post [here][blogPost].
I went with SwiftUI because I didn't have any constraints and I love it, even though it was used on a very minimal level, but even so it was a pleasure to code this small project.
I provided some unit tests. I didn't have the chance to work with ui tests yet, but it's something that I'd definitely want to learn and try out.

[blogPost]: https://wizlabsystems.com/2022/08/03/mastering-the-new-ios-16-navigation-api-in-swiftui/