package br.com.ernany.canaluno.infrastructure.utils.dtoMappers;

import br.com.ernany.canaluno.domain.address.Address;
import br.com.ernany.canaluno.infrastructure.dto.request.AddressRequest;
import br.com.ernany.canaluno.infrastructure.dto.response.AddressCompleteResponse;
import br.com.ernany.canaluno.infrastructure.dto.response.AddressResponse;
import br.com.ernany.canaluno.infrastructure.dto.response.ViaCepResponse;

public class AddressDTOMapper {

    public Address toDomainObj(AddressRequest request) {
        return new Address(
                null,
                request.street(),
                request.number(),
                request.complement(),
                request.neighborhood(),
                request.city(),
                request.state(),
                request.zipCode());
    }

    public Address toDomainObj(ViaCepResponse response){

        return new Address(
                null,
                response.logradouro(),
                null,
                response.complemento(),
                response.bairro(),
                response.localidade(),
                response.uf(),
                response.cep()
    );
    }

    public AddressResponse toResponse(Address domainObj) {
        return new AddressResponse(
                domainObj.getId(),
                domainObj.getStreet(),
                domainObj.getZipCode(),
                domainObj.getNeighborhood(),
                domainObj.getCity(),
                domainObj.getState()
        );
    }

    public AddressCompleteResponse toCompleteResponse(Address domainObj) {
        return new AddressCompleteResponse(
                domainObj.getZipCode(),
                domainObj.getStreet(),
                domainObj.getComplement(),
                domainObj.getNeighborhood(),
                domainObj.getCity(),
                domainObj.getState()
        );
    }
}
