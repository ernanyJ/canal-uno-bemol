package br.com.ernany.canaluno.infrastructure.gateways;

import br.com.ernany.canaluno.application.gateways.UserGateway;
import br.com.ernany.canaluno.domain.user.User;
import br.com.ernany.canaluno.infrastructure.dto.request.UpdateUserRequest;
import br.com.ernany.canaluno.infrastructure.exceptions.ObjectNotFoundException;
import br.com.ernany.canaluno.infrastructure.persistance.entity.UserEntity;
import br.com.ernany.canaluno.infrastructure.persistance.repository.UserRepository;
import br.com.ernany.canaluno.infrastructure.security.models.UserDetailsImpl;
import br.com.ernany.canaluno.infrastructure.utils.domainMappers.AddressMapper;
import br.com.ernany.canaluno.infrastructure.utils.domainMappers.UserMapper;
import br.com.ernany.canaluno.infrastructure.utils.dtoMappers.AddressDTOMapper;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import java.util.List;
import java.util.UUID;

public class UserRepositoryGateway implements UserGateway {

    private final UserRepository userRepository;
    private final UserMapper userMapper;
    private final AddressMapper addressMapper;
    private final AddressDTOMapper addressDTOMapper;


    public UserRepositoryGateway(UserRepository userRepository, UserMapper userMapper, AddressMapper addressMapper, AddressDTOMapper addressDTOMapper) {
        this.userRepository = userRepository;
        this.userMapper = userMapper;
        this.addressMapper = addressMapper;
        this.addressDTOMapper = addressDTOMapper;
    }

    @Override
    public User createUser(User user) {
        UserEntity entity = userRepository.save(userMapper.toEntity(user));
        return userMapper.toDomainObj(entity);
    }

    @Override
    public void deleteUser(UUID id) {
        userRepository.deleteById(id);
    }

    @Override
    public List<User> findAll() {
        return userMapper.toDomainList(userRepository.findAll());
    }

    @Override
    public User update(UUID id, UpdateUserRequest user) {
        if (userRepository.existsById(id)) {
            final UserEntity entity = userRepository.findById(id);
            entity.setName(user.name());
            entity.setEmail(user.email());
            entity.setRole(user.role());
            entity.setAddress(addressMapper.toEntity(addressDTOMapper.toDomainObj(user.address())));
            return userMapper.toDomainObj(userRepository.save(entity));
        }
        throw new ObjectNotFoundException("Provided user does not exists");
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        final UserEntity entity = userRepository.findByLogin(username);
        return new UserDetailsImpl(entity);
    }
}
