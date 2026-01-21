class Database {
  final database = Database();

  final Map<String, String> users = {};

  bool registerUser(String username, String password) {
    if (users.containsKey(username)) {
      return false; // user already exists
    }
    users[username] = password;
    return true;
  }

  bool loginUser(String username, String password) {
    if (!users.containsKey(username)) {
      return false; // user not found
    }

    if (users[username] != password) {
      return false; // wrong password
    }

    return true; // login success
  }
}
