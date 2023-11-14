# Gymondo

[![License](https://img.shields.io/cocoapods/l/JNMentionTextView.svg?style=flat)](https://cocoapods.org/pods/JNMentionTextView)
[![Platform](https://img.shields.io/cocoapods/p/JNMentionTextView.svg?style=flat)](https://cocoapods.org/pods/JNMentionTextView)

**Gymondo** A swift application displays the most trending exercises.



## Preview

<img src="https://github.com/ihmouda/Gymondo/raw/main/Gymondo/Resources/Images/preview.gif" width="260"/>


## Requirements

- Xcode 14+
- iOS 15.0+
- Swift 5+


## Installation

you will need to have Git installed on your system. If you don't have Git installed, you can download it from the official website: [Git Downloads](https://git-scm.com/downloads)
.
Once you have Git installed, you can clone this repository to your local machine using the following command:

```swift
git clone https://github.com/ihmouda/Gymondo.git
```

## Data Source:

We are consuming the free and open-source API for [wger.de](https://wger.de/de/software/api) fitness tracker platform.


## Usage:

This project serves as a curated list for [wger.de](https://wger.de/de/software/api) fitness and workout operations. You can explore the exercises listed here to find exercises with supporting details, images and variations.

When select a specific exercise item, a detail view will appear with additional info. You can check item's details, images and variations.

## Project Structure:

The structure of our project is based on grouping by function, where we grouped all related swift files into one folder. Ex. Utils / Views / …etc.

## Architecture:

The project is UIKit-based app, with one UIKit view [ActivityIndicator](https://github.com/ihmouda/Gymondo/raw/main/Gymondo/Utils/ActivityIndicator.swift). The remaining views are SwiftUI components, integrated to the UIKit environment by wrapping a SwiftUI View into a UIHostingController:


- **Design Pattern:** Model View View Model - Coordinator (MVVM-C):

    We applied the “MVVM-C” design pattern as the basic design pattern in our app, as derivation from "MVVM" design pattern, by adding a coordinator layer to manage app navigation, passing data between view controllers, and handling user actions:

    - **View:**
    UI elements & visual elements that can viewed and interact with . They are typically subclass from UIView. (The ViewController is exist in MVVM  in View but it’s role is minimized.).

    - **Model:**
    Hold data. Struct / Class. And it must be isolated from business logic (data is returned). For testable/reusable/maintainable.

    - **ViewModel:**
    Transform model object into values are ready to appear on the screen.

    - **Coordinator:**
    The coordinator layer handles the app’s navigation flow.
    
    
- **Service Layer:**

    Is abstract layer separate between the domain and data layer using a collection-like interface. here we  adherence the SOLID Principles by: 
    
    
    - **Single Responsibility:**
    The service layer performs one task, managing communication with one service.

    - **Open Closed Principle:**
    Service layer is open to extension as long as it conforms to the service protocol. And closed for modification.

    - **Liskov Substitution principle:**
    Every concrete implementation of the Service protocol must confirm to the Service protocol and injected in the manager initialization method.
    
    - **Dependency inversion principle:**
    The manager doesn’t need to know any details about the service implementation.
    
    
## Utils:
  
- **ErrorView:**
        
    A helper view to show error alert.

 - **ActivityIndicator:**
      
    A helper view for showing loading activity indicator.
        
- **HTMLTextView:**
        
    A helper view to convert HTML string to plain text in Swift.

## Work Process:

1. Analyze the assignment requirements and specify the required functional and non-functional requirements.
2. Create a UI design using Sketch design tool for the required screens.
3. Translate the requirements into a code design using “Miro” project management tool.
4. Start the code development process.
5. Write unit testing  
6. Test, review, optimize and document the code.
7. Push the code to remote Github repository.

## Contributing:

 **If you would like to contribute to this repository and add a GitHub repository that you find valuable, follow the steps below:**

1. Fork this repository.
2. Create a new branch with a descriptive name:

    ```swift
    git checkout -b your-branch-name
    ```
3. Update your README file.
4. Commit your changes: git commit -am 'Add new repository: repository-name'.
5. Push to the branch: git push origin your-branch-name.
6. Open a pull request in this repository, explaining the repository you are adding and why you find it valuable.

**Please ensure that any repositories you add are relevant, well-maintained, and provide value to the community.**
 
## Author

Mohammad Ihmouda

## License

Gymondo is available under the MIT license. See the [LICENSE](https://github.com/ihmouda/Gymondo/blob/master/LICENSE) file for more info.

