package br.com.ernany.canaluno.application.usecases;

import br.com.ernany.canaluno.application.gateways.UserGateway;
import br.com.ernany.canaluno.domain.user.User;
import br.com.ernany.canaluno.infrastructure.dto.request.UpdateUserRequest;

import java.util.UUID;

public class UpdateUserInteractor {

    private final UserGateway userGateway;

    public UpdateUserInteractor(UserGateway userGateway) {
        this.userGateway = userGateway;
    }

    public User execute(UUID id, UpdateUserRequest user) {
        return userGateway.update(id, user);
    }

}
