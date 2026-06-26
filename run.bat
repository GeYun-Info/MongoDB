@echo off
echo Available commands:
echo.
echo  build       - docker compose build --no-cache
echo  up          - docker compose up -d
echo  down        - docker compose down
echo  start        - docker compose start
echo  stop        - docker compose stop
echo  logs        - docker compose logs -f mongo
echo  restart     - docker compose restart mongo
echo.
echo.

set /p CMD="Enter command: "
if "%CMD%"=="build" docker compose build --no-cache
if "%CMD%"=="up" docker compose up -d
if "%CMD%"=="down" docker compose down
if "%CMD%"=="start" docker compose start
if "%CMD%"=="stop" docker compose stop
if "%CMD%"=="logs" docker compose logs -f mongo
if "%CMD%"=="restart" docker compose restart mongo
