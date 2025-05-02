class Education {
  final String university;
  final String degree;
  final String startDate;
  final String endDate;

  Education({
    required this.university,
    required this.degree,
    required this.startDate,
    required this.endDate,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      university: json['university'] ?? '',
      degree: json['degree'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'university': university,
      'degree': degree,
      'startDate': startDate,
      'endDate': endDate,
    };
  }
}
