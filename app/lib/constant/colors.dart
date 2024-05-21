class AppColors {
  static int natural = 0xFF71D374;
  static int collaps = 0xFF757575;
  static int crash = 0xFFF53535;
  static int fight = 0xFFFFB01F;
  static int forestFire = 0xFFFF591C;
  static int residentFire = 0xFF871212;
  static int shooting = 0xFF13137F;
  static int theif = 0xFF1D1D1D;
  static int traffic = 0xFFFDFD3E;
  static int vandalism = 0xFFA74AA7;
  static int suspicious = 0xFF808080;
  static int danger = 0xFFFF0000;
  static int defaultColor = 0xFFFF5833;
  static int textNatural = 0xFF333333;
  static int textCollaps = 0xFFFFFFFF;
  static int textCrash = 0xFFFFFFFF;
  static int textFight = 0xFF212427;
  static int textForestFire = 0xFFFFFFFF;
  static int textResidentFire = 0xFFFFFFFF;
  static int textShooting = 0xFFFFFFFF;
  static int textTheif = 0xFFFFFFFF;
  static int textTraffic = 0xFF333333;
  static int textVandalism = 0xFFFFFFFF;
  static int textSuspicious = 0xFFFFFFFF;
  static int textDanger = 0xFFFFFFFF;
  static int textDefaultColor = 0xFFFFFFFF;

  static int getReportColor(String type) {
    switch (type) {
      case 'Natural Disaster':
        return natural;
      case 'Collaps':
        return collaps;
      case 'Crash':
        return crash;
      case 'Fight':
        return fight;
      case 'Forest Fire':
        return forestFire;
      case 'Resident Fire':
        return residentFire;
      case 'Shooting':
        return shooting;
      case 'Theif':
        return theif;
      case 'Traffic':
        return traffic;
      case 'Vandalism':
        return vandalism;
      case 'Suspicious':
        return suspicious;
      case 'Danger':
        return danger;
      default:
        return defaultColor;
    }
  }

  static int getReportTextColor(String type) {
    switch (type) {
      case 'Natural Disaster':
        return textNatural;
      case 'Collaps':
        return textCollaps;
      case 'Crash':
        return textCrash;
      case 'Fight':
        return textFight;
      case 'Forest Fire':
        return textForestFire;
      case 'Resident Fire':
        return textResidentFire;
      case 'Shooting':
        return textShooting;
      case 'Theif':
        return textTheif;
      case 'Traffic':
        return textTraffic;
      case 'Vandalism':
        return textVandalism;
      case 'Suspicious':
        return textSuspicious;
      case 'Danger':
        return textDanger;
      default:
        return textDefaultColor;
    }
  }
}
