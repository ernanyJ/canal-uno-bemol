package br.com.ernany.canaluno.infrastructure.dto.request;

public record UserLoginRequest(
    String login,
    String password
) {
}
