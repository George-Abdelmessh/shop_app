class ChangeFavoritesModel{
  late bool status;
  late String message;

  ChangeFavoritesModel.formJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
  }
}