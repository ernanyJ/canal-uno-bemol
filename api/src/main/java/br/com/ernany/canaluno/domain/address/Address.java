package br.com.ernany.canaluno.domain.address;

import java.util.UUID;

public class Address {

    public Address(UUID id, String street, String number, String complement, String neighborhood, String city, String state, String zipCode) {

        validateFields(street, neighborhood, city, state, zipCode);

        this.id = id;
        this.street = street;
        this.number = number;
        this.complement = complement;
        this.neighborhood = neighborhood;
        this.city = city;
        this.state = state;
        this.zipCode = zipCode;
    }

    private UUID id;
    private String street;
    private String number;
    private String complement;
    private String neighborhood;
    private String city;
    private String state;
    private String zipCode;

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getComplement() {
        return complement;
    }

    public void setComplement(String complement) {
        this.complement = complement;
    }

    public String getNeighborhood() {
        return neighborhood;
    }

    public void setNeighborhood(String neighborhood) {
        this.neighborhood = neighborhood;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    private static void validateFields(String street, String neighborhood, String city, String state, String zipCode) {

        zipCode = sanitizeZipCode(zipCode);

        if(street == null || street.isEmpty()) {
            throw new IllegalArgumentException("Street is required");
        }

        if(neighborhood == null || neighborhood.isEmpty()) {
            throw new IllegalArgumentException("Neighborhood is required");
        }

        if(city == null || city.isEmpty()) {
            throw new IllegalArgumentException("City is required");
        }

        if(state == null || state.isEmpty()) {
            throw new IllegalArgumentException("State is required");
        }

        if(zipCode.length() != 8) {
            throw new IllegalArgumentException("ZipCode must have 8 characters");
        }
    }

    private static String sanitizeZipCode(String zipCode) {
        if(zipCode != null) {
           return zipCode.replaceAll("[^0-9]", "");
        }
        throw new IllegalArgumentException("ZipCode is required");
    }

}
