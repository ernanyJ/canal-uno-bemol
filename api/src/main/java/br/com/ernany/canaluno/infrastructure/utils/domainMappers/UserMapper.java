package br.com.ernany.canaluno.infrastructure.utils.domainMappers;

import br.com.ernany.canaluno.domain.user.User;
import br.com.ernany.canaluno.infrastructure.persistance.entity.UserEntity;

import java.util.List;

public class UserMapper implements DomainMapper<User, UserEntity> {

    private final AddressMapper addressMapper;

    public UserMapper(AddressMapper addressMapper) {
        this.addressMapper = addressMapper;
    }

    public UserEntity toEntity(User domainObj) {
        return new UserEntity(
                domainObj.getId(),
                domainObj.getName(),
                domainObj.getLogin(),
                domainObj.getEmail(),
                domainObj.getPassword(),
                domainObj.getRole(),
                addressMapper.toEntity(domainObj.getAddress())
        );
    }

    public User toDomainObj(UserEntity entity) {
        return new User(
                entity.getId(),
                entity.getName(),
                entity.getLogin(),
                entity.getEmail(),
                entity.getPassword(),
                entity.getRole(),
                addressMapper.toDomainObj(entity.getAddress())
        );
    }

    public List<User> toDomainList(List<UserEntity> all) {
        return all.stream().map(this::toDomainObj).toList();
    }
}
