package br.com.ernany.canaluno.application.gateways;

import br.com.ernany.canaluno.domain.user.User;
import br.com.ernany.canaluno.infrastructure.dto.request.UpdateUserRequest;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.util.List;
import java.util.UUID;

public interface UserGateway extends UserDetailsService {
    User createUser(User user);
    void deleteUser(UUID id);
    List<User> findAll();
    User update(UUID id, UpdateUserRequest user);
}
