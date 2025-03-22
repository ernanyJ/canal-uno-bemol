package br.com.ernany.canaluno.application.usecases;

import br.com.ernany.canaluno.application.gateways.UserGateway;
import org.springframework.security.core.userdetails.UserDetails;

public class FindUserByLoginInteractor {
    private final UserGateway userGateway;

    public FindUserByLoginInteractor(UserGateway userGateway) {
        this.userGateway = userGateway;
    }

    public UserDetails execute(String login) {
        return userGateway.loadUserByUsername(login);
    }
}
