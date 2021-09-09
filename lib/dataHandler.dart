class ListOfDataPoints {
  static var latitudeList = [];
  static var longitudeList = [];

  static void addToList(double lat, double lng) {
    latitudeList.add(lat);
    longitudeList.add(lng);
  }

  static void clearList() {
    latitudeList.clear();
    longitudeList.clear();
  }

  static String getData() {
    String data = "";
    if (latitudeList.length > 0) {
      data = "${latitudeList[0]} , ${longitudeList[0]}";
    }
    for (int i = 1; i < latitudeList.length; i++) {
      data = data + "\n${latitudeList[i]} , ${longitudeList[i]}";
    }
    return data;
  }
}
