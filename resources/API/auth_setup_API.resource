*** Settings ***
Library    SeleniumLibrary
Resource   login_API.resource
Resource   usuarios_API.resource


*** Keywords ***
Preparar ambiente autenticado
    ${nome}  ${email}  ${senha}  ${resposta_cadastro}=  Criar usuário admin com dados aleatórios
    ${resposta_login}=  Logar usuário via API  ${email}  ${senha}

    Set Suite Variable    ${id_cadastro}    ${resposta_cadastro.json()}[_id]   # robotcode: ignore
    Set Suite Variable    ${token_autorizacao}     ${resposta_login.json()}[authorization]   # robotcode: ignore

    Open Browser    ${WEB_URL}    chrome
    Injetar autenticação no navegador    ${nome}    ${email}    ${token_autorizacao}   # robotcode: ignore

Injetar autenticação no navegador
    [Arguments]    ${email}    ${nome}    ${token_autorizacao}
    Execute Javascript
    ...    window.localStorage.setItem('serverest/userEmail', '${email}');
    ...    window.localStorage.setItem('serverest/userNome', '${nome}');
    ...    window.localStorage.setItem('serverest/userToken', '${token_autorizacao}');
    Reload Page

Encerrar ambiente autenticado
    Close Browser
    Deletar usuário por id    ${id_cadastro}   # robotcode: ignore

Remover token do navegador
    Execute Javascript    window.localStorage.removeItem('serverest/userToken');