# JASON

<!-- [![CI Status](http://img.shields.io/travis/julianAlonso/JASON.svg?style=flat)](https://travis-ci.org/julianAlonso/JASON) -->
[![Version](https://img.shields.io/cocoapods/v/JASON.svg?style=flat)](http://cocoapods.org/pods/JASON)
[![License](https://img.shields.io/cocoapods/l/JASON.svg?style=flat)](http://cocoapods.org/pods/JASON)
<!-- [![Platform](https://img.shields.io/cocoapods/p/JASON.svg?style=flat)](http://cocoapods.org/pods/JASON) -->

## What?
So simple, library to parse JSON Objects.

## Where is the value?

### Really simple to use.

To make objects created by json you only need implement `ExpressibleByJSON` like this:
```
struct Person {
  let name: String
  let age:  Int
}
extension Person: ExpressibleByJSON {
  init(_ json: JSON) throws {
    self.name = try json <<< "name"
    self.age  = try json <<< "age"
  }
}
```

Then create the object:
```
  session.dataTaskWithRequest(someRequest) { data, response, error in
    if let data = data {
      do {
        let json = try JSON(data)
        let person = try Person(json)
      } catch {
        //Elevate error...
      }
    }
  }
```


## Forgot optional types.

Yes, right now, you can forgot parsing json like this:

```swift

  if let string = json["string"] as? String {
    //Do something...
  }

```

JASON works with operators, `<<<` for all types and `<<<?` for optional types.
The usage its simply, get the JSON object (provided by JASON), and get fields.

If you want a string:
`let string = try json <<< "name" as String`, (if the type is previus declarated like in classes or structs, you dont need the as keyword)

And optional types are the same, but using the optional operator that not throws an error.
`let optionalString: String? = json <<<? "name"`

JASON also will infer types for us, any type that implements `ExpressibleByJSON` or `ConvertibleFromJSON` can be parsed, by this way, all the types that you want can be parsed.
This allow us to have nested types, parse arrays and dictionarys in the most simple way possible and of course, on failing cases will provide us **very useful debug info**

**¿Why throwing?**
We know that some type requires some fiels, and some fields arent optional, when we got that situation, why we unwrapp optionals all the time?
We spent a lot of time taking care about this errors, proccessing it, logging some info...
We don't need optional parsing when types aren't optional, we need not optional types, then we throw very **useful** errors.

When we parse JSON objects and the parsing proccess fails, we want get info about the error, something like `required field "name" not found`, or `trying cast String to Int`, whatever... But we not only want this, when we are making complex request  with nested objects, we also want know what object has failed. JASON provide all that data for us.
When something fail, the error will print `required fild "name" not found at Person.self` for example.

## Extending framework types.

Yes, you can directly parse Foundation or whatever framework type. URL for example. We want cast strings into URL directly then...

```swift

///Create an extension of type implementing ConvertibleFromJSON
extension URL: ConvertibleFromJSON {

    /// We only need the method from(_, at:), with this, we create the URL
    /// casting the given data, and taking care about possible casting errors.
    ///
    /// at: String its provided to us to bring the possiblity of give information about the parsing object.
    public static func from(_ object: Any, at: String) throws -> URL {
        guard let string = object as? String else {
            throw JASONError.TryingCast(object: object, to: "String", at: at)
        }
        guard let url = URL(string: string) else {
            throw JASONError.TryingCast(object: object, to: "URL", at: at)
        }

        return url
    }

}

```


## Your custom types

And when we have nested objects, our objest only need implement `ExpressibleByJSON`, like `Person` declared above.
Then we can parse `Persons` like parse `String`
```
let person: Person = try json <<< "person"
```

And not only that!
JASON also will parse for you arrays of persons if you want. when you have a JSON like this...

```json

{
    "employees": [{
                  "name": "Ram",
                  "email": "ram@gmail.com",
                  "age": 23
                  }, {
                  "name": "Shyam",
                  "email": "shyam23@gmail.com",
                  "age": 28
                  }, {
                  "name": "John",
                  "email": "john@gmail.com",
                  "age": 33
                  }, {
                  "name": "Bob",
                  "email": "bob32@gmail.com",
                  "age": 41
                  }]
}
```

We only do this:
```swift
let employees: [Employee] = try json <<< "employees"
```
And all work done.

## No key needed

If your json data comes without key, you can parse it too.

```json

[{
"name": "Ram",
"email": "ram@gmail.com",
"age": 23
}, {
"name": "Shyam",
"email": "shyam23@gmail.com",
"age": 28
}, {
"name": "John",
"email": "john@gmail.com",
"age": 33
}, {
"name": "Bob",
"email": "bob32@gmail.com",
"age": 41
}]

```

```swift

let employees = try json<<< as [Employee]

```

## Installation

JASON is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "JASON-swift"
```

## Author

Julián Alonso, julian.alonso.dev@gmail.com

## License

JASON is available under the MIT license. See the LICENSE file for more info.
