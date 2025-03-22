package br.com.ernany.canaluno.application.usecases;

import br.com.ernany.canaluno.application.gateways.UserGateway;
import br.com.ernany.canaluno.domain.user.User;

public class CreateUserInteractor {

    private final UserGateway userGateway;

    public CreateUserInteractor(UserGateway userGateway) {
        this.userGateway = userGateway;
    }

    public User execute(User user) {
        return userGateway.createUser(user);
    }
}
