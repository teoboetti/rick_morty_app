enum CharacterStatus {
  alive('Alive'),

  dead('Dead'),

  unknown('Unknown');

  const CharacterStatus(this.status);

  factory CharacterStatus.parse(String status) {
    switch (status) {
      case 'Alive':
        return CharacterStatus.alive;
      case 'Dead':
        return CharacterStatus.dead;
      default:
        return CharacterStatus.unknown;
    }
  }

  final String status;
}
