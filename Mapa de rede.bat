@echo off
:in
title Mapeamento de rede
mode 50,14
color 1f
cls
echo.
echo ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ
echo      MAPEAMENTO DE REDES (Por: Lucas | lucas_developer@tutamail.com)
echo --------------------------------------------------
echo  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo __________________________________________________
set map=0
echo >"%temp%\0"
set /p map=N£mero de mapeamentos: 
if exist "%temp%\%map%" (
echo msgbox"Digite a quantidade de mapeamentos que deseja criar" ,vbcritical, "Mapa de Rede" > "%temp%\msg.vbs"
start %temp%\msg.vbs & goto in
)
set /a num=%map%+%map%
if %num% == 0 (
echo msgbox"Digite somente números" ,vbcritical, "Mapa de Rede" > "%temp%\msg.vbs
start %temp%\msg.vbs & goto in
)

setlocal enabledelayedexpansion
set cont=0
set server=%userdomain%
echo @echo off > "Map.bat"

for /l %%R in (1,1,%map%) do (
cls
mode 50,14
title Mapeamento [%%R de %map%]
color 1f
rem NOME DO SERVIDOR
echo.
echo ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ
echo  NOME OU IP DO SERVIDOR NA REDE  Mapeamento [%%R]
echo --------------------------------------------------
echo  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo  ³ SERVIDOR PADRÇO: !server! 
echo  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo       PRESSIONE [ENTER] PARA USAR PADRÇO    ³
echo  Ú------------------------------------------Ù
echo  ³
set /p server=.À- 

rem PASTA COMPARTILHADA
:compart
cls
echo.
echo ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ
echo  PASTA COMPARTILHADA EM REDE     Mapeamento [%%R]
echo --------------------------------------------------
echo  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo  ³ SERVIDOR: !server!
echo  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo         DIGITE O NOME DA PASTA ABAIXO       ³
echo  Ú------------------------------------------Ù
echo  ³
set pasta=0
set /p pasta=.À- 
if !pasta! == 0 (
echo msgbox"Digite o caminho da pasta compartilhada no servidor: !server!" ,vbexclamation, "Mapa de Rede" > "%temp%\msg.vbs
start %temp%\msg.vbs & goto compart
)

rem NOME DO COMPARTILHAMENTO
cls
set drive=Unidade Rede
echo.
echo ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ
echo  NOME DO COMPARTILHAMENTO        Mapeamento [%%R]
echo --------------------------------------------------
echo  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo  ³ PADRÇO: !drive! 
echo  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo       PRESSIONE [ENTER] PARA USAR PADRÇO    ³
echo  Ú------------------------------------------Ù
echo  ³
set /p drive=.À- 

rem LETRA DA UNIDADE
:und
cls
echo.
echo ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ
echo  LETRA DA UNIDADE COMPARTILHADA  Anterior [!und!:]
echo --------------------------------------------------
echo  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo  ³ COMPARTILHAMENTO: !drive! 
echo  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo    DIGITE E LETRA SEM USAR DOIS PONTOS ":"  ³
echo  Ú------------------------------------------Ù
echo  ³
set und=0
set /p und=.À- 
if !und! == 0 (
echo msgbox"Digite uma letra para a unidade compartilhada: !drive!" ,vbexclamation, "Mapa de Rede" > %temp%\msg.vbs
start %temp%\msg.vbs & goto und
)

cls
mode 50,12
color 1f
echo.
echo ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ
echo  AUTÒNTICAR LOGIN E SENHA        Mapeamento [%%R]
echo --------------------------------------------------
echo   ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿  
echo   ³ PRESSIONE [ENTER] SE NÇO FOR NECESSµRIO ³ 
echo  ÚÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
set autenticar=/USER:
set login=0
set /p login=.³ LOGIN: 
if !login! == 0 (set login=!login:0=! & set autenticar=!autenticar:/USER:=!)

echo net use !und!: "\\!server!\!pasta!" !autenticar!!login! /persistent:yes ^>nul >> "Map.bat"
echo echo CreateObject("Shell.Application"^).NameSpace ("!und!:\"^).Self.Name = "!drive!" ^> "%%temp%%\RenDrive.vbs" >> "Map.bat"
echo start /wait %%temp%%\RenDrive.vbs >> "Map.bat"
echo 
)
set code=%random%
ren "Map.bat" "Map_%code%.bat"
echo msgbox"Configuração do script [Map_%code%.bat] concluida com [%map%] mapeamentos." ,vbsystemmodal, "Mapa de Rede" > "%temp%\msg.vbs
start %temp%\msg.vbs & goto in
