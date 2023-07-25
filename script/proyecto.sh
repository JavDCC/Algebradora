#!/bin/bash

#La direccion inicial del proyecto
# a="$(pwd)"
# origin="$0"/
# origin="${origin//./}"

#El argumento pasado al script:
arg=$1
#La lista de comandos posibles para el script
posarg=("run" "clean" "report" "slides" "show_report" "show_slides")
#El tipo de sistema operativo actual del equipo
thisOS=$(echo "$OSTYPE" | tr '[:upper:]' '[:lower:]')

echo "Javier David Coroas Cintra - C113 - Practicas Laborales MATCOM 2023"

if [ "$0" != "./proyecto.sh" ] && [ "$0" != ".\proyecto" ]; then
    echo "Por precaucion, el script debe ser ejecutado desde la carpeta que lo contiene."
else
    if [ $# -lt 1 ]; then
        echo "Error: El comando debe contener un argumento."
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
            cd ..
            case $arg in
            "run")
                dotnet run
                ;;
            "clean")
                rm -rf -v bin obj
                cd informe
                for item in *; do
                    if [ "$item" != "informe.tex" ]; then
                        rm -rf -v "$item"
                    fi
                done
                cd ..
                cd presentacion
                for item in *; do
                    if [ "$item" != "presentacion.tex" ]; then
                        rm -rf -v "$item"
                    fi
                done
                cd ..
                ;;
            "report")
                cd informe
                pdflatex informe.tex
                ;;
            "slides")
                cd presentacion
                pdflatex presentacion.tex
                ;;
            "show_report")
                cd informe
                if ! [ -f "informe.pdf" ]; then
                    pdflatex informe.tex
                fi

                case $thisOS in
                "msys" | "cygwin")
                    start "$2" "informe.pdf"
                    ;;
                "darwin")
                    if [ -z "$2" ]; then
                        open "informe.pdf"
                    else
                        open -a "$2" "informe.pdf"
                    fi
                    ;;
                "linux-gnu")
                    xdg-open "$2" "informe.pdf"
                    ;;
                *)
                    echo "Error: Sistema operativo desconocido. No se pudo abrir el archivo."
                    ;;
                esac
                ;;
            "show_slides")
                cd presentacion
                if ! [ -f "presentacion.pdf" ]; then
                    pdflatex presentacion.tex
                fi
                case $thisOS in
                "msys" | "cygwin")
                    start "$2" "presentacion.pdf"
                    ;;
                "darwin")
                    if [ -z "$2" ]; then
                        open "presentacion.pdf"
                    else
                        open -a "$2" "presentacion.pdf"
                    fi
                    ;;
                "linux-gnu")
                    xdg-open "$2" "presentacion.pdf"
                    ;;
                *)
                    echo "Error: Sistema operativo desconocido. No se pudo abrir el archivo."
                    ;;
                esac
                ;;
            esac
        fi
    fi
fi

echo -e "\nPresiona cualquier tecla para continuar..."
read -n 1 -s -r
reset
