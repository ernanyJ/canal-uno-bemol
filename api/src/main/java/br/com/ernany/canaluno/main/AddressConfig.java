package br.com.ernany.canaluno.main;

import br.com.ernany.canaluno.application.gateways.AddressGateway;
import br.com.ernany.canaluno.application.usecases.ValidateZipCodeInteractor;
import br.com.ernany.canaluno.infrastructure.gateways.AddressRepositoryGateway;
import br.com.ernany.canaluno.infrastructure.persistance.repository.AddressRepository;
import br.com.ernany.canaluno.infrastructure.utils.domainMappers.AddressMapper;
import br.com.ernany.canaluno.infrastructure.utils.dtoMappers.AddressDTOMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestClient;

@Configuration
public class AddressConfig {

    @Bean
    ValidateZipCodeInteractor validateZipCodeInteractor(AddressGateway addressGateway) {
        return new ValidateZipCodeInteractor(addressGateway);
    }

    @Bean
    AddressGateway addressGateway(AddressRepository addressRepository, AddressMapper addressMapper, AddressDTOMapper addressDtoMapper, RestClient restClient) {
        return new AddressRepositoryGateway(addressRepository, addressMapper, addressDtoMapper, restClient);
    }

    @Bean
    AddressMapper addressMapper() {
        return new AddressMapper();
    }

    @Bean
    AddressDTOMapper addressDtoMapper() {
        return new AddressDTOMapper();
    }

    @Bean
    RestClient restClient() {
        return RestClient.create();
    }
}
