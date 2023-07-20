#!/bin/bash
# Javier David Coroas Cintra C113
# Script del proyecto de practicas laborales MATCOM 2023

arg=$1
list=("run" "clean" "report" "slides" "show_report" "show_slides")
options=$(echo "${list[*]}" | sed 's/ /,/g')

if [ $# -lt 1 ]; then
    echo -e "Error: El comando debe contener al menos un argumento."
    echo "Los posibles comandos son: $options."
    exit 1
fi

case $arg in
"run")
    cd ..
    dotnet run
    echo "Ha ejecutado el proyecto."
    exit 1
    ;;
"clean")
    cd ..
    dotnet clean
    rm -rf bin obj
    echo -e "Se ha ejecutado 'dotnet clean'."
    echo "Se han eliminado, junto a sus contenidos, los directorios 'bin' y 'obj'."
    exit 1
    ;;
"report")
    echo "Se ha generado el reporte."
    exit 1
    ;;
"slides")
    echo "Se ha generado la presentacion."
    exit 1
    ;;
"show_report")
    echo "$arg"
    exit 1
    ;;
"show_slides")
    echo "$arg"
    exit 1
    ;;
esac

if [ "$arg" != "${list[*]}" ]; then
    echo -e "Error: $arg no es un argumento valido."
    echo "Los posibles comandos son: $options."
    exit 1
fi
