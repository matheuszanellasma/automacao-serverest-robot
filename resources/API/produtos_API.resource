*** Settings ***
Library  RequestsLibrary
Resource  ../common.resource

*** Variables ***
${PRODUTOS_URL}  ${API_URL}/produtos


*** Keywords ***
Deletar produto por id
    [Arguments]    ${_id}
    ${headers}=    Create Dictionary    Authorization=${token_autorizacao}
    ${resposta_delecao}=  DELETE  ${PRODUTOS_URL}/${_id}  headers=${headers}  expected_status=200
    
Buscar ID de produto por nome
    [Arguments]  ${nome} 
    ${resposta_busca}=  GET  ${PRODUTOS_URL}  params=nome=${nome}    expected_status=200
    ${id_produto}=  Set Variable  ${resposta_busca.json()}[produtos][0][_id]
    RETURN  ${id_produto}

Deletar produto por nome
    [Arguments]  ${nome} 
    ${id_produto}=  Buscar ID de produto por nome  ${nome}
    Deletar produto por id  ${id_produto}