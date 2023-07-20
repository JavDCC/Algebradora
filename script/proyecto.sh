#!/bin/bash

#El argumento pasado al script:
arg=$1
#La lista de comandos posibles para el script
list=("run" "clean" "report" "slides" "show_report" "show_slides")

echo "Javier David Coroas Cintra - C113 - Practicas Laborales MATCOM 2023"

if [ $# -lt 1 ]; then
    echo -e "Error: El comando debe contener un argumento."
    echo "Posibles argumentos: 'run' 'clean' 'report' 'slides' 'show_report' y 'show_slides'."
else
    valid=false
    for item in "${list[@]}"; do
        if [ "$arg" == "$item" ]; then
            valid=true
        fi
    done
    if [ $valid == false ]; then
        echo "Error: $arg no es un argumento valido."
        echo "Posibles argumentos: 'run' 'clean' 'report' 'slides' 'show_report' y 'show_slides'."
    else
        if [ $# -gt 1 ]; then
            echo "Error: Solo se acepta '$arg' como argumento. Se ignora el resto."
        else
            cd ..
            case $arg in
            "run")
                Run
                ;;
            "clean")
                Clean
                ;;
            "report")
                MakePDF "informe"
                ;;
            "slides")
                MakePDF "presentacion"
                ;;
            "show_report")
                #
                ;;
            "show_slides")
                #
                ;;
            esac
        fi
    fi
fi

function Run() {
    dotnet run
    echo -e "Se ha ejecutado 'dotnet run'."
}

function Clean() {
    dotnet clean
    rm -rf bin obj
    echo -e "Se ha ejecutado 'dotnet clean'."
    echo "Tambien se han eliminado los directorios 'bin' y 'obj'."
}

function MakePDF() {
    cd "$1" || return 0
    pdflatex ".tex"
    echo "Se ha generado el reporte."
}

function FindPDF() {
    cd "$1" || return 0
}
