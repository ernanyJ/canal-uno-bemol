
## Documentação de referência

### 🔧 Como executar o projeto

Antes de iniciar, certifique-se de ter os seguintes requisitos instalados:

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)


### Estrutura do Projeto

```
.
├── api                 # Backend (Java Spring Boot)
│   ├── dockerfile
│   ├── pom.xml
│   ├── src
│   └── target
├── docker-compose.yml  # Arquivo de configuração para execução via Docker Compose
├── web                 # Frontend (Flutter Web)
│   ├── dockerfile
│   ├── lib
│   ├── pubspec.yaml
│   └── web
```

### Executando o Projeto

Para iniciar a aplicação, execute o seguinte comando na raiz do projeto:

```sh
docker-compose up --build
```

Esse comando irá:
- Criar e iniciar os containers da API e do frontend web.
- Construir as imagens caso seja a primeira execução ou haja alterações.

### 📌 Clean Architecture

Este projeto foi desenvolvido seguindo os princípios da **Clean Architecture**, garantindo uma estrutura modular, desacoplada e de fácil manutenção.

### 💡 Por que Clean Architecture?
Optei por essa abordagem para assegurar:
- ✅ **Escalabilidade** – A separação de responsabilidades facilita a adição de novas funcionalidades sem impactar outras partes do sistema.
- ✅ **Testabilidade** – A estrutura modular permite a escrita de testes unitários mais eficazes.
- ✅ **Manutenção simplificada** – O código bem organizado reduz o impacto de mudanças e facilita a refatoração.
- ✅ **Independência de tecnologias** – A lógica de negócio não depende diretamente de frameworks, bancos de dados ou interfaces, tornando o sistema mais flexível.

### 🏗️ Camadas da Arquitetura
- **Domínio** – Contém regras de negócio puras e independentes.
- **Aplicação** – Gerencia casos de uso e fluxos da aplicação.
- **Infraestrutura** – Implementa serviços externos como banco de dados e APIs.

Essa estrutura garante um código mais robusto e preparado para crescer junto com o projeto. 🚀




