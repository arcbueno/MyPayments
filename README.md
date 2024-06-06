# MyPayments

## Docs
This app uses 3 libraries: 
1. flutter_bloc -> State management library
2. get_it -> Dependency injection library
3. result_dart -> Result treatment library 

## Architecture
![App architecture](AppArch.png)

The users available are: 
1. Verified user 
    email: verified@email.com
    password: 12345
2. Unverified user
    email: unverified@email.com
    password: 12345

To run with some data already filled, run
```
flutter run --dart-define useTestData=true
```
