class NotificationSettings {
  bool notification1;
  bool notification2;
  bool notification3;
  bool notification4;
  bool notification5;
  bool email1;
  bool email2;
  bool email3;
  bool email4;
  bool email5;

  NotificationSettings(
    this.notification1,
    this.notification2,
    this.notification3,
    this.notification4,
    this.notification5,
    this.email1,
    this.email2,
    this.email3,
    this.email4,
    this.email5,
  );

  NotificationSettings.fromJson(Map<String, dynamic> json)
      : notification1 = json['notification1'],
        notification2 = json['notification2'],
        notification3 = json['notification3'],
        notification4 = json['notification4'],
        notification5 = json['notification5'],
        email1 = json['email1'],
        email2 = json['email2'],
        email3 = json['email3'],
        email4 = json['email4'],
        email5 = json['email5'];

  Map<String, dynamic> toJson() => {
        'notification1': notification1,
        'notification2': notification2,
        'notification3': notification3,
        'notification4': notification4,
        'notification5': notification5,
        'email1': email1,
        'email2': email2,
        'email3': email3,
        'email4': email4,
        'email5': email5,
      };
}
