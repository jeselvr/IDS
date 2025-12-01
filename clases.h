#pragma once
#pragma once

#include <iostream>
#include <string>
#include <algorithm>
#include <vector>

// #include <sql.h>
// #include <sqlext.h> 

// **********************************************
// CLASE BASE: EMPLEADO
// **********************************************
class Empleado {
protected:
    int noEmpleado;
    std::string nombre;
    std::string apellidoP;
    std::string apellidoM;
    std::string fechaNacimiento;
    std::string RFC;
    std::string nombreCentro;
    std::string descripcionPuesto;
    bool esDirectivo;

public:
    Empleado(int num, std::string n, std::string ap, std::string am, std::string fn,
        std::string nc, std::string dp, bool d)
        : noEmpleado(num), nombre(n), apellidoP(ap), apellidoM(am), fechaNacimiento(fn),
        nombreCentro(nc), descripcionPuesto(dp), esDirectivo(d)
    {
        calcularRFC();
    }

    void calcularRFC() {
        std::string iniciales_paterno = apellidoP.substr(0, 2);
        char inicial_nombre = nombre.at(0);

        std::string anio_cifras = fechaNacimiento.substr(2, 2);

        RFC = iniciales_paterno + inicial_nombre + anio_cifras + "XXX";
        std::transform(RFC.begin(), RFC.end(), RFC.begin(), ::toupper);
    }

    virtual void imprimirReporte() const {
        std::cout << "| " << noEmpleado
            << "\t| " << nombre << " " << apellidoP << " " << apellidoM
            << "\t| " << fechaNacimiento
            << "\t| " << RFC
            << "\t| " << nombreCentro
            << "\t| " << descripcionPuesto
            << "\t| " << (esDirectivo ? "Sí" : "No") << " |" << "\n";
    }

    virtual ~Empleado() {}
};

// **********************************************
// CLASE DERIVADA: DIRECTIVO
// **********************************************
class Directivo : public Empleado {
private:
    std::string numeroCentroSupervisa;
    bool prestacionesCombustible;

public:
    Directivo(int num, std::string n, std::string ap, std::string am, std::string fn,
        std::string nc, std::string dp, std::string numCS, bool pc)
        : Empleado(num, n, ap, am, fn, nc, dp, true),
        numeroCentroSupervisa(numCS), prestacionesCombustible(pc) {
    }

    void imprimirReporte() const override {
        Empleado::imprimirReporte();
    }
};