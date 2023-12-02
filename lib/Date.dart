class Date {
  final int id;
  final int calories; 
  final String date;
  static final columns = ["id", "calories", "date"]; 

  Date(this.id, this.calories, this.date);
  factory Date.fromMap(Map<dynamic, dynamic> data) { 
    return Date(
        data['id'],
        data['calories'], 
        data['date'], 
    );
  }

  Map<String, dynamic> toMap() => {
    "id": id, 
    "calories": calories, 
    "date": date, 
  }; 
}