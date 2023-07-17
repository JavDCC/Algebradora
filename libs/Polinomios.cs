class Polinomio
{
    public Polinomio(string id, string sample)
    {
        this.ID = id;
        List<string> l = Check(Cut(sample.ToLower()));



    }

    private List<string> Cut(string s)
    {
        List<string> l = new List<string>();
        string temp = "";
        for (int i = 0; i < s.Length; i++)
        { if (s[i] == ',') { l.Add(temp); temp = ""; i++; } else { temp += s[i]; } }
        return l;
    }

    private List<string> Check(List<string> l)
    {
        for (int i = 0; i < l.Count; i++)
        { if (!IsValid(l[i])) { l.Remove(l[i]); i--; } else { l[i] = Fix(l[i]); } }
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

    private string Fix(string s)
    {
        //Eliminar caracteres no deseados
        for (int i = 0; i < s.Length; i++)
        { if (!"1234567890x+-".Contains(s[i])) s = s.Remove(i, 1); i--; }
        return s;
    }



    string ID;
    int[] Coeficientes;
}