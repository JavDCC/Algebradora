class Polinomio
{
    public Polinomio(string id, string sample)
    {
        this.ID = id;
        this.Coeficientes = Distribute(Check(Cut(Fix(sample.ToLower()))));
        this.Expresion = Build();
    }

    private string Fix(string s)
    {
        //Eliminar caracteres no validos
        for (int i = 0; i < s.Length; i++)
        { if (!"1234567890x+-".Contains(s[i])) { s = s.Remove(i, 1); i--; } }
        return s;
    }

    private List<string> Cut(string s)
    {
        List<string> l = new List<string>();
        //Convertir el string en una lista de elementos
        for (int i = 0; i < s.Length; i++)
            if (s[i] == 'x')
            {
                int from = 0;
                int to = 0;
                for (int j = i; j >= 0; j--)
                { if ("+-".Contains(s[j])) { from = j; break; } }
                for (int k = i; k <= s.Length; k++)
                {
                    if (k == s.Length) { to = k; break; }
                    else if ("+-".Contains(s[k])) { to = k; break; }
                }
                l.Add(s.Substring(from, (to - from)));
            }

        return l;
    }

    private List<string> Check(List<string> l)
    {
        //Revisar que elementos son validos o no
        for (int i = 0; i < l.Count; i++)
        {
            if (!IsValid(l[i]))
            { l.Remove(l[i]); i--; }
        }
        return l;
    }

    private bool IsValid(string s)
    {
        //Solo tiene una X
        if (!s.Contains('x') || s.IndexOf('x') != s.LastIndexOf('x')) { return false; }
        //Existe al menos un numero antes de la X
        for (int i = 0; i <= s.IndexOf('x'); i++)
        { if (char.IsNumber(s[i])) break; else if (s[i] == 'x') return false; }
        //Existe al menos un numero despues de la X
        for (int i = (s.Length - 1); i >= s.IndexOf('x'); i--)
        { if (char.IsNumber(s[i])) break; else if (s[i] == 'x') return false; }
        //Solo existe un signo '+' o '-' y ocupa indice cero
        if (Math.Max(s.LastIndexOf('+'), s.LastIndexOf('-')) > 0) return false;
        //Cumple con el formato '±axb' y es valido
        return true;
    }

    private int[] Distribute(List<string> l)
    {

        int[] Co = new int[l.Count];
        int[] Ex = new int[l.Count];
        //Guardando coeficientes y exponentes en arrays
        for (int i = 0; i < l.Count; i++)
        {
            Co[i] = int.Parse(l[i].Substring(0, l[i].IndexOf('x')));
            Ex[i] = int.Parse(l[i].Substring(l[i].IndexOf('x') + 1));
        }
        //Hallando el grado del polinomio
        foreach (int i in Ex) { if (this.Grado < i) this.Grado = i; }
        //Para guardar los valores
        int[] Values = new int[1 + this.Grado];
        for (int i = 0; i < Values.Length; i++) { Values[i] = 0; }
        //Los coeficientes se organizan segun el exponente
        for (int i = 0; i < l.Count; i++) { Values[Ex[i]] += Co[i]; }

        return Values;
    }

    private string Build()
    {
        string temp = "";
        for (int i = 0; i < this.Coeficientes.Length; i++)
        {
            if (this.Coeficientes[i] != 0)
            {
                temp = this.Coeficientes[i].ToString() + "x" + i + temp;
                if (i < (this.Coeficientes.Length - 1) && this.Coeficientes[i] > 0)
                { temp = "+" + temp; }
            }
        }
        return temp;
    }

    public override string ToString() => this.ID + " = " + this.Expresion;

    //Identificador del objeto
    public string ID { get; }
    //Expresion del polinomio
    public string Expresion { get; private set; }
    //Grado del polinomio 
    public int Grado { get; private set; } = 0;
    //Valores de los coeficientes del polinomio
    private int[] Coeficientes;
}