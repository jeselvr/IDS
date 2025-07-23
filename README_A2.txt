//Código del programa para realizar las operaciones de 2 valores
/* Autor: Jesel Valle Rivera
Fecha: 26 de julio de 2025 
Actividad 2: Operaciones básicas en C++ */

#include <iostream> 
#include <iomanip>  

using namespace std;
int main() {
    double numero1;
    double numero2;

    // 1. Que pida el ingreso de dos valores (ya sean enteros o decimales).
    cout << "Escribe el primer número: ";
    cin >> numero1; 

    cout << "Escribe el segundo número: ";
    cin >> numero2; 
    
    cout << endl;

    // 2. Que los sume, reste, multiplique y divida.
    double suma = numero1 + numero2;
    double resta = numero1 - numero2;
    double multiplicacion = numero1 * numero2;

    // En la división, es importante que el segundo número no sea 0
    if (numero2 == 0) {
        cout << "Error: No se puede dividir por cero." << endl;
    } else {
        double division = numero1 / numero2;

        // 3. Que los muestre en pantalla con su respectivo enunciado.
        cout << fixed << setprecision(2);
        
        cout << "La suma es: " << suma << endl;
        cout << "La resta es: " << resta << endl;
        cout << "La multiplicación es: " << multiplicacion << endl;
        cout << "La división es: " << division << endl;
    }

    return 0; 
}