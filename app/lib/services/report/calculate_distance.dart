import 'dart:math';

class CalculateDistance {
  static double getDistance(
      double lat1, double long1, double lat2, double long2) {
    double R = 6371;
    double dLat = degToRad(lat2 - lat1);
    double dLon = degToRad(long2 - long1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(degToRad(lat1)) *
            cos(degToRad(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double d = R * c;
    return d;
  }

  static double degToRad(double deg) {
    return deg * (3.14159 / 180);
  }
}
