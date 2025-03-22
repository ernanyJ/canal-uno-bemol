package br.com.ernany.canaluno.application.usecases;

import br.com.ernany.canaluno.application.gateways.AddressGateway;
import br.com.ernany.canaluno.domain.address.Address;

public class ValidateZipCodeInteractor {

    private final AddressGateway addressGateway;

    public ValidateZipCodeInteractor(AddressGateway addressGateway) {
        this.addressGateway = addressGateway;
    }

    public Address execute(String zipCode) {
        return addressGateway.validateZipCode(zipCode);
    }

}
