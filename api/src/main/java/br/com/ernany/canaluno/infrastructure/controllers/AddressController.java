package br.com.ernany.canaluno.infrastructure.controllers;

import br.com.ernany.canaluno.application.usecases.ValidateZipCodeInteractor;
import br.com.ernany.canaluno.domain.address.Address;
import br.com.ernany.canaluno.infrastructure.dto.response.AddressCompleteResponse;
import br.com.ernany.canaluno.infrastructure.exceptions.ZipCodeValidationException;
import br.com.ernany.canaluno.infrastructure.utils.dtoMappers.AddressDTOMapper;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/address")
public class AddressController {

    private final ValidateZipCodeInteractor validateZipCodeInteractor;
    private final AddressDTOMapper addressDTOMapper;

    public AddressController(ValidateZipCodeInteractor validateZipCodeInteractor, AddressDTOMapper addressDTOMapper) {
        this.validateZipCodeInteractor = validateZipCodeInteractor;
        this.addressDTOMapper = addressDTOMapper;
    }

    @GetMapping("/validate")
    public ResponseEntity<?> validateZipCode(@RequestParam(value = "zipCode") String zipCode) {
        try {
            Address domainObj = validateZipCodeInteractor.execute(zipCode);
            return ResponseEntity.ok(addressDTOMapper.toCompleteResponse(domainObj));
        } catch (ZipCodeValidationException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}
