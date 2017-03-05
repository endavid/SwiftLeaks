Enum Leaks
-------------

Profile this code with Instruments Leaks and you will find an unexpected leak:

![ho](https://i.stack.imgur.com/JmjSG.png)

Configuration
--------------
AFAIK, it leaks in this configuration
* Swift 3, Xcode 8.2.1 (8C1002), iOS 10.2


Discussion
-----------

http://stackoverflow.com/questions/42602301/swift-3-enums-leak-memory-when-the-class-contains-an-array

