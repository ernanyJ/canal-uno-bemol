package br.com.ernany.canaluno.integration;

import br.com.ernany.canaluno.domain.address.Address;
import br.com.ernany.canaluno.infrastructure.dto.response.ViaCepResponse;
import br.com.ernany.canaluno.infrastructure.utils.dtoMappers.AddressDTOMapper;
import org.junit.jupiter.api.Test;
import org.springframework.web.client.RestClient;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

public class ViaCepIntegrationTest {

    @Test
    public void get_correct_address_by_zipcode() {
        RestClient restClient = RestClient.create();

        String zipCode = "01001-000";

        String result = restClient
                .get()
                .uri("https://viacep.com.br/ws/" + zipCode + "/json")
                .retrieve()
                .body(String.class);

        assertNotNull(result);
        assertTrue(result.contains("01001-000"));
        assertTrue(result.contains("SP"));
        assertTrue(result.contains("Praça da Sé"));
    }


    @Test
    public void map_viacep_response_to_domain_object() {
        RestClient restClient = RestClient.create();
        AddressDTOMapper mapper = new AddressDTOMapper();

        String zipCode = "01001-000";

        ViaCepResponse response = restClient
                .get()
                .uri("https://viacep.com.br/ws/" + zipCode + "/json")
                .retrieve()
                .body(ViaCepResponse.class);

        Address address = mapper.toDomainObj(response);

        assertNotNull(address);
        assertNotNull(address.getZipCode());
        assertNotNull(address.getState());
        assertNotNull(address.getCity());
        assertNotNull(address.getStreet());
        assertNotNull(address.getNeighborhood());
    }

    @Test
    public void get_error_when_zipcode_is_invalid(){
        RestClient restClient = RestClient.create();

        String zipCode = "00000-000";

        String result = restClient
                .get()
                .uri("https://viacep.com.br/ws/" + zipCode + "/json")
                .retrieve()
                .body(String.class);

        assertNotNull(result);
        assertTrue(result.contains("erro"));
    }
}
