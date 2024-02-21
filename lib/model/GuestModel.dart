// To parse this JSON data, do
//
//     final infoAcara = infoAcaraFromJson(jsonString);

// ignore_for_file: prefer_null_aware_operators, unnecessary_null_comparison

class GuestModel {
  List<GuestModelKeyValue>? guest;

  GuestModel({
    List<GuestModelKeyValue>? guest,
  }) : guest = guest ?? [GuestModelKeyValue(), GuestModelKeyValue()];

  factory GuestModel.fromJson(List<dynamic> json) {
    return GuestModel(
      guest: json != null
          ? json
              .map(
                (x) => GuestModelKeyValue.fromJson(
                  x as Map<String, dynamic>,
                ),
              )
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "Guest": List<dynamic>.from(guest!.map((x) => x.toJson())),
      };
}

class GuestModelKeyValue {
  String? name;
  bool? attendance;
  bool share;
  String? guestId;
  String? phone;

  GuestModelKeyValue({
    this.guestId = "0",
    this.attendance = false,
    this.share = false,
    this.name = "Example",
    this.phone = "12345678",
  });

  factory GuestModelKeyValue.fromJson(Map<String, dynamic> json) =>
      GuestModelKeyValue(
        guestId: json["GuestId"],
        name: json["Name"],
        attendance: json["Attend"],
        share: json["Share"],
        phone: json["Phone"],
      );

  Map<String, dynamic> toJson() => {
        "GuestId": guestId,
        "Name": name,
        "Phone": phone,
        "Attend": attendance,
        "Share": share,
      };
}
