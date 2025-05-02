class Skill {
  final String skill;
  final double level;

  Skill({required this.skill, required this.level});

  Map<String, dynamic> toMap() {
    return {
      'skill': skill,
      'level': level,
    };
  }

  factory Skill.fromJson(Map<String, dynamic> map) {
    return Skill(
      skill: map['skill'],
      level: map['level'],
    );
  }
}
