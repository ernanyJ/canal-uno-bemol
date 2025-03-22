package br.com.ernany.canaluno.infrastructure.dto.response;

public record ViaCepResponse(
        String cep,
        String logradouro,
        String complemento,
        String bairro,
        String localidade,
        String uf,
        String ddd
) {
}
