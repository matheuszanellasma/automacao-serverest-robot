*** Settings ***
Library  RequestsLibrary
Resource  ../../resources/common.resource
Resource  ../../resources/API/usuarios_API.resource
Resource  ../../resources/API/login_API.resource


*** Test Cases ***
Login de usuário admin via API com sucesso
    [Tags]  smoke
    ${nome}  ${email}  ${senha}  ${resposta_cadastro}=  Criar usuário admin com dados aleatórios
    Ver cadastro realizado com sucesso  ${resposta_cadastro}
    ${resposta_login}=  Logar usuário via API  ${email}  ${senha}
    Ver login realizado com sucesso  ${resposta_login}
    [Teardown]  Deletar usuário por id  ${resposta_cadastro.json()}[_id]


Login de usuário normal via API com sucesso
    [Tags]  smoke
    ${nome}  ${email}  ${senha}  ${resposta_cadastro}=  Criar usuário normal com dados aleatórios
    Ver cadastro realizado com sucesso  ${resposta_cadastro}
    ${resposta_login}=  Logar usuário via API  ${email}  ${senha}
    Ver login realizado com sucesso  ${resposta_login}
    [Teardown]  Deletar usuário por id  ${resposta_cadastro.json()}[_id]


Login de usuário via API com senha errada
    ${nome}  ${email}  ${senha}  ${resposta_cadastro}=  Criar usuário normal com dados aleatórios
    Ver cadastro realizado com sucesso  ${resposta_cadastro}
    ${resposta_login}=  Logar usuário via API  ${email}  ${senha}+1
    Ver código de erro de login   ${resposta_login.status_code}    401
    Ver mensagem de erro de login  ${resposta_login.json()}[message]  Email e/ou senha inválidos
    [Teardown]  Deletar usuário por id  ${resposta_cadastro.json()}[_id]

Validação De Login via API Com Campos Inválidos
    [Template]    Validar erros de login
    ${EMPTY}           123         email      email não pode ficar em branco 
    teste@teste.com    ${EMPTY}    password   password não pode ficar em branco
    teste.com          123         email      email deve ser um email válido


*** Keywords ***
Validar erros de login
    [Arguments]  ${email}  ${senha}  ${campo}  ${mensagem_esperada}
    ${resposta_login}=  Logar usuário via API  ${email}  ${senha}
    Ver código de erro de login   ${resposta_login.status_code}    400
    Ver mensagem de erro de login  ${resposta_login.json()}[${campo}]  ${mensagem_esperada}
    


