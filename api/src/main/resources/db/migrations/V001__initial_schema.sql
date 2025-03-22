-- Tabela AddressEntity
CREATE TABLE address_entity (
                                id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Gera UUID automaticamente
                                street VARCHAR(255),
                                number VARCHAR(50),
                                complement VARCHAR(255),
                                neighborhood VARCHAR(100),
                                city VARCHAR(100),
                                state VARCHAR(100),
                                zip_code VARCHAR(20)
);

-- Tabela UserEntity
CREATE TABLE user_entity (
                             id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Gera UUID automaticamente
                             name VARCHAR(255),
                             login VARCHAR(100) NOT NULL,
                             email VARCHAR(255) NOT NULL,
                             password VARCHAR(255) NOT NULL,
                             role VARCHAR(50), -- UserRole será mapeado como string (enum)
                             address_id UUID, -- Chave estrangeira para AddressEntity
                             CONSTRAINT fk_address
                                 FOREIGN KEY (address_id)
                                     REFERENCES address_entity(id)
                                     ON DELETE SET NULL -- Caso o endereço seja deletado, o campo fica nulo
);