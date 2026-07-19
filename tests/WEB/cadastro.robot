*** Settings ***
Resource          ../../resources/WEB/cadastro_page.resource
Resource          ../../resources/WEB/login_page.resource
Resource          ../../resources/API/usuarios_API.resource
Suite Setup       Open Browser    ${WEB_URL}    chrome
Suite Teardown    Close Browser

*** Test Cases ***
Cadastro Normal via UI Com Sucesso
    [Tags]    smoke
    ${nome}    ${email}    ${senha}=    Cadastrar Usuário Normal Com Dados Aleatórios
    Ver mensagem de sucesso de cadastro
    Ser direcionado para a home de usuário normal
    [Teardown]  Deletar usuário por email  ${email}  

Cadastro Admin via UI Com Sucesso
    [Tags]    smoke
    ${nome}    ${email}    ${senha}=    Cadastrar Usuário Admin Com Dados Aleatórios
    Ver mensagem de sucesso de cadastro
    Ser direcionado para a home de usuário admin  ${nome}
    [Teardown]  Deletar usuário por email  ${email}  

Cadastro via UI com email já cadastrado
    [Tags]    smoke
    ${nome}    ${email}    ${senha}=    Cadastrar Usuário Admin Com Dados Aleatórios
    Ver mensagem de sucesso de cadastro
    Ser direcionado para a home de usuário admin  ${nome}
    Cadastrar Usuário Admin  ${nome}    ${email}    ${senha}
    Ver mensagem de erro cadastro  Este email já está sendo usado
    [Teardown]  Deletar usuário por email  ${email}  

Teste de redirecionamento botão "Entrar"
    Acessar Página De Cadastro
    Clicar no link entrar do cadastro
    Ver título página de login

Validação De Cadastro via UI Com Campos Inválidos
    [Template]    Validar Erro De Cadastro
    ${EMPTY}          teste@teste.com     123        Nome é obrigatório
    usuario           ${EMPTY}            123        Email é obrigatório
    usuario           teste@com           123        Email deve ser um email válido
    usuario           teste@teste.com     ${EMPTY}   Password é obrigatório

*** Keywords ***
Validar Erro De Cadastro
    [Arguments]    ${nome}    ${email}    ${senha}    ${erro}
    Cadastrar Usuário Normal    ${nome}    ${email}    ${senha}
    Ver mensagem de erro cadastro  ${erro}