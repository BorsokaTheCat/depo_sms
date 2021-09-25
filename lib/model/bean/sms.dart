class Sms {
  int id;
  String number;
  String message;
  String feedback = '';
  String time='';
  int current;

  Sms({
    this.id,
    this.number,
    this.message,
    this.feedback,
    this.time,
    this.current,
  });

  @override
  String toString() {
    return 'Sms{id: $id, number: $number, message: $message, feedback: $feedback, time: $time, isCurrent: $current}';
  }

  Sms.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        number = res["number"],
        message = res["message"],
        feedback = res["feedback"],
        time = res["time"],
        current = res["current"];

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['number'] = number;
    map['message'] = message;
    map['feedback'] = feedback;
    map['time'] = time;
    map['current'] = current;
    return map;
  }
}

