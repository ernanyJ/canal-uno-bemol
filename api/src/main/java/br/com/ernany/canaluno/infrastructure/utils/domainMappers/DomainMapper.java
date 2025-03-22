package br.com.ernany.canaluno.infrastructure.utils.domainMappers;

/// Mapping interface. <p/> First generic type is the domain object and the second is the entity.
public interface DomainMapper<T, U> {
    U toEntity(T domainObj);
    T toDomainObj(U entity);
}
