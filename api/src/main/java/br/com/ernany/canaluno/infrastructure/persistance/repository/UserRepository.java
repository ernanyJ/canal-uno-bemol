package br.com.ernany.canaluno.infrastructure.persistance.repository;

import br.com.ernany.canaluno.infrastructure.persistance.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface UserRepository extends JpaRepository<UserEntity, Long> {
    void deleteById(UUID id);
    boolean existsById(UUID id);
    UserEntity findById(UUID id);
    UserEntity findByLogin(String login);
}
