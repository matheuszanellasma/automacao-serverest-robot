[![CI](https://github.com/matheuszanellasma/automacao-serverest-robot/actions/workflows/push.yml/badge.svg)](https://github.com/matheuszanellasma/automacao-serverest-robot/actions)

# 🤖 Automação de Testes WEB e API da ServeRest com Robot Framework

## 💻 Sobre o projeto

Este repositório contém o projeto de automação de testes **de API e Web (UI)** para a aplicação **ServeRest**, uma aplicação pública utilizada para prática de testes de software. O objetivo deste projeto é garantir a qualidade, estabilidade e o funcionamento correto tanto dos endpoints da API quanto dos principais fluxos da interface web da aplicação.

## 🛠️ Tecnologias Utilizadas

Neste projeto, utilizamos as seguintes ferramentas:

- **[Robot Framework](https://robotframework.org/)**
- **[RequestsLibrary](https://github.com/MarketSquare/robotframework-requests):** requisições HTTP para os testes de API
- **[SeleniumLibrary](https://github.com/robotframework/SeleniumLibrary):** automação dos fluxos de interface web
- **[FakerLibrary](https://github.com/guykisel/robotframework-faker):** geração dinâmica de dados de teste, aumentando a cobertura de variações
- **Padrão de Projeto:** Page Object Model (Web) e Resource Files por domínio (API)
- **Bypass de login via API:** suítes de produto autenticam via API e injetam a sessão diretamente no navegador (`localStorage`), evitando depender da tela de login para testar outras funcionalidades
- **Isolamento e limpeza de dados:** cada suíte cria seus próprios dados de teste (usuários, produtos) e realiza a limpeza (`teardown`) ao final da execução, evitando resíduos no banco de dados e dependência entre execuções


## 🌐 Ambiente de Testes

🔗 **Aplicação Web:** [ServeRest Front-end](https://front.serverest.dev/)
🔗 **Documentação da API:** [ServeRest API](https://serverest.dev/?lang=pt-BR)

## 📁 Estrutura dos Testes

Os testes estão organizados em duas suítes principais, separadas por camada de teste, com os *resource files* também divididos entre `API/` e `WEB/`:

```
automacao-web-robot/
├── resources/
│   ├── API/
│   │   ├── auth_setup_API.resource
│   │   ├── login_API.resource
│   │   ├── produtos_API.resource
│   │   └── usuarios_API.resource
│   ├── WEB/
│   │   ├── cadastro_page.resource
│   │   ├── login_page.resource
│   │   └── produtos_cadastro_page.resource
│   └── common.resource
└── tests/
    ├── API/
    │   ├── login_post.robot
    │   └── usuarios_post.robot
    └── WEB/
        ├── cadastro.robot
        ├── login.robot
        └── produtos_cadastro.robot
```

### `tests/API/`
- `login_post.robot` – Autenticação via API: login com sucesso (admin e normal), senha incorreta e validação de campos obrigatórios
- `usuarios_post.robot` – Cadastro de usuários via API: cadastro com sucesso (admin e normal), e-mail já cadastrado e validação de campos obrigatórios

### `tests/WEB/`
- `cadastro.robot` – Cadastro de usuário via interface: cadastro com sucesso (admin e normal), e-mail já cadastrado, redirecionamento do botão "Entrar" e validação de campos obrigatórios
- `login.robot` – Autenticação via interface: login com sucesso (admin e normal), senha incorreta, redirecionamento do botão "Cadastre-se" e validação de campos obrigatórios
- `produtos_cadastro.robot` – Cadastro de produtos via interface: cadastro com sucesso, nome de produto repetido, validação de campos obrigatórios/regras de negócio (preço e quantidade não podem ser zero ou negativos) e mensagem de token expirado

Cada arquivo contém os casos de teste relacionados à sua funcionalidade, incluindo cenários de sucesso, validações de campos obrigatórios e regras de negócio específicas.

## ⚙️ Integração Contínua (CI/CD)

O projeto possui uma esteira automatizada de integração contínua implementada com **GitHub Actions**:

- **Gatilho:** A esteira é disparada automaticamente a cada evento de `push` realizado na branch `master`.
- **Ação:** O pipeline executa os testes **Smoke** 
- **Armazenamento:** O relatório é armazenado como artifact no GitHub por **30 dias**, permitindo análise dos resultados mesmo após a conclusão do pipeline.

## 👤 Autor

* **Matheus Koehler Zanella** - Quality Assurance Engineer
