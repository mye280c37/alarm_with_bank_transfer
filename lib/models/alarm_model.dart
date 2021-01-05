class Alarm {
  int id;
  DateTime alarmDateTime;
  bool isPending;
  bool mon;
  bool tue;
  bool wed;
  bool thu;
  bool fri;
  bool sat;
  bool sun;

  Alarm({
    this.id,
    this.alarmDateTime,
    this.isPending,
    this.mon,
    this.tue,
    this.wed,
    this.thu,
    this.fri,
    this.sat,
    this.sun
  });

  factory Alarm.fromMap(Map<String, dynamic> json) => Alarm(
    id: json["id"],
    alarmDateTime: DateTime.parse(json["alarmDateTime"]),
    isPending: json["isPending"],
    mon: json["mon"],
    tue: json["tue"],
    wed: json["wed"],
    thu: json["thu"],
    fri: json["fri"],
    sat: json["sat"],
    sun: json["sun"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "alarmDateTime": alarmDateTime.toIso8601String(),
    "isPending": isPending,
    "mon": mon,
    "tue": tue,
    "wed": wed,
    "thu": thu,
    "fri": fri,
    "sat": sat,
    "sun": sun,
  };
}