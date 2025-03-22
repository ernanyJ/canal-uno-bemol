package br.com.ernany.canaluno.main;

import br.com.ernany.canaluno.application.gateways.UserGateway;
import br.com.ernany.canaluno.application.usecases.*;
import br.com.ernany.canaluno.infrastructure.gateways.UserRepositoryGateway;
import br.com.ernany.canaluno.infrastructure.persistance.repository.UserRepository;
import br.com.ernany.canaluno.infrastructure.utils.domainMappers.AddressMapper;
import br.com.ernany.canaluno.infrastructure.utils.domainMappers.UserMapper;
import br.com.ernany.canaluno.infrastructure.utils.dtoMappers.AddressDTOMapper;
import br.com.ernany.canaluno.infrastructure.utils.dtoMappers.UserDTOMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class UserConfig {

    @Bean
    CreateUserInteractor createUserInteractor(UserGateway userGateway) {
        return new CreateUserInteractor(userGateway);
    }

    @Bean
    DeleteUserInteractor deleteUserInteractor(UserGateway userGateway) {
        return new DeleteUserInteractor(userGateway);
    }

    @Bean
    ListUsersInteractor listUsersInteractor(UserGateway userGateway) {
        return new ListUsersInteractor(userGateway);
    }

    @Bean
    UpdateUserInteractor updateUserInteractor(UserGateway userGateway) {
        return new UpdateUserInteractor(userGateway);
    }

    @Bean
    FindUserByLoginInteractor findUserByLoginInteractor(UserGateway userGateway) {
        return new FindUserByLoginInteractor(userGateway);
    }

    @Bean
    UserGateway userGateway(UserRepository userRepository, UserMapper userMapper, AddressMapper addressMapper, AddressDTOMapper addressDtoMapper) {
        return new UserRepositoryGateway(userRepository, userMapper, addressMapper, addressDtoMapper);
    }

    @Bean
    UserMapper userMapper(AddressMapper addressMapper) {
        return new UserMapper(addressMapper);
    }

    @Bean
    UserDTOMapper userDTOMapper(AddressDTOMapper addressMapper) {
        return new UserDTOMapper(addressMapper);
    }

}
