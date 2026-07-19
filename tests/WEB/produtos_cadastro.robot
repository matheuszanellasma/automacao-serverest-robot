*** Settings ***
Library  SeleniumLibrary
Resource  ../../resources/common.resource
Resource  ../../resources/API/auth_setup_API.resource
Resource  ../../resources/API/produtos_API.resource
Resource  ../../resources/WEB/produtos_cadastro_page.resource
Suite Setup       Preparar ambiente autenticado
Suite Teardown    Encerrar ambiente autenticado


*** Test Cases ***
Cadastrar produto via UI com sucesso
    [Tags]  smoke
    Acessar página de cadastro de produto
    ${nome}  ${preco}  ${descricao}  ${quantidade}=  Cadastrar produto com dados aleatórios
    Ver produto cadastrado com sucesso  ${nome}  ${preco}  ${descricao}  ${quantidade}
    [Teardown]  Deletar produto por nome  ${nome}


Cadastrar produto via UI com nome repetido
    Acessar página de cadastro de produto
    ${nome}  ${preco}  ${descricao}  ${quantidade}=  Cadastrar produto com dados aleatórios
    Ver produto cadastrado com sucesso  ${nome}  ${preco}  ${descricao}  ${quantidade}
    Acessar página de cadastro de produto
    Cadastrar produto  ${nome}  ${preco}  ${descricao}  ${quantidade}
    Ver mensagem de erro cadastro de produto  Já existe produto com esse nome
    [Teardown]  Deletar produto por nome  ${nome}


Validação De Cadastro de produto via UI Com Campos Inválidos
    [Template]    Validar Erro De Cadastro de produto
    ${EMPTY}    10          Produto teste    10          Nome é obrigatório
    Produto     ${EMPTY}    Produto teste    10          Preco é obrigatório
    Produto     10          ${EMPTY}         10          Descricao é obrigatório
    Produto     10          Produto teste    ${EMPTY}    Quantidade é obrigatório
    Produto     -1          Produto teste    10          Preco deve ser um número positivo
    Produto     0           Produto teste    10          Preco deve ser um número positivo
    Produto     10          Produto teste    -1          Quantidade deve ser maior ou igual a 0
   

Validar mensagem de token expirado no cadastro via UI
    Acessar página de cadastro de produto
    Remover token do navegador
    Cadastrar produto com dados aleatórios
    Ver mensagem de erro cadastro de produto  Token de acesso ausente, inválido, expirado ou usuário do token não existe mais


*** Keywords ***
Validar Erro De Cadastro de produto
    [Arguments]  ${nome}  ${preco}  ${descricao}  ${quantidade}  ${msg_erro}
    Acessar página de cadastro de produto
    Cadastrar produto  ${nome}  ${preco}  ${descricao}  ${quantidade}
    Ver mensagem de erro cadastro de produto  ${msg_erro}


