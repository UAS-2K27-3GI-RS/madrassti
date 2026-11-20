class MessageModerator {
  static const _blocked = {
    'merde',
    'putain',
    'salope',
    'connard',
    'connasse',
    'nique',
    'ntm',
    'fdp',
    'encule',
    'enculé',
    'pute',
    'bordel',
    'connerie',
    'idiot',
    'imbecile',
    'imbécile',
    'stupide',
    'degueulasse',
    'dégueulasse',
  };

  static String? check(String text) {
    final tokens = text
        .toLowerCase()
        .replaceAll(RegExp(r"[’']"), ' ')
        .split(RegExp(r'[^a-zàâäéèêëïîôùûüç]+'))
        .where((t) => t.isNotEmpty);
    for (final token in tokens) {
      if (_blocked.contains(token)) {
        return token;
      }
    }
    return null;
  }
}
