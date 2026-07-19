*** Settings ***
Library    SeleniumLibrary    timeout=10s
Library    FakerLibrary    locale=pt_BR
Resource   ../common.resource

*** Variables ***
${ROTA_CADASTRO}                ${WEB_URL}/cadastrarusuarios

${SELETOR_NOME_CADASTRO}        id:nome
${SELETOR_EMAIL_CADASTRO}       id:email
${SELETOR_SENHA_CADASTRO}       id:password
${CHECKBOX_ADMIN}               id:administrador
${BOTAO_CADASTRAR}              css:[data-testid="cadastrar"]
${BOTAO_ENTRAR_CADASTRO}        css:[data-testid="entrar"]

${TITULO_CADASTRO}              Cadastro
${MENSAGEM_SUCESSO_CADASTRO}    Cadastro realizado com sucesso

*** Keywords ***
Acessar Página De Cadastro
    Go To    ${ROTA_CADASTRO}
    Wait Until Page Contains  ${TITULO_CADASTRO}

Preencher Nome
    [Arguments]    ${nome}
    Input Text    ${SELETOR_NOME_CADASTRO}    ${nome}

Preencher Email
    [Arguments]    ${email}
    Input Text    ${SELETOR_EMAIL_CADASTRO}    ${email}

Preencher Senha
    [Arguments]    ${senha}
    Input Text    ${SELETOR_SENHA_CADASTRO}    ${senha}

Marcar Opção Administrador
    Click Element    ${CHECKBOX_ADMIN}

Clicar Em Cadastrar
    Click Button    ${BOTAO_CADASTRAR}

Clicar no link entrar do cadastro
    Click Element    ${BOTAO_ENTRAR_CADASTRO}

Gerar Usuário Aleatório
    ${nome}=     FakerLibrary.Name
    ${email}=    FakerLibrary.Email
    ${senha}=    FakerLibrary.Password
    RETURN    ${nome}    ${email}    ${senha}

Cadastrar Usuário Normal
    [Arguments]    ${nome}    ${email}    ${senha}
    Acessar Página De Cadastro
    Preencher Nome    ${nome}
    Preencher Email    ${email}
    Preencher Senha    ${senha}
    Clicar Em Cadastrar

Cadastrar Usuário Admin
    [Arguments]    ${nome}    ${email}    ${senha}
    Acessar Página De Cadastro
    Preencher Nome    ${nome}
    Preencher Email    ${email}
    Preencher Senha    ${senha}
    Marcar Opção Administrador
    Clicar Em Cadastrar

Cadastrar Usuário Normal Com Dados Aleatórios
    ${nome}    ${email}    ${senha}=    Gerar Usuário Aleatório
    Cadastrar Usuário Normal    ${nome}    ${email}    ${senha}
    RETURN    ${nome}    ${email}    ${senha}

Cadastrar Usuário Admin Com Dados Aleatórios
    ${nome}    ${email}    ${senha}=    Gerar Usuário Aleatório
    Cadastrar Usuário Admin    ${nome}    ${email}    ${senha}
    RETURN    ${nome}    ${email}    ${senha}

Ver mensagem de sucesso de cadastro
    Wait Until Page Contains    ${MENSAGEM_SUCESSO_CADASTRO}
    Page Should Contain    ${MENSAGEM_SUCESSO_CADASTRO}

Ser direcionado para a home de usuário normal
    Wait Until Location Contains    /home   
    Page Should Contain    ${NOME_APP}    

Ser direcionado para a home de usuário admin 
    [Arguments]  ${nome}
    Wait Until Location Contains    /admin/home    
    Wait Until Page Contains    Bem Vindo    
    Wait Until Page Contains    ${nome} 

Ver mensagem de erro cadastro 
    [Arguments]  ${erro}
    Wait Until Page Contains    ${erro}   
    Page Should Contain    ${erro}

Ver título página de cadastro
    Wait Until Page Contains  ${TITULO_CADASTRO}    
    Page Should Contain    ${TITULO_CADASTRO} 