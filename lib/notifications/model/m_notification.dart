class Notification {
  final int notificationId;
  final DateTime creationDateTime;
  final String notificationType;
  final String notificationTitle;
  final String notificationBody;
  final bool read;
  final bool seen;

  Notification(
    this.notificationId,
    this.creationDateTime,
    this.notificationType,
    this.notificationTitle,
    this.notificationBody,
    this.read,
    this.seen,
  );

  Notification.fromJson(Map<String, dynamic> json)
      : notificationId = json['notificationId'],
        creationDateTime = DateTime.parse(json['creationDateTime']),
        notificationType = json['notificationType'],
        notificationTitle = json['notificationTitle'],
        notificationBody = json['notificationBody'],
        read = json['read'],
        seen = json['seen'];

  Map<String, dynamic> toJson() => {
        'notificationId': notificationId,
        'notificationType': notificationType,
        'notificationTitle': notificationTitle,
        'notificationBody': notificationBody,
        'read': read,
        'seen': seen,
      };
}
