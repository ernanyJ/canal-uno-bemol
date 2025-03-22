package br.com.ernany.canaluno.infrastructure.utils.domainMappers;

import br.com.ernany.canaluno.domain.address.Address;
import br.com.ernany.canaluno.infrastructure.persistance.entity.AddressEntity;

public class AddressMapper implements DomainMapper<Address, AddressEntity> {

    public AddressEntity toEntity(Address address) {
        return new AddressEntity(
                address.getId(),
                address.getStreet(),
                address.getNumber(),
                address.getComplement(),
                address.getNeighborhood(),
                address.getCity(),
                address.getState(),
                address.getZipCode());
    }

    public Address toDomainObj(AddressEntity entity) {
        return new Address(
                entity.getId(),
                entity.getStreet(),
                entity.getNumber(),
                entity.getComplement(),
                entity.getNeighborhood(),
                entity.getCity(),
                entity.getState(),
                entity.getZipCode());
    }

}
