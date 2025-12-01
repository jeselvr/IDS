//Jesel Valle Rivera
//30 de noviembre de 2025

#include "Clases.h" 

void generarReporteDesdeBD() {

    std::cout << "--- INICIANDO CONSULTA SQL (Lógica ODBC simulada) ---\n";

    std::vector<Empleado*> listaEmpleados;


    listaEmpleados.push_back(new Empleado(
        1, "Jesus", "Vega", "Castro", "1988-03-26",
        "Tiendas Angel Flores Ropa", "Atiende al publico", false
    ));

    listaEmpleados.push_back(new Directivo(
        2, "Tomas Alonso", "Contreras", "Lafarga", "1980-01-01",
        "La Primavera Cajas", "Supervisa tiendas", "049002", true 
    ));

    listaEmpleados.push_back(new Directivo(
        3, "Carlos Fernando", "Rico", "Giron", "1988-03-26",
        "Tiendas Angel Flores Ropa", "Da seguimiento", "000201", false 
    ));

    listaEmpleados.push_back(new Directivo(
        4, "Zuli", "Galindo", "Estupinan", "1988-03-26",
        "Tiendas Angel Flores Ropa", "Realiza interfaces", "000201", true 
    ));

    listaEmpleados.push_back(new Empleado(
        5, "Jesel", "Valle", "Rivera", "1988-03-26",
        "Tiendas Angel Flores Ropa", "Desarrolla codigo", false
    ));


    std::cout << "\n========================================================================================================================\n";
    std::cout << "                                         REPORTE DE EMPLEADOS EMPRESA UNI\n";
    std::cout << "========================================================================================================================\n";

   
    std::cout << "| No. Emp | Nombre Completo\t\t\t| F. Nacim.\t| RFC\t\t| Nombre Centro\t\t\t| Desc. Puesto\t\t| ¿Es Directivo? |\n";
    std::cout << "------------------------------------------------------------------------------------------------------------------------\n";

    for (const auto& emp : listaEmpleados) {
        emp->imprimirReporte();
    }
    std::cout << "========================================================================================================================\n";

    for (auto emp : listaEmpleados) {
        delete emp;
    }
}

int main() {
    generarReporteDesdeBD();
    std::cout << "\nPresiona ENTER para salir...";
    std::cin.get();
    return 0;
}