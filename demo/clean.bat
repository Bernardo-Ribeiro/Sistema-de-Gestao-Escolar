@echo off
echo ====================================
echo  Limpeza Completa do Projeto
echo ====================================
echo.
echo Removendo pasta target...
if exist target rmdir /s /q target
echo.
echo Recompilando projeto...
mvn clean compile
echo.
echo Limpeza concluida!
echo.
pause
