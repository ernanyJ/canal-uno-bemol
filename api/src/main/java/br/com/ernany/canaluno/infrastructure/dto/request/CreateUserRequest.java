package br.com.ernany.canaluno.infrastructure.dto.request;

import br.com.ernany.canaluno.domain.user.UserRole;

public record CreateUserRequest(
        String name,
        String login,
        String email,
        String password,
        UserRole role,
        AddressRequest address

        ) {
}
