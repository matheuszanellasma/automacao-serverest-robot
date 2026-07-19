*** Settings ***
Resource  ../common.resource
Library  SeleniumLibrary
Library  FakerLibrary  locale=pt_BR

*** Variables ***
${ROTA_PRODUTOS_CADASTRO}                ${WEB_URL}/admin/cadastrarprodutos
${TITULO_CADASTRO_PRODUTO}               Cadastro de Produtos
${TITULO_LISTA_PRODUTO}                  Lista dos Produtos

${SELETOR_NOME_PRODUTO_CADASTRO}         id:nome
${SELETOR_PRECO_PRODUTO_CADASTRO}        id:price
${SELETOR_DESCRICAO_PRODUTO_CADASTRO}    id:description
${SELETOR_QUANTIDADE_PRODUTO_CADASTRO}   id:quantity


${BOTAO_CADASTRAR_PRODUTO}               css:[data-testid="cadastarProdutos"]


*** Keywords ***
Acessar página de cadastro de produto
    Go To  ${ROTA_PRODUTOS_CADASTRO}
    Wait Until Page Contains  ${TITULO_CADASTRO_PRODUTO}

Preencher nome produto
    [Arguments]  ${nome}
    Input Text  ${SELETOR_NOME_PRODUTO_CADASTRO}  ${nome}
    
Preencher preço produto
    [Arguments]  ${preco}
    Input Text  ${SELETOR_PRECO_PRODUTO_CADASTRO}  ${preco}
    
Preencher descrição produto
    [Arguments]  ${descricao}
    Input Text  ${SELETOR_DESCRICAO_PRODUTO_CADASTRO}  ${descricao}
    
Preencher quantidade produto
    [Arguments]  ${quantidade}
    Input Text  ${SELETOR_QUANTIDADE_PRODUTO_CADASTRO}  ${quantidade}

Clicar em cadastrar produto
    Click Button  ${BOTAO_CADASTRAR_PRODUTO}

Gerar produto aleatório
    ${nome}=        FakerLibrary.Name
    ${preco}=        FakerLibrary.Random Int    min=1    max=1000
    ${descricao}=   FakerLibrary.Paragraph
    ${quantidade}=    FakerLibrary.Random Int    min=1    max=20
    RETURN  ${nome}  ${preco}  ${descricao}  ${quantidade}


Cadastrar produto com dados aleatórios
    ${nome}  ${preco}  ${descricao}  ${quantidade}=  Gerar produto aleatório
    Preencher nome produto  ${nome}
    Preencher preço produto  ${preco}
    Preencher descrição produto  ${descricao}
    Preencher quantidade produto  ${quantidade}
    Clicar em cadastrar produto
    RETURN  ${nome}  ${preco}  ${descricao}  ${quantidade}

Cadastrar produto 
    [Arguments]  ${nome}  ${preco}  ${descricao}  ${quantidade}
    Preencher nome produto  ${nome}
    Preencher preço produto  ${preco}
    Preencher descrição produto  ${descricao}
    Preencher quantidade produto  ${quantidade}
    Clicar em cadastrar produto
    RETURN  ${nome}  ${preco}  ${descricao}  ${quantidade}

Ver mensagem de erro cadastro de produto
    [Arguments]  ${msg_erro}
    Wait Until Page Contains  ${msg_erro}
    Page Should Contain  ${msg_erro}

Ver título página de cadastro de produto
    Wait Until Page Contains  ${TITULO_CADASTRO_PRODUTO}    
    Page Should Contain    ${TITULO_CADASTRO_PRODUTO} 

Ver produto cadastrado com sucesso
    [Arguments]  ${nome}  ${preco}  ${descricao}  ${quantidade}
    Wait Until Page Contains  ${TITULO_LISTA_PRODUTO}
    Page Should Contain  ${TITULO_LISTA_PRODUTO}
    Wait Until Page Contains  ${nome}
    Page Should Contain  ${nome}    
    Page Should Contain  ${preco}
    Page Should Contain  ${descricao}
    Page Should Contain  ${quantidade}

