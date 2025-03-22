class AddressModel {
  final String id;
  final String street;
  final String zipCode;
  final String neighborhood;
  final String city;
  final String state;

  AddressModel({
    required this.id,
    required this.street,
    required this.zipCode,
    required this.neighborhood,
    required this.city,
    required this.state,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      street: json['street'],
      zipCode: json['zipCode'],
      neighborhood: json['neighborhood'],
      city: json['city'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'street': street,
      'zipCode': zipCode,
      'neighborhood': neighborhood,
      'city': city,
      'state': state,
    };
  }

  AddressModel copyWith({
    String? id,
    String? street,
    String? zipCode,
    String? neighborhood,
    String? city,
    String? state,
  }) {
    return AddressModel(
      id: id ?? this.id,
      street: street ?? this.street,
      zipCode: zipCode ?? this.zipCode,
      neighborhood: neighborhood ?? this.neighborhood,
      city: city ?? this.city,
      state: state ?? this.state,
    );
  }
}
