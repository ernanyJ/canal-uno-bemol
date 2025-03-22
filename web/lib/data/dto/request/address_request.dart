class AddressRequest {
  String street;
  String number;
  String complement;
  String neighborhood;
  String city;
  String state;
  String zipCode;

  AddressRequest(
      {required this.street,
      required this.number,
      required this.complement,
      required this.neighborhood,
      required this.city,
      required this.state,
      required this.zipCode});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['street'] = street;
    data['number'] = number;
    data['complement'] = complement;
    data['neighborhood'] = neighborhood;
    data['city'] = city;
    data['state'] = state;
    data['zipCode'] = zipCode;
    return data;
  }

  
}
