class PersonalSkill {
  String personalSkill;

  PersonalSkill({required this.personalSkill});

  Map<String, dynamic> toMap() {
    return {
      'personalSkill': personalSkill,
    };
  }

  factory PersonalSkill.fromJson(Map<String, dynamic> map) {
    return PersonalSkill(
      personalSkill: map['personalSkill'],
    );
  }
}
