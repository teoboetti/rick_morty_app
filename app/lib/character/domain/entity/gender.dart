enum CharacterGender {
  female('Female'),

  male('Male'),

  genderless('Genderless'),

  unknown('Unknown');

  const CharacterGender(this.gender);

  factory CharacterGender.parse(String gender) {
    switch (gender) {
      case 'Female':
        return CharacterGender.female;
      case 'Male':
        return CharacterGender.male;
      case 'Genderless':
        return CharacterGender.genderless;
      default:
        return CharacterGender.unknown;
    }
  }

  final String gender;
}
