package br.com.ernany.canaluno.infrastructure.dto.response;

import java.util.UUID;

public record AddressResponse(
        UUID id,
        String street,
        String zipCode,
        String neighborhood,
        String city,
        String state
) {
}
