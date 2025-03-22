package br.com.ernany.canaluno.infrastructure.dto.response;

public record UserLoginResponse(
    String token,
    UserResponse username
) {
}
