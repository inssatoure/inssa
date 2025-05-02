class Employment {
  String jobTitle;
  String companyName;
  String startDate;
  String endDate;
  String address;

  Employment({
    required this.jobTitle,
    required this.companyName,
    required this.startDate,
    required this.endDate,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'jobTitle': jobTitle,
      'companyName': companyName,
      'startDate': startDate,
      'endDate': endDate,
      'address': address,
    };
  }

  factory Employment.fromJson(Map<String, dynamic> map) {
    return Employment(
      jobTitle: map['jobTitle'],
      companyName: map['companyName'],
      startDate: map['startDate'],
      endDate: map['endDate'],
      address: map['address'],
    );
  }
}
