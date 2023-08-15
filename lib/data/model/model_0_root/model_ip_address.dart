class ModelIpAddress {
  dynamic ip;

  ModelIpAddress({
    required this.ip,
  });

  factory ModelIpAddress.fromJson(Map<String, dynamic> json) => ModelIpAddress(
    ip: json["ip"],
  );

  Map<String, dynamic> toJson() => {
    "ip": ip,
  };
}
