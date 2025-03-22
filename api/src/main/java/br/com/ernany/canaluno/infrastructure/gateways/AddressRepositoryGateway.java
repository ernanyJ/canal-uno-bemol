package br.com.ernany.canaluno.infrastructure.gateways;

import br.com.ernany.canaluno.application.gateways.AddressGateway;
import br.com.ernany.canaluno.domain.address.Address;
import br.com.ernany.canaluno.infrastructure.dto.response.ViaCepResponse;
import br.com.ernany.canaluno.infrastructure.exceptions.ZipCodeValidationException;
import br.com.ernany.canaluno.infrastructure.persistance.entity.AddressEntity;
import br.com.ernany.canaluno.infrastructure.persistance.repository.AddressRepository;
import br.com.ernany.canaluno.infrastructure.utils.domainMappers.AddressMapper;
import br.com.ernany.canaluno.infrastructure.utils.dtoMappers.AddressDTOMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatusCode;
import org.springframework.web.client.RestClient;

public class AddressRepositoryGateway implements AddressGateway {

    private static final Logger logger = LoggerFactory.getLogger(AddressRepositoryGateway.class);
    private static final String VIACEP_URL = "https://viacep.com.br/ws/{zipCode}/json/";

    private final AddressRepository addressRepository;
    private final AddressMapper addressMapper;
    private final AddressDTOMapper addressDTOMapper;
    private final RestClient restClient;

    public AddressRepositoryGateway(AddressRepository addressRepository, AddressMapper addressMapper,
                                    AddressDTOMapper addressDTOMapper, RestClient restClient) {
        this.addressRepository = addressRepository;
        this.addressMapper = addressMapper;
        this.addressDTOMapper = addressDTOMapper;
        this.restClient = restClient;
    }

    @Override
    public Address validateZipCode(String zipCode) {
        try {
            ViaCepResponse result = restClient
                    .get()
                    .uri(mountUri(zipCode))
                    .retrieve()
                    .onStatus(HttpStatusCode::is4xxClientError, (request, response) -> {
                        throw new ZipCodeValidationException("Invalid zip code: " + zipCode);
                    })
                    .body(ViaCepResponse.class);

            if (result == null || result.localidade() == null) {
                logger.warn("Invalid zip code response: {}", zipCode);
                throw new ZipCodeValidationException("Invalid zip code: " + zipCode);
            }

            logger.info("Zip code validated successfully: {}", zipCode);
            return addressDTOMapper.toDomainObj(result);
        } catch (ZipCodeValidationException e) {
            logger.error("Unexpected error validating zip code {}: {}", zipCode, e.getMessage());
            throw new ZipCodeValidationException("Invalid zip code", e);
        }
    }

    @Override
    public Address saveAddress(Address address) {
        try {
            AddressEntity addressEntity = addressMapper.toEntity(address);
            AddressEntity savedEntity = addressRepository.save(addressEntity);
            logger.info("Address saved successfully for zip code: {}", address.getZipCode());
            return addressMapper.toDomainObj(savedEntity);
        } catch (Exception e) {
            logger.error("Error saving address: {}", e.getMessage());
            throw new RuntimeException("Failed to save address", e);
        }
    }

    private String mountUri(String zipCode) {
        return VIACEP_URL.replace("{zipCode}", zipCode);
    }
}

