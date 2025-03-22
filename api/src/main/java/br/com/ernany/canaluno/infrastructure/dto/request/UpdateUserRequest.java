package br.com.ernany.canaluno.infrastructure.dto.request;

import br.com.ernany.canaluno.domain.user.UserRole;

public record UpdateUserRequest(
        String name,
        String email,
        UserRole role,
        AddressRequest address
) {
}
