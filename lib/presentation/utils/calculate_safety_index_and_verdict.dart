import 'package:flutter/material.dart';
import 'package:sih_1/models/beach_data_model.dart';

List<Object> getBeachVerdict(BeachDataList beachDataList) {
  // Assign weightings (example values, adjust as needed)
  Map<String, double> weights = {
    'wave_height': 0.3,
    'water_temp': 0.2,
    'wind_speed': 0.2,
    'rip_current_risk': 0.3,
  };

  // Score each parameter (1-5 scale, 5 being safest)
  Map<String, double> scores = {
    'wave_height': 5 -
        beachDataList.waveHeight!.waveHeightValue!
            .clamp(0, 5), // Lower height is safer
    'water_temp':
        ((beachDataList.waterTemperature!.waterTemperatureValue! - 10) / 5)
            .clamp(1, 5), // 15-25°C ideal
    'wind_speed': 5 -
        (beachDataList.windSpeed!.windSpeedValue! / 5)
            .clamp(0, 5), // Lower speed is safer
    'rip_current_risk': 5 -
        beachDataList
            .ripCurrentRisk!.ripCurrentRiskValue!, // Lower risk is safer
  };

  // Calculate safety factor
  double safetyFactor = weights.keys
      .map((param) => weights[param]! * scores[param]!)
      .reduce((a, b) => a + b);

  String safetyVerdict;
  Color markerColor;
  if (safetyFactor >= 0 && safetyFactor < 1) {
    safetyVerdict = 'Very Unsafe for Recreational Activities';
    markerColor = Colors.red;
  } else if (safetyFactor >= 1 && safetyFactor < 2) {
    safetyVerdict = 'Unsafe for Recreational Activities';
    markerColor = Colors.orange;
  } else if (safetyFactor >= 2 && safetyFactor < 3) {
    safetyVerdict = 'Moderately Safe for Recreational Activities';
    markerColor = Colors.yellow;
  } else if (safetyFactor >= 3 && safetyFactor < 4) {
    safetyVerdict = 'Safe for Recreational Activities';
    markerColor = Colors.lightGreen;
  } else if (safetyFactor >= 4 && safetyFactor <= 5) {
    safetyVerdict = 'Very Safe for Recreational Activities';
    markerColor = Colors.green;
  } else {
    safetyVerdict = 'Invalid safety factor value';
    markerColor = Colors.grey;
  }

  return [
    double.parse(safetyFactor.toStringAsFixed(2)),
    safetyVerdict,
    markerColor
  ];
}
