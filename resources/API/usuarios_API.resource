*** Settings ***
Library  RequestsLibrary
Library  FakerLibrary  locale=pt_BR
Resource  ../common.resource

*** Variables ***
${USUARIOS_URL}  ${API_URL}/usuarios


*** Keywords ***
Criar usuário admin com dados aleatórios
    ${nome}=  FakerLibrary.Name  
    ${email}=  FakerLibrary.Email
    ${senha}=  FakerLibrary.Password

    ${body}=    Create Dictionary
    ...    nome=${nome}
    ...    email=${email}
    ...    password=${senha}
    ...    administrador=true

    ${resposta_cadastro}=    POST    ${USUARIOS_URL}    json=${body}

    RETURN  ${nome}  ${email}  ${senha}  ${resposta_cadastro}

Criar usuário normal com dados aleatórios
    ${nome}=  FakerLibrary.Name  
    ${email}=  FakerLibrary.Email
    ${senha}=  FakerLibrary.Password

    ${body}=    Create Dictionary
    ...    nome=${nome}
    ...    email=${email}
    ...    password=${senha}
    ...    administrador=false

    ${resposta_cadastro}=    POST    ${USUARIOS_URL}    json=${body}

    RETURN  ${nome}  ${email}  ${senha}  ${resposta_cadastro}

Criar usuário
    [Arguments]    ${nome}    ${email}    ${senha}    ${admin}=false

    ${body}=    Create Dictionary
    ...    nome=${nome}
    ...    email=${email}
    ...    password=${senha}
    ...    administrador=${admin}

    ${resposta_cadastro}=    POST    ${USUARIOS_URL}    json=${body}  expected_status=any

    RETURN  ${resposta_cadastro}

Ver cadastro realizado com sucesso
    [Arguments]    ${resposta_cadastro}
    Should Be Equal As Integers    ${resposta_cadastro.status_code}    201
    Should Be Equal As Strings    ${resposta_cadastro.json()}[message]    Cadastro realizado com sucesso
    Should Not Be Empty  ${resposta_cadastro.json()}[_id]


Deletar usuário por id
    [Arguments]    ${_id}
    ${resposta_delecao}=  DELETE  ${USUARIOS_URL}/${_id}
    Should Be Equal As Integers  ${resposta_delecao.status_code}   200
    Should Contain Any    ${resposta_delecao.json()}[message]
    ...    Registro excluído com sucesso
    ...    Nenhum registro excluído
    
Deletar usuário por email
    [Arguments]  ${email} 
    ${id_usuario}=  Buscar id de usuário por email  ${email}
    Deletar usuário por id  ${id_usuario}

Buscar id de usuário por email
    [Arguments]  ${email}
    ${resposta_busca_usuario}=    GET    ${USUARIOS_URL}    params=email=${email}    expected_status=200
    ${usuarios}=    Set Variable    ${resposta_busca_usuario.json()}[usuarios]
    ${usuario_id}=    Set Variable    ${usuarios}[0][_id]
    RETURN    ${usuario_id}

Ver mensagem de erro de cadastro
    [Arguments]  ${mensagem_obtida}  ${mensagem_esperada}
    Should Be Equal As Strings  ${mensagem_obtida}  ${mensagem_esperada}

Ver código de erro de cadastro
    [Arguments]  ${codigo_obtido}  ${codigo_esperado}
    Should Be Equal As Integers  ${codigo_obtido}  ${codigo_esperado}
