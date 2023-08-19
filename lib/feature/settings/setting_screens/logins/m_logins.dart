enum LoginDeviceType {
  app,
  browser,
}

class Login {
  final String device;
  final String ipAddress;
  final String location;
  final bool successfull;
  final LoginDeviceType deviceType;

  Login(
    this.device,
    this.ipAddress,
    this.location,
    this.successfull,
    this.deviceType,
  );

  Login.fromJson(Map<String, dynamic> json)
      : device = json['device'],
        ipAddress = json['ipAddress'],
        location = json['location'],
        deviceType = json['deviceType'],
        successfull = json['successfull'];
}
