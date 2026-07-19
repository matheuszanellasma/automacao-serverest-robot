*** Settings ***
Library    SeleniumLibrary    timeout=10s
Library    FakerLibrary    locale=pt_BR
Resource  cadastro_page.resource
Resource  ../common.resource

*** Variables ***

${ROTA_LOGIN}                 ${WEB_URL}/login

${SELETOR_EMAIL_LOGIN}        id:email
${SELETOR_SENHA_LOGIN}        id:password
${BOTAO_CADASTRE-SE_LOGIN}    css:[data-testid="cadastrar"]
${BOTAO_ENTRAR_LOGIN}         css:[data-testid="entrar"]

${TITULO_LOGIN}               Login


*** Keywords ***
Ter usuário normal cadastrado
    Acessar Página De Cadastro
    ${nome}    ${email}    ${senha}=  Cadastrar Usuário Normal Com Dados Aleatórios
    Ver mensagem de sucesso de cadastro
    Ser direcionado para a home de usuário normal
    RETURN  ${nome}    ${email}    ${senha}

Ter usuário admin cadastrado
    Acessar Página De Cadastro
    ${nome}    ${email}    ${senha}=  Cadastrar Usuário Admin Com Dados Aleatórios
    Ver mensagem de sucesso de cadastro
    Ser direcionado para a home de usuário admin  ${nome}
    RETURN  ${nome}    ${email}    ${senha}

Acessar página de login
    Go To  ${ROTA_LOGIN}
    Wait Until Page Contains  ${TITULO_LOGIN}

Clicar no botão entrar do login
    Click Button  ${BOTAO_ENTRAR_LOGIN}

Logar usuário via UI
    [Arguments]  ${email}  ${senha}
    Acessar página de login
    Preencher Email  ${email}
    Preencher Senha  ${senha}
    Clicar no botão entrar do login

Ver mensagem de erro login
    [Arguments]  ${erro}
    Wait Until Page Contains    ${erro}   
    Page Should Contain    ${erro}

Clicar em Cadastre-se
    Click Element  ${BOTAO_CADASTRE-SE_LOGIN}

Ver título página de login
    Wait Until Page Contains   ${TITULO_LOGIN}
    Page Should Contain  ${TITULO_LOGIN}
