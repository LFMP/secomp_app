class Repository{

  static const API_URL = 'http://192.168.0.85:3001/pet/api/';

  static const API_USUARIOS = '$API_URL/Usuarios';
  static const API_USUARIOS_LOGIN = '$API_USUARIOS/login';

  static const API_EVENTOS = '$API_URL/Eventos';
  static const API_ATIVIDADES = '$API_EVENTOS/\$/Atividades?filter=%7B%22include%22%3A%22categoria%22%7D';
  static const API_TURMAS = '$API_URL/Atividades/\$/Turmas';

}