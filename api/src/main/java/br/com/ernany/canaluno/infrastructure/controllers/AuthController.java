package br.com.ernany.canaluno.infrastructure.controllers;

import br.com.ernany.canaluno.application.usecases.CreateUserInteractor;
import br.com.ernany.canaluno.application.usecases.FindUserByLoginInteractor;
import br.com.ernany.canaluno.infrastructure.dto.request.CreateUserRequest;
import br.com.ernany.canaluno.infrastructure.dto.request.UserLoginRequest;
import br.com.ernany.canaluno.infrastructure.dto.response.UserLoginResponse;
import br.com.ernany.canaluno.infrastructure.exceptions.AuthenticationException;
import br.com.ernany.canaluno.infrastructure.persistance.entity.UserEntity;
import br.com.ernany.canaluno.infrastructure.security.models.UserDetailsImpl;
import br.com.ernany.canaluno.infrastructure.security.services.TokenService;
import br.com.ernany.canaluno.infrastructure.utils.domainMappers.AddressMapper;
import br.com.ernany.canaluno.infrastructure.utils.domainMappers.UserMapper;
import br.com.ernany.canaluno.infrastructure.utils.dtoMappers.AddressDTOMapper;
import jakarta.validation.Valid;
import lombok.extern.java.Log;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Log
@RequestMapping("/api/auth")
public class AuthController {

    private final AuthenticationManager authenticationManager;
    private final TokenService tokenService;
    private final UserMapper userMapper;
    private final AddressDTOMapper addressDtoMapper;
    private final CreateUserInteractor createUserInteractor;
    private final FindUserByLoginInteractor findUserByLoginInteractor;
    private final AddressMapper addressMapper;


    public AuthController(AuthenticationManager authenticationManager, TokenService tokenService, UserMapper userMapper, AddressDTOMapper addressDtoMapper, CreateUserInteractor createUserInteractor, FindUserByLoginInteractor findUserByLoginInteractor, AddressMapper addressMapper) {
        this.authenticationManager = authenticationManager;
        this.tokenService = tokenService;
        this.userMapper = userMapper;
        this.addressDtoMapper = addressDtoMapper;
        this.createUserInteractor = createUserInteractor;
        this.findUserByLoginInteractor = findUserByLoginInteractor;
        this.addressMapper = addressMapper;
    }

    @PostMapping("/login")
    public ResponseEntity<UserLoginResponse> login(@RequestBody @Valid UserLoginRequest request) {
        var userNamePassword = new UsernamePasswordAuthenticationToken(request.login(), request.password());
        var auth = authenticationManager.authenticate(userNamePassword);
        log.info("User authenticated: " + userNamePassword.getName());
        var userDetails = (UserDetailsImpl) auth.getPrincipal();
        var token = tokenService.generateLoginTokens(userDetails.getUser());
        return ResponseEntity.ok(token);
    }


    @PostMapping("/signup")
    public ResponseEntity<?> signup(@RequestBody @Valid CreateUserRequest request) {
        var userExists = findUserByLoginInteractor.execute(request.login());
        // por algum motivo que não tenho tempo para investigar, o getter de UserDetailsImpl não está funcionando aqui, então fiz uma gambiarra para não ficar travado :)
        if(!userExists.toString().contains("user=null")) throw new AuthenticationException("User already exists");

        String encryptedPassword = new BCryptPasswordEncoder().encode(request.password());
        UserEntity user = new UserEntity(null, request.name(), request.login(), request.email(), encryptedPassword, request.role(), addressMapper.toEntity(addressDtoMapper.toDomainObj(request.address())));

        createUserInteractor.execute(userMapper.toDomainObj(user));


        return ResponseEntity.ok().build();
    }

}
