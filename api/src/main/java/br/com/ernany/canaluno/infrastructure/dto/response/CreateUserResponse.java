package br.com.ernany.canaluno.infrastructure.dto.response;

import br.com.ernany.canaluno.domain.user.UserRole;

import java.util.UUID;

public record CreateUserResponse(
        UUID id,
        String name,
        String login,
        String email,
        UserRole role
) {
}
