package br.com.ernany.canaluno.infrastructure.dto.response;

public record AddressCompleteResponse (
        String zipCode,
        String street,
        String complement,
        String neighborhood,
        String city,
        String state
){

}
