/*Código del programa para verificar si una persona
es o no mayor de edad*/
/* Autor: Jesel Valle Rivera
Fecha: 22 de julio de 2025 
Actividad 1: Cálculo de edad en C++ */

#include <iostream> 

using namespace std;
int main() {
    int edad; // Declaración de la variable para almacenar la edad

    // 1. Que pida el ingreso de un valor (edad)
    cout << "Ingresa tu edad: ";
    cin >> edad; 
    
    //Validación de que el número ingresado es positivo
    if (edad < 0) {
        cout << "La edad ingresada no es válida. Por favor, ingresa un número positivo." << endl;
    } else {
        // 2. Que determine si es mayor de edad o menor de edad
        /*3. Que lo muestre en pantalla con su respectivo enunciado, 
        si es mayor de edad o no */
        if (edad >= 18) {
            cout << "Tienes " << edad << " años. Eres MAYOR de edad." << endl;
        } else {
            cout << "Tienes " << edad << " años. Eres MENOR de edad." << endl;
        } 
    }
    return 0; 
}