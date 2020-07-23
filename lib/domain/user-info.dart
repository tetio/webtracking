class UserInfo {
  String empresa;
  String npEmpresa;
  String nomEmpresa;
  String empresaLogada;
  String token;
  String userLogado;
  String aplicacion;
  String timestamp;
  bool esCma;
  bool portic;

  UserInfo(
      {this.empresa,
      this.npEmpresa,
      this.nomEmpresa,
      this.empresaLogada,
      this.token,
      this.userLogado,
      this.aplicacion,
      this.timestamp,
      this.esCma,
      this.portic});

  UserInfo.fromJson(Map<String, dynamic> json) {
    empresa = json['empresa'];
    npEmpresa = json['npEmpresa'];
    nomEmpresa = json['nomEmpresa'];
    empresaLogada = json['empresaLogada'];
    token = json['token'];
    userLogado = json['userLogado'];
    aplicacion = json['aplicacion'];
    timestamp = json['timestamp'];
    esCma = json['esCma'];
    portic = json['portic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['empresa'] = this.empresa;
    data['npEmpresa'] = this.npEmpresa;
    data['nomEmpresa'] = this.nomEmpresa;
    data['empresaLogada'] = this.empresaLogada;
    data['token'] = this.token;
    data['userLogado'] = this.userLogado;
    data['aplicacion'] = this.aplicacion;
    data['timestamp'] = this.timestamp;
    data['esCma'] = this.esCma;
    data['portic'] = this.portic;
    return data;
  }
}