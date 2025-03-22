package br.com.ernany.canaluno.infrastructure.persistance.repository;

import br.com.ernany.canaluno.infrastructure.persistance.entity.AddressEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface AddressRepository extends JpaRepository<AddressEntity, UUID> {
}
