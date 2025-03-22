package br.com.ernany.canaluno.application.usecases;

import br.com.ernany.canaluno.application.gateways.UserGateway;
import br.com.ernany.canaluno.domain.user.User;

import java.util.List;

public class ListUsersInteractor {
    private final UserGateway userGateway;


    public ListUsersInteractor(UserGateway userGateway) {
        this.userGateway = userGateway;
    }

    public List<User> execute() {
        return userGateway.findAll();
    }
}
