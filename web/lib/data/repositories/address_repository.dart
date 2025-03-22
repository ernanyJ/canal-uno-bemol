import 'package:canaluno/data/dto/response/address_complete_response.dart';
import 'package:canaluno/util/config/api.dart';

class AddressRepository {
  final _client = ApiClient().instance;

  Future<AddressCompleteResponse> validateCep(String zipCode) {
    zipCode = zipCode.replaceAll('-', '').replaceAll('.', '');
    return _client.get(
      '/address/validate',
      queryParameters: {
        'zipCode': zipCode,
      },
    ).then((response) {
      return AddressCompleteResponse.fromJson(response.data);
    }) ;
  }
}
