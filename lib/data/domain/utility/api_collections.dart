class ApiCollections {
  static String collection(String endPoint) {
    return 'collections/$endPoint/records';
  }

  static String users = collection(users);
}
