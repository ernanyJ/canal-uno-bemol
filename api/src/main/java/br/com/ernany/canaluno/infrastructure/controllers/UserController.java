package br.com.ernany.canaluno.infrastructure.controllers;

import br.com.ernany.canaluno.application.usecases.DeleteUserInteractor;
import br.com.ernany.canaluno.application.usecases.ListUsersInteractor;
import br.com.ernany.canaluno.application.usecases.UpdateUserInteractor;
import br.com.ernany.canaluno.domain.user.User;
import br.com.ernany.canaluno.infrastructure.dto.request.UpdateUserRequest;
import br.com.ernany.canaluno.infrastructure.dto.response.UserResponse;
import br.com.ernany.canaluno.infrastructure.utils.dtoMappers.AddressDTOMapper;
import br.com.ernany.canaluno.infrastructure.utils.dtoMappers.UserDTOMapper;
import jakarta.transaction.Transactional;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/user")
public class UserController {
    private final DeleteUserInteractor deleteUserInteractor;
    private final ListUsersInteractor listUsersInteractor;
    private final UpdateUserInteractor updateUserInteractor;

    private final UserDTOMapper userMapper;

    public UserController(DeleteUserInteractor deleteUserInteractor, ListUsersInteractor listUsersInteractor, UpdateUserInteractor updateUserInteractor) {
        this.deleteUserInteractor = deleteUserInteractor;
        this.listUsersInteractor = listUsersInteractor;
        this.updateUserInteractor = updateUserInteractor;
        userMapper = new UserDTOMapper(new AddressDTOMapper());
    }

    @DeleteMapping
    @Transactional
    ResponseEntity<?> delete(@RequestParam UUID id) {
        deleteUserInteractor.execute(id);
        return ResponseEntity.ok().build();
    }

    @GetMapping
    ResponseEntity<List<UserResponse>> list() {
        List<User> users = listUsersInteractor.execute();
        List<UserResponse> responses = users.stream().map(userMapper::toResponse).toList();
        return ResponseEntity.ok(responses);
    }

    @PutMapping
    ResponseEntity<UserResponse> update(@RequestParam UUID id, @RequestBody UpdateUserRequest request) {
        final User user = updateUserInteractor.execute(id, request);
        return ResponseEntity.ok(userMapper.toResponse(user));
    }

}
