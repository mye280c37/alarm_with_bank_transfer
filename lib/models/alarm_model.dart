class Alarm {
  int id;
  DateTime alarmDateTime;
  int isPending;
  int mon;
  int tue;
  int wed;
  int thu;
  int fri;
  int sat;
  int sun;

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

  factory Alarm.fromMap(Map<String, dynamic> json) => new Alarm(
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