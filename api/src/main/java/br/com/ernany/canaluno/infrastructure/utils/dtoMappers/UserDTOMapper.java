package br.com.ernany.canaluno.infrastructure.utils.dtoMappers;

import br.com.ernany.canaluno.domain.user.User;
import br.com.ernany.canaluno.infrastructure.dto.request.CreateUserRequest;
import br.com.ernany.canaluno.infrastructure.dto.request.UpdateUserRequest;
import br.com.ernany.canaluno.infrastructure.dto.response.CreateUserResponse;
import br.com.ernany.canaluno.infrastructure.dto.response.UserResponse;

import java.util.UUID;

public class UserDTOMapper {

    private final AddressDTOMapper addressMapper;

    public UserDTOMapper(AddressDTOMapper addressMapper) {
        this.addressMapper = addressMapper;
    }

    public CreateUserResponse toCreateResponse(User user) {
        return new CreateUserResponse(
                user.getId(),
                user.getName(),
                user.getLogin(),
                user.getEmail(),
                user.getRole()
        );
    }

    public UserResponse toResponse(User user) {
        return new UserResponse(
                user.getId(),
                user.getName(),
                user.getLogin(),
                user.getEmail(),
                user.getRole(),
                addressMapper.toResponse(user.getAddress())
        );
    }

    public User toDomainObj(CreateUserRequest request) {
        return new User(
                null,
                request.name(),
                request.login(),
                request.email(),
                request.password(),
                request.role(),
                addressMapper.toDomainObj(request.address())
        );
    }


    public User toDomainObj(UpdateUserRequest request, UUID id) {
        return new User(
                id,
                request.name(),
                null,
                request.email(),
                null,
                request.role(),
                addressMapper.toDomainObj(request.address())
        );
    }
}

