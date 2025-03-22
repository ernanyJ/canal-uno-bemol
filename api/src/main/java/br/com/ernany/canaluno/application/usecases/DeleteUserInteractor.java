package br.com.ernany.canaluno.application.usecases;

import br.com.ernany.canaluno.application.gateways.UserGateway;

import java.util.UUID;

public class DeleteUserInteractor {

    private final UserGateway userGateway;

    public DeleteUserInteractor(UserGateway userGateway) {
        this.userGateway = userGateway;
    }

    public void execute(UUID id) {
        userGateway.deleteUser(id);
    }
}
