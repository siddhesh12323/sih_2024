class BeachDataList {
  BeachPosition? beachPosition;
  WaveHeight? waveHeight;
  WaterTemperature? waterTemperature;
  WindSpeed? windSpeed;
  WindDirection? windDirection;
  RipCurrentRisk? ripCurrentRisk;
  WaterQuality? waterQuality;
  BeachSlope? beachSlope;
  SafetyFactor? safetyFactor;
  String? sId;
  String? beachName;
  String? state;
  List<String>? area;
  List<String>? hazards;
  String? image;
  int? v;

  BeachDataList(
      {this.beachPosition,
      this.waveHeight,
      this.waterTemperature,
      this.windSpeed,
      this.windDirection,
      this.ripCurrentRisk,
      this.waterQuality,
      this.beachSlope,
      this.safetyFactor,
      this.sId,
      this.beachName,
      this.state,
      this.area,
      this.hazards,
      this.image,
      this.v});

  BeachDataList.fromJson(Map<String, dynamic> json) {
    beachPosition = json['position'] != null
        ? BeachPosition.fromJson(json['position'])
        : null;
    waveHeight = json['wave_height'] != null
        ? WaveHeight.fromJson(json['wave_height'])
        : null;
    waterTemperature = json['water_temperature'] != null
        ? WaterTemperature.fromJson(json['water_temperature'])
        : null;
    windSpeed = json['wind_speed'] != null
        ? WindSpeed.fromJson(json['wind_speed'])
        : null;
    windDirection = json['wind_direction'] != null
        ? WindDirection.fromJson(json['wind_direction'])
        : null;
    ripCurrentRisk = json['rip_current_risk'] != null
        ? RipCurrentRisk.fromJson(json['rip_current_risk'])
        : null;
    waterQuality = json['water_quality'] != null
        ? WaterQuality.fromJson(json['water_quality'])
        : null;
    beachSlope = json['beach_slope'] != null
        ? BeachSlope.fromJson(json['beach_slope'])
        : null;
    safetyFactor = json['safety_factor'] != null
        ? SafetyFactor.fromJson(json['safety_factor'])
        : null;
    sId = json['_id'];
    beachName = json['beach_name'];
    state = json['state'];
    area = json['area'].cast<String>();
    hazards = json['hazards'].cast<String>();
    image = json['image'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (beachPosition != null) {
      data['position'] = beachPosition!.toJson();
    }
    if (waveHeight != null) {
      data['wave_height'] = waveHeight!.toJson();
    }
    if (waterTemperature != null) {
      data['water_temperature'] = waterTemperature!.toJson();
    }
    if (windSpeed != null) {
      data['wind_speed'] = windSpeed!.toJson();
    }
    if (windDirection != null) {
      data['wind_direction'] = windDirection!.toJson();
    }
    if (ripCurrentRisk != null) {
      data['rip_current_risk'] = ripCurrentRisk!.toJson();
    }
    if (waterQuality != null) {
      data['water_quality'] = waterQuality!.toJson();
    }
    if (beachSlope != null) {
      data['beach_slope'] = beachSlope!.toJson();
    }
    if (safetyFactor != null) {
      data['safety_factor'] = safetyFactor!.toJson();
    }
    data['_id'] = sId;
    data['beach_name'] = beachName;
    data['state'] = state;
    data['area'] = area;
    data['hazards'] = hazards;
    data['image'] = image;
    data['__v'] = v;
    return data;
  }
}

class BeachPosition {
  double? lat;
  double? long;

  BeachPosition({this.lat, this.long});

  BeachPosition.fromJson(Map<String, dynamic> json) {
    lat = json['lat']?.toDouble();
    long = json['long']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}

class WaveHeight {
  double? waveHeightValue;
  String? waveHeightUnit;

  WaveHeight({this.waveHeightValue, this.waveHeightUnit});

  WaveHeight.fromJson(Map<String, dynamic> json) {
    waveHeightValue = json['wave_height_value']?.toDouble();
    waveHeightUnit = json['wave_height_unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wave_height_value'] = waveHeightValue;
    data['wave_height_unit'] = waveHeightUnit;
    return data;
  }
}

class WaterTemperature {
  double? waterTemperatureValue;
  String? waterTemperatureUnit;

  WaterTemperature({this.waterTemperatureValue, this.waterTemperatureUnit});

  WaterTemperature.fromJson(Map<String, dynamic> json) {
    waterTemperatureValue = json['water_temperature_value']?.toDouble();
    waterTemperatureUnit = json['water_temperature_unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['water_temperature_value'] = waterTemperatureValue;
    data['water_temperature_unit'] = waterTemperatureUnit;
    return data;
  }
}

class WindSpeed {
  double? windSpeedValue;
  String? windSpeedUnit;

  WindSpeed({this.windSpeedValue, this.windSpeedUnit});

  WindSpeed.fromJson(Map<String, dynamic> json) {
    windSpeedValue = json['wind_speed_value']?.toDouble();
    windSpeedUnit = json['wind_speed_unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wind_speed_value'] = windSpeedValue;
    data['wind_speed_unit'] = windSpeedUnit;
    return data;
  }
}

class WindDirection {
  String? windDirectionValue;
  String? windDirectionUnit;

  WindDirection({this.windDirectionValue, this.windDirectionUnit});

  WindDirection.fromJson(Map<String, dynamic> json) {
    windDirectionValue = json['wind_direction_value'];
    windDirectionUnit = json['wind_direction_unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wind_direction_value'] = windDirectionValue;
    data['wind_direction_unit'] = windDirectionUnit;
    return data;
  }
}

class RipCurrentRisk {
  double? ripCurrentRiskValue;
  String? ripCurrentRiskUnit;

  RipCurrentRisk({this.ripCurrentRiskValue, this.ripCurrentRiskUnit});

  RipCurrentRisk.fromJson(Map<String, dynamic> json) {
    ripCurrentRiskValue = json['rip_current_risk_value']?.toDouble();
    ripCurrentRiskUnit = json['rip_current_risk_unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rip_current_risk_value'] = ripCurrentRiskValue;
    data['rip_current_risk_unit'] = ripCurrentRiskUnit;
    return data;
  }
}

class WaterQuality {
  String? waterQualityValue;
  String? waterQualityUnit;

  WaterQuality({this.waterQualityValue, this.waterQualityUnit});

  WaterQuality.fromJson(Map<String, dynamic> json) {
    waterQualityValue = json['water_quality_value'];
    waterQualityUnit = json['water_quality_unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['water_quality_value'] = waterQualityValue;
    data['water_quality_unit'] = waterQualityUnit;
    return data;
  }
}

class BeachSlope {
  double? beachSlopeValue;
  String? beachSlopeUnit;

  BeachSlope({this.beachSlopeValue, this.beachSlopeUnit});

  BeachSlope.fromJson(Map<String, dynamic> json) {
    beachSlopeValue = json['beach_slope_value']?.toDouble();
    beachSlopeUnit = json['beach_slope_unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['beach_slope_value'] = beachSlopeValue;
    data['beach_slope_unit'] = beachSlopeUnit;
    return data;
  }
}

class SafetyFactor {
  double? safetyFactorValue;
  String? safetyFactorUnit;

  SafetyFactor({this.safetyFactorValue, this.safetyFactorUnit});

  SafetyFactor.fromJson(Map<String, dynamic> json) {
    safetyFactorValue = json['safety_factor_value']?.toDouble();
    safetyFactorUnit = json['safety_factor_unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['safety_factor_value'] = safetyFactorValue;
    data['safety_factor_unit'] = safetyFactorUnit;
    return data;
  }
}
