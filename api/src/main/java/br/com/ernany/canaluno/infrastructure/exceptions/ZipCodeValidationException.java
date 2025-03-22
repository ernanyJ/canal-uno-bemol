package br.com.ernany.canaluno.infrastructure.exceptions;

import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(org.springframework.http.HttpStatus.BAD_REQUEST)
public class ZipCodeValidationException extends RuntimeException {
    public ZipCodeValidationException(String message) {
        super(message);
    }

    public ZipCodeValidationException(String message, Throwable cause) {
        super(message, cause);
    }
}