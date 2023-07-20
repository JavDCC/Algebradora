#!/bin/bash

#El argumento pasado al script:
arg=$1
#La lista de comandos posibles para el script
posarg=("run" "clean" "report" "slides" "show_report" "show_slides")

echo "Javier David Coroas Cintra - C113 - Practicas Laborales MATCOM 2023"

if [ "$0" != "./proyecto.sh" ] && [ "$0" != ".\proyecto" ]; then
    echo "Por precaucion, el script debe ser ejecutado desde la carpeta que lo contiene."
    echo "Debe usar './proyecto.sh' o '.\proyecto.sh'."
else
    if [ $# -lt 1 ]; then
        echo -e "Error: El comando debe contener un argumento."
        echo "Argumentos: 'run' 'clean' 'report' 'slides' 'show_report' 'show_slides'."
    else
        valid=false
        for item in "${posarg[@]}"; do
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
                    dotnet run
                    ;;
                "clean")

                    rm -rf bin obj
                    cd informe
                    find x ! -name "*.tex" -exec rm -rf {} ';'
                    cd ..
                    cd presentacion
                    find x ! -name "*.tex" -exec rm -rf {} ';'
                    cd ..
                    ;;
                "report")
                    cd informe
                    pdflatex "informe.tex"
                    ;;
                "slides")
                    cd presentacion
                    pdflatex "presentacion.tex"
                    ;;
                "show_report")
                    cd informe
                    #
                    ;;
                "show_slides")
                    cd presentacion
                    #
                    ;;
                esac
            fi
        fi
    fi
fi
