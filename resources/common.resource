*** Settings ***


*** Variables ***
${WEB_URL}    https://front.serverest.dev
${API_URL}    https://serverest.dev
${NOME_APP}   Serverest Store

*** Keywords ***
Abrir navegador
    IF    '%{CI=}' == 'true'
        Open Browser    ${WEB_URL}    chrome    options=add_argument("--headless=new");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--disable-gpu")
    ELSE
        Open Browser    ${WEB_URL}    chrome
    END