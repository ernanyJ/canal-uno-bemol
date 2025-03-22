package br.com.ernany.canaluno.infrastructure.security.services;

import br.com.ernany.canaluno.infrastructure.dto.response.UserLoginResponse;
import br.com.ernany.canaluno.infrastructure.persistance.entity.UserEntity;
import br.com.ernany.canaluno.infrastructure.persistance.repository.UserRepository;
import br.com.ernany.canaluno.infrastructure.utils.domainMappers.UserMapper;
import br.com.ernany.canaluno.infrastructure.utils.dtoMappers.UserDTOMapper;
import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTCreationException;
import com.auth0.jwt.exceptions.JWTVerificationException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneOffset;

@Service
public class TokenService {

    private final UserRepository userRepository;
    private final UserDTOMapper userDTOMapper;
    private final UserMapper userMapper;

    @Value("${api.security.token.secret}")
    private String secret;

    @Value("${api.security.token.expiration}")
    private String expiration;

    @Value("${api.security.token.expiration-refresh}")
    private String refresh;

    public TokenService(UserRepository userRepository, UserDTOMapper userDTOMapper, UserMapper userMapper) {
        this.userRepository = userRepository;
        this.userDTOMapper = userDTOMapper;
        this.userMapper = userMapper;
    }

    public UserLoginResponse generateLoginTokens(UserEntity user) {
        final Algorithm algorithm = Algorithm.HMAC256(secret);

        try {
            var token = generateToken(user.getLogin(), algorithm, generateExpirationDate());
            return new UserLoginResponse(token, userDTOMapper.toResponse(userMapper.toDomainObj(user)));
        } catch (JWTCreationException e) {
            throw new RuntimeException("Error generating token", e);
        }
    }

    public String validateToken(String token) {
        final Algorithm algorithm = Algorithm.HMAC256(secret);

        try {
            return JWT.require(algorithm)
                    .withIssuer("canaluno-api")
                    .build()
                    .verify(token)
                    .getSubject();
        } catch (JWTVerificationException e) {
            return "";
        }
    }


    private String generateToken(String user, Algorithm algorithm, Instant expiration) {
        return JWT.create().withIssuer("canaluno-api").withSubject(user).withExpiresAt(expiration).sign(algorithm);
    }

    private Instant generateExpirationDate() {
        return LocalDateTime.now().plusHours(Long.parseLong(expiration)).toInstant(ZoneOffset.of("-04:00"));
    }

}
