class ProfessionalSkill {
  final String professionalSkill;

  ProfessionalSkill({required this.professionalSkill});

  Map<String, dynamic> toMap() {
    return {
      'professionalSkill': professionalSkill,
    };
  }

  factory ProfessionalSkill.fromJson(Map<String, dynamic> map) {
    return ProfessionalSkill(
      professionalSkill: map['professionalSkill'],
    );
  }
}
