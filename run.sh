#!/bin/bash
echo "Available commands:"
echo ""
echo "  build       - docker compose build --no-cache"
echo "  up          - docker compose up -d"
echo "  down        - docker compose down"
echo "  start       - docker compose start"
echo "  stop        - docker compose stop"
echo "  logs        - docker compose logs -f mongo"
echo "  restart     - docker compose restart mongo"
echo ""
echo ""

read -p "Enter command: " CMD

case "$CMD" in
  build) docker compose build --no-cache ;;
  up) docker compose up -d ;;
  down) docker compose down ;;
  start) docker compose start ;;
  stop) docker compose stop ;;
  logs) docker compose logs -f mongo ;;
  restart) docker compose restart mongo ;;
  *) echo "Unknown command: $CMD" ;;
esac
