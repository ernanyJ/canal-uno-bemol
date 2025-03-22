class AddressCompleteResponse {
  String? zipCode;
  String? street;
  String? complement;
  String? neighborhood;
  String? city;
  String? state;

  AddressCompleteResponse({this.zipCode, this.street, this.complement, this.neighborhood, this.city, this.state});

  AddressCompleteResponse.fromJson(Map<String, dynamic> json) {
    zipCode = json['zipCode'];
    street = json['street'];
    complement = json['complement'];
    neighborhood = json['neighborhood'];
    city = json['city'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['zipCode'] = zipCode;
    data['street'] = street;
    data['complement'] = complement;
    data['neighborhood'] = neighborhood;
    data['city'] = city;
    data['state'] = state;
    return data;
  }
}
