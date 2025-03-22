package br.com.ernany.canaluno.application.gateways;

import br.com.ernany.canaluno.domain.address.Address;

public interface AddressGateway {

    Address validateZipCode(String zipCode);

    Address saveAddress(Address address);
}
