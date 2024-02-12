#TodoListOverview
The TodoList application is a simple iOS app that allows users to view their tasks: completed and incompleted. The app doesn't have the ability to add or edit tasks.

##Architecture
The TodoList application follows the Model-View-Presenter (MVP) architecture pattern. The Presenter contains the Tasks (Model) and provides the prepared data to the View, which is implemented by the IView protocol. The View is responsible for rendering the prepared data, which is passed to it by the Presenter.

##Features
* Supports RegularTask and ImportantTask from TaskManager
* Tasks are sorted by priority
* The task can be marked as completed
* Uses MVP architecture pattern for data handling and rendering

##Getting StartedRequirements
* Xcode 14 or later
* Swift 5.5 or later
* iOS 14.0 or later

##Installation
* Extract the zip archive …
* Open the TodoList.xcodeproj file in Xcode
* Run the app on a simulator or device
