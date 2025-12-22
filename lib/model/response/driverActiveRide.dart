class GetActiveRide {
  List<dynamic>? data;
  bool? success;
  String? message;

  GetActiveRide({
    this.data,
    this.success,
    this.message,
  });

  factory GetActiveRide.fromJson(Map<String, dynamic> json) => GetActiveRide(
    data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
    "success": success,
    "message": message,
  };
}
