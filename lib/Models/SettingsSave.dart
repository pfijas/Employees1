class SettingsSave {
  DeviceInfo? devideInfo; // Corrected the typo here
  List<SettingsList>? settingsList;

  SettingsSave({this.devideInfo, this.settingsList});

  SettingsSave.fromJson(Map<String, dynamic> json) {
    devideInfo = json['DevideInfo'] != null
        ? new DeviceInfo.fromJson(json['DevideInfo']) // Corrected the typo here
        : null;
    if (json['SettingsList'] != null) {
      settingsList = <SettingsList>[];
      json['SettingsList'].forEach((v) {
        settingsList!.add(new SettingsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.devideInfo != null) {
      data['DevideInfo'] = this.devideInfo!.toJson();
    }
    if (this.settingsList != null) {
      data['SettingsList'] = this.settingsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DeviceInfo {
  String? deviceId;

  DeviceInfo({this.deviceId});

  DeviceInfo.fromJson(Map<String, dynamic> json) {
    deviceId = json['DeviceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DeviceId'] = this.deviceId;
    return data;
  }
}


class SettingsList {
  String? identifierKey;
  String? identifierValue;

  SettingsList({this.identifierKey, this.identifierValue});

  SettingsList.fromJson(Map<String, dynamic> json) {
    identifierKey = json['IdentifierKey'];
    identifierValue = json['IdentifierValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdentifierKey'] = this.identifierKey;
    data['IdentifierValue'] = this.identifierValue;
    return data;
  }
}