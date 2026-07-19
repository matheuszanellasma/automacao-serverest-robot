*** Settings ***
Resource  ../../resources/WEB/login_page.resource
Resource  ../../resources/API/usuarios_API.resource
Suite Setup       Abrir navegador
Suite Teardown    Close Browser

*** Test Cases ***
Login Normal via UI Com Sucesso
    [Tags]  smoke
    ${nome}  ${email}  ${senha}  ${resposta_cadastro}=  Criar usuário normal com dados aleatórios
    Logar usuário via UI  ${email}  ${senha}    
    Ser direcionado para a home de usuário normal
    [Teardown]  Deletar usuário por id  ${resposta_cadastro.json()}[_id]    

Login admin via UI com sucesso
    [Tags]  smoke
    ${nome}  ${email}  ${senha}  ${resposta_cadastro}=  Criar usuário admin com dados aleatórios
    Logar usuário via UI  ${email}  ${senha} 
    Ser direcionado para a home de usuário admin  ${nome}
    [Teardown]  Deletar usuário por id  ${resposta_cadastro.json()}[_id] 

Login via UI com senha errada
    ${nome}  ${email}  ${senha}  ${resposta_cadastro}=  Criar usuário normal com dados aleatórios
    Logar usuário via UI  ${email}  ${senha}+1    
    Ver mensagem de erro login  Email e/ou senha inválidos
    [Teardown]  Deletar usuário por id  ${resposta_cadastro.json()}[_id] 
    

Validação De Login via UI Com Campos Inválidos
    [Template]    Validar Erros De Login
    ${EMPTY}                 123       Email é obrigatório
    teste@teste.com        ${EMPTY}    Password é obrigatório

Teste de redirecionamento do botão "Cadastre-se"
    Acessar página de login
    Clicar em Cadastre-se
    Ver título página de cadastro

*** Keywords ***
Validar Erros De Login
    [Arguments]  ${email}  ${senha}  ${erro}
    Logar usuário via UI  ${email}  ${senha}
    Ver mensagem de erro login  ${erro}