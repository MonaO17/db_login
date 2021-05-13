//https://www.youtube.com/watch?v=LJH8UI8E1Lw&list=PLDQl6gZtjvFu5l20K5KTEBLCjfRjHowLj&index=5

// SQLite Database: SQLite is an in-process library that implements a
//      - self-contained (= minimal support from external libraries, good for platform-independent application),
//      - serverless (= reads & writes directly from the db files on disk/file system of Android or iOS device),
//      - zero-configuration (= requieres no installation and no setup),
//      - transactional (= all changes in a transaction occur completely or not at all)
// SQL database engine.

// SQFlite DB: To use a SQlite DB in Flutter there is a Plugin called "SQFlite" that allows you to access SQLite DB in both Android and iOS.
// To use SQFlite you have to include it's dependency in the pubspec.yaml file

// The SQFlite plugin only deals with MAP objects!!!
//      - you can only save data to the SQLite DB in the form of a map object  => before saving data to the DB, you need to convert the data into a MAP!!!
//      - the plugin also just retrieves the data from the SQLite DB in form of a map object => when you retrieve data from the DB you get a MAP object. You need to convert it to a simple object before using it!!!
// SQLite Requirement:
//      - Model Class (To represent the (Note) object),
//      - Database helper (to perform CRUD(Insert, Update, Query, Delete) operation),
//      - Put it all together (connect DB to UI)



class User {
  int _id;
  String _name;
  String _password;
  int _counter;

  // constructor
  User(this._name, this._password, [this._counter]); // [] makes the description optional!

  // named constructor
  User.withID(this._name, this._password, [this._counter]);                     // MIT ID ??????

  // getters
  int get id => _id;
  String get name => _name;
  String get password => _password;
  int get priority => _counter;

  // setters
  //id is generated automatically
  set name(String newName) {
    //if (newTitle.length <= 255 {
    this._name = newName;
    //}
  }

  set password(String newPW) {
    this._password = newPW;
  }

  set priority(int newPriority) {
    if (newPriority >= 1 && newPriority <= 2) {
      this._counter = newPriority;
    }
  }

  //Convert a User object into a Map object
  Map<String, dynamic> toMap() {
    //map['id] etc are all Strings ('id', 'title', 'description'...) but on the right as a value we have Strings and ints => therefore we use dynamic.
    //if we would only have values of type int, we could define the Map as "Map<String, int> to Map()"
    //instanciate map object
    var map = Map<String, dynamic>();

    map['id'] = _id;
    if (id != null) {
      // check if id is null or not, depending on if it is used for insert or update
      map['id'] = _id;
    }
    map['name'] = _name;
    map['password'] = _password;
    map['counter'] = _counter;

    return map;
  }

  //Extract a User object from a Map object
  User.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._password = map['password'];
    this._counter = map['counter'];
  }
}
