/* Autor: Jesel Valle Rivera
Fecha: 08 de agosto de 2025
Actividad 3: Aplicación para cálculo de RFC en C++ */

#include <iostream>
#include <string>
#include <vector>
#include <cctype>   // Para std::toupper
#include <sstream>  // Para std::stringstream
#include <iomanip>  // Para std::setw, std::setfill

// Diccionario de palabras NO permitidas
const std::vector<std::string> palabrasProhibidas = {
    "BUEI", "BUEY", "CACA", "CACO", "CAGA", "CAGO", "CAKA", "CAKO", "COGE", "COJA", "COJE", "COJI", "COJO", "CULO", "FETO", 
    "GUEY", "JOTO", "KACA", "KACO", "KAGA", "KAGO", "KOGE", "KOJO", "KAKA", "KULO", "LOCA", "MAME", "MAMO", "MEAR", "MEAS", 
    "MEON", "MION", "MOCO", "MULA", "PEDA", "PEDO", "PENE", "POPO", "PUTO", "PUTA", "QULO", "RATA", "RUIN"
};

class RFCGenerador {
private:
    std::string nombre;
    std::string apellidoPaterno;
    std::string apellidoMaterno;
    int diaNacimiento;
    int mesNacimiento;
    int anioNacimiento;

    // Función auxiliar para convertir a mayúsculas
    std::string aMayusculas(std::string texto) {
        for (char &c : texto) {
            c = std::toupper(static_cast<unsigned char>(c));
        }
        return texto;
    }

    // Función auxiliar para obtener la primera vocal interna
    char obtenerPrimeraVocalInterna(const std::string& texto) {
        if (texto.length() < 2) {
            return 'X';
        }
        for (size_t i = 1; i < texto.length(); ++i) {
            char c = std::toupper(static_cast<unsigned char>(texto[i]));
            if (c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U') {
                return c;
            }
        }
        return 'X'; // Si no encuentra ninguna vocal interna, se usa una 'X'
    }

    // Función para corregir palabras prohibidas en las primeras 4 letras
    std::string corregirPrimeras4(const std::string& primeras4) {
        for (const std::string& palabra : palabrasProhibidas) {
            if (primeras4 == palabra) {
                return primeras4.substr(0, 3) + "X";
            }
        }
        return primeras4;
    }

public:
    RFCGenerador(std::string nom, std::string apPat, std::string apMat, int dia, int mes, int anio)
        : nombre(aMayusculas(nom)),
          apellidoPaterno(aMayusculas(apPat)),
          apellidoMaterno(aMayusculas(apMat)),
          diaNacimiento(dia),
          mesNacimiento(mes),
          anioNacimiento(anio) {}

    std::string generarRFC() {
        std::string primeras4 = "";

        // 1. Primeros 2 caracteres (apellido paterno)
        if (!apellidoPaterno.empty()) {
            primeras4 += apellidoPaterno[0];
            primeras4 += obtenerPrimeraVocalInterna(apellidoPaterno);
        } else {
            primeras4 += "XX";
        }

        // 2. 3ra posición (apellido materno)
        if (!apellidoMaterno.empty()) {
            primeras4 += apellidoMaterno[0];
        } else {
            primeras4 += 'X';
        }

        // 3. 4ta posición (inicial del primer nombre)
        if (!nombre.empty()) {
            primeras4 += nombre[0];
        } else {
            primeras4 += 'X';
        }

        // Corregir las 4 primeras letras si es una palabra prohibida
        primeras4 = corregirPrimeras4(primeras4);

        // Generar la fecha en formato YYMMDD
        std::stringstream ssAnio, ssMes, ssDia;
        ssAnio << std::setw(2) << std::setfill('0') << (anioNacimiento % 100);
        ssMes << std::setw(2) << std::setfill('0') << mesNacimiento;
        ssDia << std::setw(2) << std::setfill('0') << diaNacimiento;

        return primeras4 + ssAnio.str() + ssMes.str() + ssDia.str();
    }
};

int main() {
    std::string nombre, apellidoPaterno, apellidoMaterno;
    int dia, mes, anio;

    std::cout << "Calculo de RFC" << std::endl;

    std::cout << "Introduce tu nombre: ";
    std::getline(std::cin, nombre);

    std::cout << "Introduce tu apellido paterno: ";
    std::getline(std::cin, apellidoPaterno);

    std::cout << "Introduce tu apellido materno: ";
    std::getline(std::cin, apellidoMaterno);

    std::cout << "Fecha de nacimiento (solo números)" << std::endl;
    std::cout << "Dia (Ej. 04): ";
    std::cin >> dia;
    std::cout << "Mes (Ej. 07): ";
    std::cin >> mes;
    std::cout << "Año (Ej. 1994): ";
    std::cin >> anio;

    // Validación completa de la fecha
    bool fechaValida = true;
    int diasDelMes = 0;

    // 1. Validar el año y el mes
    if (anio < 1900 || anio > 2025) {
        std::cout << "Error: El año " << anio << " no es válido." << std::endl;
        fechaValida = false;
    }
    if (mes < 1 || mes > 12) {
        std::cout << "Error: El mes " << mes << " no es válido." << std::endl;
        fechaValida = false;
    }

    // Si el año y el mes son válidos, determinamos el número de días que tiene ese mes
    if (fechaValida) {
        switch (mes) {
            case 1: case 3: case 5: case 7: case 8: case 10: case 12:
                diasDelMes = 31;
                break;
            case 4: case 6: case 9: case 11:
                diasDelMes = 30;
                break;
            case 2: // Mes de febrero
                // Verificamos si el año es bisiesto
                if ((anio % 4 == 0 && anio % 100 != 0) || (anio % 400 == 0)) {
                    diasDelMes = 29;
                } else {
                    diasDelMes = 28;
                }
                break;
        }

        // 2. Validar el día con base en el número de días del mes
        if (dia < 1 || dia > diasDelMes) {
            std::cout << "Error: El día " << dia << " no es válido para el mes " << mes << "." << std::endl;
            fechaValida = false;
        }
    }

    if (!fechaValida) {
        std::cout << "\nEl programa finalizará debido a un error en la fecha." << std::endl;
        return 1;
    }

    // Si la fecha es válida, procedemos con el cálculo del RFC
    RFCGenerador rfcCalculator(nombre, apellidoPaterno, apellidoMaterno, dia, mes, anio);
    std::string rfcGenerado = rfcCalculator.generarRFC();

    std::cout << "Tu RFC sin homoclave es: " << rfcGenerado << std::endl;

    return 0;
}