class Scan {
  final int scanId;
  final int petProfileId;
  final DateTime scanDateTime;
  final String scanIpAddress;

  Scan(
    this.scanId,
    this.petProfileId,
    this.scanDateTime,
    this.scanIpAddress,
  );

  Scan.fromJson(Map<String, dynamic> json)
      : scanId = json['scan_id'],
        petProfileId = json['petProfile_id'],
        scanDateTime = DateTime.parse(json['scan_DateTime']),
        scanIpAddress = json['scan_ip_address'];
}
