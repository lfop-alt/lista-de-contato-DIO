class ContatoModel {
  String? objectId;
  String? name;
  String? telefoneFixo;
  String? telefoneCelular;
  String? email;
  String? image;

  ContatoModel(
      {this.objectId,
      this.name,
      this.telefoneFixo,
      this.telefoneCelular,
      this.email,
      this.image});

  ContatoModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    name = json['name'];
    telefoneFixo = json['telefoneFixo'];
    telefoneCelular = json['telefoneCelular'];
    email = json['email'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['name'] = name;
    data['telefoneFixo'] = telefoneFixo;
    data['telefoneCelular'] = telefoneCelular;
    data['email'] = email;
    data['image'] = image;
    return data;
  }
}
