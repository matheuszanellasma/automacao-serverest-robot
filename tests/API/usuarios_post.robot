*** Settings ***
Library  RequestsLibrary
Library  FakerLibrary  locale=pt_BR
Resource  ../../resources/API/usuarios_API.resource


*** Test Cases ***
Cadastrar usuário admin via API com sucesso
    [Tags]  smoke
    ${nome}  ${email}  ${senha}  ${resposta_cadastro}=  Criar usuário admin com dados aleatórios
    Ver cadastro realizado com sucesso    ${resposta_cadastro} 
    [Teardown]  Deletar usuário por id  ${resposta_cadastro.json()}[_id]


Cadastrar usuário normal via API com sucesso
    [Tags]  smoke
    ${nome}  ${email}  ${senha}  ${resposta_cadastro}=  Criar usuário normal com dados aleatórios
    Ver cadastro realizado com sucesso    ${resposta_cadastro} 
    [Teardown]  Deletar usuário por id  ${resposta_cadastro.json()}[_id]

Cadastrar usuário via API com email já cadastrado
    ${nome}  ${email}  ${senha}  ${resposta_cadastro}=  Criar usuário normal com dados aleatórios
    Ver cadastro realizado com sucesso    ${resposta_cadastro} 
    ${resposta_cadastro_duplicado}=  Criar usuário  ${nome}  ${email}  ${senha}  admin=true
    Ver código de erro de cadastro  ${resposta_cadastro_duplicado.status_code}  400
    Ver mensagem de erro de cadastro  ${resposta_cadastro_duplicado.json()}[message]  Este email já está sendo usado
    [Teardown]  Deletar usuário por id  ${resposta_cadastro.json()}[_id]


Validação De Cadastro via API Com Campos Inválidos
    [Template]    Validar erros de cadastro
    ${EMPTY}         teste@teste.com      123         true    nome             nome não pode ficar em branco
    Usuario teste    ${EMPTY}             123         true    email            email não pode ficar em branco
    Usuario teste    teste@teste.com      ${EMPTY}    true    password         password não pode ficar em branco
    Usuario teste    teste.com            123         true    email            email deve ser um email válido
    Usuario teste    teste@teste.com      123         0       administrador    administrador deve ser 'true' ou 'false'

*** Keywords ***
Validar erros de cadastro
    [Arguments]    ${nome}    ${email}    ${senha}    ${admin}    ${campo}    ${mensagem_esperada}
    ${resposta_cadastro}=    Criar usuário    ${nome}    ${email}    ${senha}    ${admin}
    Ver código de erro de cadastro    ${resposta_cadastro.status_code}    400
    Ver mensagem de erro de cadastro    ${resposta_cadastro.json()}[${campo}]    ${mensagem_esperada}
