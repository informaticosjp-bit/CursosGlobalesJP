using System;
using System.IO;
using System.Text;

class Program
{
    static void Main()
    {
        string sample = "CapacitaciÃ³n prÃ¡ctica y avanzada... MÃ³dulo 1: Arquitectura de LLMs y la AnatomÃ­a del Prompt Perfecto (Framework RTFR)";
        byte[] latin1Bytes = Encoding.GetEncoding("iso-8859-1").GetBytes(sample);
        string fixedStr = Encoding.UTF8.GetString(latin1Bytes);
        Console.WriteLine("Fixed: " + fixedStr);
    }
}
