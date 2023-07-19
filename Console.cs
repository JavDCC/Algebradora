using static System.Console;

bool exit = false;
List<Polinomio> Pols = new List<Polinomio>();

void Generar()
{
    Clear();
    Write("Introduzca un identificador: ");
    string id = ReadLine();
    Write("Escriba la expresion del polinomio:\n  ");
    string expresion = ReadLine();
    try { Pols.Add(new Polinomio(id, expresion)); }
    catch (Exception E) { Clear(); WriteLine(E.Message); }
}

void Sumar()
{
    Clear();
    WriteLine("Polinomios generados:");
    for (int i = 0; i < Pols.Count; i++)
    { WriteLine("  [" + i + "]" + "'" + Pols[i] + "'"); }
    WriteLine("\nEscriba el indice del primer polinomio: ");
    string pri = ReadLine();
    WriteLine("\nEscriba el indice del segundo polinomio: ");
    string seg = ReadLine();
    try
    {
        Polinomio P = Polinomio.SumarPolinomios(Pols[int.Parse(pri)], Pols[int.Parse(seg)]);
        Pols.Add(P);
        Clear();
        WriteLine("Suma efectuada: " + P);
    }
    catch (Exception E) { Clear(); WriteLine(E.Message); }
    WriteLine("\n  Presiona cualquie tecla para continuar");
    ReadKey(true);
}


while (!exit)
{
    Clear();
    string Main =
    "Seleccione la opcion deseada:\n" +
    "  [1] - Generar un polinomio\n" +
    "  [2] - Sumar polinomios\n" +
    "  [3] - Cerrar el programa\n";
    WriteLine(Main);
    switch (ReadKey(true).Key)
    {
        case ConsoleKey.D3:
        case ConsoleKey.NumPad3:
            Clear();
            WriteLine("\n  Presione 3 de nuevo para confirmar");
            ConsoleKey C = ReadKey(true).Key;
            if (C == ConsoleKey.D3 || C == ConsoleKey.NumPad3)
            { exit = true; }
            break;

        case ConsoleKey.D2:
        case ConsoleKey.NumPad2:
            if (Pols.Count == 0)
            { Clear(); WriteLine("\n  Debe generar al menos un polinomio primero"); ReadKey(true); break; }
            Sumar();
            break;
        case ConsoleKey.D1:
        case ConsoleKey.NumPad1:
            Generar();
            break;
    }
}

Clear();