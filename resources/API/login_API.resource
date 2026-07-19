*** Settings ***
Resource   ../common.resource
Library  RequestsLibrary

*** Variables ***
${LOGIN_URL}  ${API_URL}/login


*** Keywords ***
Logar usuário via API
    [Arguments]  ${email}  ${senha}
    ${body}=  Create Dictionary 
    ...  email=${email}
    ...  password=${senha}

    ${resposta_login}=  POST  ${LOGIN_URL}  json=${body}  expected_status=any
    RETURN  ${resposta_login}

    
Ver login realizado com sucesso  
    [Arguments]  ${resposta_login}
    Should Be Equal As Integers  ${resposta_login.status_code}  200
    Should Be Equal As Strings  ${resposta_login.json()}[message]  Login realizado com sucesso
    Should Not Be Empty  ${resposta_login.json()}[authorization]

Ver código de erro de login   
    [Arguments]  ${codigo_obtido}  ${codigo_esperado}
    Should Be Equal As Integers  ${codigo_obtido}  ${codigo_esperado}

Ver mensagem de erro de login
    [Arguments]  ${mensagem_obtida}  ${mensagem_esperada}
    Should Be Equal As Strings  ${mensagem_obtida}  ${mensagem_esperada}
