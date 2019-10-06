# Swift Cpp Integeated code assignment

## Requirements
In the below I listed tools and versions that are used in the development:
* XCode 10.2.1
* Swift 5
* iOS 10+

## General Info:
## This simple project provide a very basic tableview and use cpp source file to parse required data. (Demonsteration of a cpp integration and usage in swift)
### Production files
I used MVP architecture to represent a clean structure.  The is source code hierarchy
- Resources: Where storyboards and production json file exist.
- View: Where view controller and related cell exist. 
- Network: Implementation of a simple service call. (both api and local implementations). There was an ambiguous definition in the exam description, about implementing a REST service call to an endpoint that by now not working. First I realized, it means there is a need for implementation of a real REST request ("GET") but later as I guess the purpose of it was just information. Anyway there are two implementation of service call, one from server (an api) and the other one local json reading service (local json resource io). 
- Model: I know the REST response was simple but this is a simple model of the response from server.
- Presenter: Where all logic happen here. Presenter uses service call in network layer.
- Parser: As mentioned in the exam documentation bonus point for implementing parser in c++, I did it here. there are Objc wrappers and C++ implementation of a very basic parser.
- I used git to track my codes, for someone who may care.

### Presenter
This is responsible for fetching numbers from service call and prepare table view data then used by view controller (table view). There is internal 'TableViewData' structure for this reason. And there is delegate to interact with view controller to show proper error messages.
Presenter is the only place that use NumberParser utility.

### View Controller
I didn't use storyboards. Simple view controller with a table view in it. I avoid implementing custom widget for checkbox because they are not builtin in iOS (rather than in Android) and instead I used a different label in the right section of the cell to show '√' if cell should be marked. I assume this was not requested in the exam to implement fancy UI.
For showing error states I used table view's background view. Errors will be shown there.

### Service call
There is service call protocol that different implementations derived from it. One is ServiceCallApi, that is just implemented but not used (explained in line 14 in this doc). And the ServiceCallLocal that is used by production and test.
Also there is a ServiceCallMock in the unit test for mocking purposes.

### Unit test files
- Presenter and parser are the only tested parts in the unit tests. for this reason I hired a basic mock service call that uses different json file for numbers.
- I did not implement UI tests because it seems it was unnecessary and in the exam description not mentioned. But in practice I usually implement it.
- Tests NumberParser initialization.
- Tests isCheck method.
- Tests getSection method.
- Tests getItem method.
- Tests presenter fetchNumbers method.
- Tests presenter delegate showErrorMessage.

### All about the parser
According to the descriptions, we have a number in a byte (0 to 255). This number is 8 bits. Our parser has three functionality.

* NumberParserImpl
Parser source file. minimal and basic class that acts as a utility with three functions.
- isChecked: checking if its most significant bit is 1 or 0 and returns a bool state. Shifting the number 7 bits to the right then we have the value.
- getSection: returns the number of two least significant bits of the number increased by one. "AND" our number with 3 (0x00000011) this is the result. 
- getItem: returns number between two of the above increased by one. First "OR" the number with 128 (0x1000000) so it's 1 for sure. then with "XOR" with 128 again to set the first bit to zero. finally we shift the value twice to the right. return the item increased by one.

* NumberParser
- Wrapper files. It calls cpp implementations and used in swift by importing in the bridge file (SimpleSwiftCppCode-Bridging-Header.h).
