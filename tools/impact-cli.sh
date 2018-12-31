#/bin/bash

case "$1" in
  "dev-start")
    docker-compose -f dev.yml up -d
    ;;
  "dev-stop")
    docker-compose -f dev.yml down
    ;;
  "build")
    docker-compose -f build.yml up
    ;;
  "deploy")
    docker-compose -f deploy.yml up
    ;;
  "clean")
    rm -Rf ../dist
    ;;
  *)
	echo "Allowed arguments are dev-start, dev-stop, build and deploy." 
    echo "usage: ./impact-cli.sh [command]"
    echo "  dev-start     start development environment"
    echo "  dev-stop      stop development environment"
    echo "  build         build the distribution folder"
    echo "  deploy        deploy the distribution folder"
    echo "  clean         clean the distribution folder"
    exit 1
    ;;
esac
