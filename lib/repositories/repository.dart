class Repository {
  static const API_URL = 'https://secompuem.com/pet/api';

  static const API_USUARIOS = '$API_URL/Usuarios';
  static const API_USUARIOS_LOGIN = '$API_USUARIOS/login/?include=user';

  static const API_PRESENCA = '$API_URL/Presencas';
  static const API_EVENTOS = '$API_URL/Eventos';
  static const API_ATIVIDADES =
      '$API_EVENTOS/\$/Atividades?filter={"include":"categoria","limit":0}';
  static const API_TURMAS =
      '$API_URL/Atividades/\$/Turmas?filter={"include":"dias"}';
  static const API_INSCRICOES =
      '$API_URL/Inscricoes?filter={"where":{"and":[{"turmaId": \$},{"atividadeId":\$}]},"limit":0}';
}
