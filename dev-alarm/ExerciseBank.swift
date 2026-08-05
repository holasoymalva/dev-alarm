//
//  ExerciseBank.swift
//  dev-alarm
//

import Foundation

struct ExerciseBank {
    static let allExercises: [Exercise] = [
        // MARK: - JAVASCRIPT EXERCISES
        Exercise(
            language: .javascript,
            title: "Referencia de Arrays",
            question: "¿Cuál es el valor impreso en la consola al ejecutar este código?",
            codeSnippet: """
let a = [1, 2];
let b = a;
b.push(3);
console.log(a.length);
""",
            options: ["2", "3", "undefined", "Error de compilación"],
            correctOptionIndex: 1,
            hint: "En JavaScript, los objetos y arrays se asignan por referencia, no por copia.",
            explanation: "Al hacer 'let b = a', ambas variables apuntan al mismo array en memoria. Modificar 'b' agregando un elemento también modifica 'a', por lo que el largo de 'a' pasa a ser 3."
        ),
        Exercise(
            language: .javascript,
            title: "Coerción de Tipos (Suma)",
            question: "¿Cuál es el resultado de la siguiente expresión?",
            codeSnippet: """
let resultado = "5" + 3;
console.log(resultado);
""",
            options: ["8", "53", "NaN", "TypeError"],
            correctOptionIndex: 1,
            hint: "El operador '+' se sobrecarga para concatenación cuando hay un string involucrado.",
            explanation: "Cuando uno de los operandos del operador '+' es un string, JavaScript convierte el otro operando (el número 3) en string y los concatena, dando como resultado '53'."
        ),
        Exercise(
            language: .javascript,
            title: "Coerción de Tipos (Resta)",
            question: "¿Cuál es el resultado de la siguiente expresión?",
            codeSnippet: """
let resultado = "5" - 3;
console.log(resultado);
""",
            options: ["2", "NaN", "TypeError", "53"],
            correctOptionIndex: 0,
            hint: "A diferencia de '+', el operador '-' no tiene significado para strings, por lo que JavaScript intenta convertir todo a números.",
            explanation: "El operador '-' realiza coerción numérica implícita. El string '5' se convierte al número 5 y se le resta 3, dando como resultado el número 2."
        ),
        Exercise(
            language: .javascript,
            title: "Tipo de dato Null",
            question: "¿Qué retorna la siguiente expresión?",
            codeSnippet: """
console.log(typeof null);
""",
            options: ["'null'", "'undefined'", "'object'", "'string'"],
            correctOptionIndex: 2,
            hint: "Es un error histórico conocido en el diseño de JavaScript que se ha mantenido por compatibilidad.",
            explanation: "En la primera implementación de JavaScript, los valores se representaban en tipos binarios. El valor null se representaba con el puntero cero, que compartía prefijo con los objetos. Por eso retorna 'object'."
        ),
        Exercise(
            language: .javascript,
            title: "Parámetros por Defecto",
            question: "¿Cuál es el resultado de llamar a la función f(3)?",
            codeSnippet: """
const f = (x, y = 2) => x * y;
console.log(f(3));
""",
            options: ["NaN", "3", "6", "TypeError"],
            correctOptionIndex: 2,
            hint: "Si no proporcionas el segundo parámetro, se usará el valor por defecto asignado en la declaración.",
            explanation: "La función define 'y' con un valor por defecto de 2. Al llamar 'f(3)', 'x' toma el valor 3 e 'y' toma el valor por defecto 2. El resultado de 3 * 2 es 6."
        ),
        Exercise(
            language: .javascript,
            title: "Precedencia de Operadores",
            question: "¿Cuál es el resultado impreso por este código?",
            codeSnippet: """
let x = true;
let y = false;
console.log(x || y && false);
""",
            options: ["true", "false", "undefined", "TypeError"],
            correctOptionIndex: 0,
            hint: "El operador AND (&&) tiene mayor precedencia que el operador OR (||) y se evalúa primero.",
            explanation: "Por precedencia de operadores, 'y && false' se evalúa primero dando 'false'. Luego se evalúa 'x || false' que equivale a 'true || false', lo cual es 'true'."
        ),
        Exercise(
            language: .javascript,
            title: "Map y Filter",
            question: "¿Cuál es el valor final de la constante 'res'?",
            codeSnippet: """
const arr = [1, 2, 3];
const res = arr.map(x => x * 2).filter(x => x > 3);
console.log(res);
""",
            options: ["[2, 4, 6]", "[4, 6]", "[6]", "[1, 2, 3]"],
            correctOptionIndex: 1,
            hint: "Primero aplicas la multiplicación a todos los elementos, luego filtras los que son mayores a 3.",
            explanation: "'arr.map(x => x * 2)' produce [2, 4, 6]. Luego, '.filter(x => x > 3)' mantiene solo los elementos mayores a 3, es decir, [4, 6]."
        ),
        Exercise(
            language: .javascript,
            title: "Propiedades Inexistentes",
            question: "¿Qué se imprime en la consola tras borrar la propiedad?",
            codeSnippet: """
const o = { x: 1 };
delete o.x;
console.log(o.x);
""",
            options: ["null", "undefined", "1", "ReferenceError"],
            correctOptionIndex: 1,
            hint: "Acceder a una propiedad que no existe en un objeto en JS no arroja un error, sino un valor especial.",
            explanation: "Al usar 'delete o.x', la propiedad 'x' se elimina completamente del objeto. Acceder a cualquier propiedad inexistente en JS devuelve 'undefined'."
        ),
        
        // MARK: - PYTHON EXERCISES
        Exercise(
            language: .python,
            title: "Indexación Negativa",
            question: "¿Qué imprime el siguiente código?",
            codeSnippet: """
x = [1, 2, 3]
print(x[-1])
""",
            options: ["1", "3", "IndexError", "None"],
            correctOptionIndex: 1,
            hint: "En Python, los índices negativos empiezan a contar desde el final de la colección.",
            explanation: "El índice -1 hace referencia al último elemento de la lista, que en este caso es el número 3."
        ),
        Exercise(
            language: .python,
            title: "Slicing de Strings",
            question: "¿Cuál es el resultado de este recorte de texto (slice)?",
            codeSnippet: """
x = "Python"
print(x[1:4])
""",
            options: ["\"Pyt\"", "\"yth\"", "\"ytho\"", "\"yt\""],
            correctOptionIndex: 1,
            hint: "El slicing en Python es inclusivo en el inicio y exclusivo en el fin: [inicio:fin].",
            explanation: "El recorte x[1:4] toma los caracteres en las posiciones 1, 2 y 3. En 'Python', el índice 1 es 'y', el 2 es 't' y el 3 es 'h'. El resultado es 'yth'."
        ),
        Exercise(
            language: .python,
            title: "Método get en Diccionarios",
            question: "¿Qué valor se imprime en pantalla?",
            codeSnippet: """
d = {"a": 1}
print(d.get("b", 2))
""",
            options: ["1", "None", "2", "KeyError"],
            correctOptionIndex: 2,
            hint: "El método get busca una llave y, si no existe, devuelve el valor por defecto proporcionado como segundo argumento.",
            explanation: "La llave 'b' no existe en el diccionario 'd'. El método '.get()' en lugar de lanzar un KeyError, retorna el valor por defecto especificado: 2."
        ),
        Exercise(
            language: .python,
            title: "Comprensión de Listas",
            question: "¿Cuál es el valor final de la lista 'x'?",
            codeSnippet: """
x = [i for i in range(5) if i % 2 == 0]
print(x)
""",
            options: ["[0, 2, 4]", "[2, 4]", "[0, 1, 2, 3, 4]", "[1, 3]"],
            correctOptionIndex: 0,
            hint: "range(5) genera números del 0 al 4. Evaluamos la condición de número par.",
            explanation: "range(5) produce 0, 1, 2, 3, 4. La condición 'i % 2 == 0' filtra solo los números pares. Así, la lista resultante es [0, 2, 4]."
        ),
        Exercise(
            language: .python,
            title: "División Entera",
            question: "¿Qué valor se guarda en la variable x?",
            codeSnippet: """
x = 5 // 2
print(x)
""",
            options: ["2.5", "2", "3", "2.0"],
            correctOptionIndex: 1,
            hint: "El operador '//' realiza una división de piso (floor division).",
            explanation: "El operador '//' divide los números y redondea hacia abajo al entero más cercano. 5 dividido por 2 es 2.5, redondeado hacia abajo es 2."
        ),
        Exercise(
            language: .python,
            title: "Referencias en Listas",
            question: "¿Cuál es el largo de la lista 'a' al final?",
            codeSnippet: """
a = [1, 2]
b = a
b.append(3)
print(len(a))
""",
            options: ["2", "3", "4", "AttributeError"],
            correctOptionIndex: 1,
            hint: "En Python, al asignar una lista a otra variable se copia la referencia al objeto.",
            explanation: "'b' apunta a la misma lista que 'a'. Por lo tanto, usar 'b.append(3)' altera la lista subyacente y modifica el largo de 'a' a 3."
        ),
        Exercise(
            language: .python,
            title: "Multiplicación de Strings",
            question: "¿Qué imprime esta operación en Python?",
            codeSnippet: """
print("py" * 3)
""",
            options: ["\"py3\"", "\"pypypy\"", "\"py py py\"", "TypeError"],
            correctOptionIndex: 1,
            hint: "En Python, multiplicar un string por un entero repite el string ese número de veces.",
            explanation: "El operador '*' cuando se aplica a un string y un entero realiza repetición. 'py' repetido 3 veces resulta en 'pypypy'."
        ),
        Exercise(
            language: .python,
            title: "Inmutabilidad de Tuplas",
            question: "¿Qué sucede al intentar ejecutar esta asignación?",
            codeSnippet: """
x = (1, 2)
x[0] = 3
""",
            options: ["x pasa a ser (3, 2)", "TypeError: tuple object does not support item assignment", "SyntaxError", "None"],
            correctOptionIndex: 1,
            hint: "Las tuplas son colecciones ordenadas e inmutables, a diferencia de las listas.",
            explanation: "Las tuplas en Python son inmutables. Una vez creadas, no puedes reasignar o modificar sus elementos. Intentar hacerlo lanza un 'TypeError'."
        ),
        
        // MARK: - JAVA EXERCISES
        Exercise(
            language: .java,
            title: "División de Enteros",
            question: "¿Qué imprime este fragmento de código Java?",
            codeSnippet: """
int x = 5;
int y = 2;
double z = x / y;
System.out.println(z);
""",
            options: ["2.5", "2.0", "2", "Error de compilación"],
            correctOptionIndex: 1,
            hint: "La división de dos enteros en Java resulta en un entero antes de ser asignado a un tipo double.",
            explanation: "Dado que 'x' e 'y' son enteros, 'x / y' hace una división entera dando como resultado 2. Luego, ese 2 se convierte implícitamente a double para guardarse en 'z', resultando en 2.0."
        ),
        Exercise(
            language: .java,
            title: "Inmutabilidad de Strings",
            question: "¿Cuál es el valor impreso de la variable 's'?",
            codeSnippet: """
String s = "Java";
s.concat("11");
System.out.println(s);
""",
            options: ["\"Java11\"", "\"Java 11\"", "\"Java\"", "NullPointerException"],
            correctOptionIndex: 2,
            hint: "Los objetos String en Java son inmutables. Los métodos de modificación retornan una nueva cadena.",
            explanation: "El método 'concat' no modifica la cadena original 's' sino que devuelve un nuevo String. Como el retorno no se asigna de nuevo a 's', 's' se mantiene intacto como 'Java'."
        ),
        Exercise(
            language: .java,
            title: "Longitud de un Arreglo",
            question: "¿Cómo se obtiene el tamaño de un array en Java?",
            codeSnippet: """
int[] arr = {1, 2, 3};
System.out.println(arr.length);
""",
            options: ["arr.length()", "arr.size()", "arr.length", "arr.getSize()"],
            correctOptionIndex: 2,
            hint: "En arrays, el tamaño es una propiedad directa (length), no un método.",
            explanation: "En Java, los arreglos tienen una propiedad pública final llamada 'length' que contiene su capacidad. No se utilizan paréntesis como en los métodos de String."
        ),
        Exercise(
            language: .java,
            title: "Cortocircuito Lógico",
            question: "¿Qué valor final tiene la variable 'b'?",
            codeSnippet: """
boolean a = true;
boolean b = false;
System.out.println(a || (b = true));
System.out.println(b);
""",
            options: ["true", "false", "Error de compilación", "null"],
            correctOptionIndex: 1,
            hint: "El operador OR lógico '||' es de cortocircuito (short-circuit). Si el primer operando es verdadero, no evalúa el segundo.",
            explanation: "Como 'a' es true, la expresión 'a || (b = true)' se evalúa como verdadera inmediatamente sin ejecutar el segundo operando '(b = true)'. Por lo tanto, 'b' sigue siendo 'false'."
        ),
        Exercise(
            language: .java,
            title: "Operador de Asignación Compuesta",
            question: "¿Cuál es el valor de x tras la operación?",
            codeSnippet: """
int x = 10;
x += 5 * 2;
""",
            options: ["30", "20", "25", "Error de sintaxis"],
            correctOptionIndex: 1,
            hint: "Los operadores aritméticos como la multiplicación tienen mayor prioridad que los operadores de asignación.",
            explanation: "Primero se ejecuta la multiplicación '5 * 2' resultando en 10. Luego se ejecuta el operador compuesto 'x += 10', sumándole 10 al valor inicial (10), dando un total de 20."
        ),
        Exercise(
            language: .java,
            title: "Comparación de Objetos",
            question: "¿Qué imprime la comparación de estos dos strings?",
            codeSnippet: """
String a = "hello";
String b = new String("hello");
System.out.println(a == b);
""",
            options: ["true", "false", "compile error", "null"],
            correctOptionIndex: 1,
            hint: "El operador '==' compara las referencias en memoria de los objetos, no sus contenidos.",
            explanation: "'a' apunta a la cadena literal en la piscina de strings (string pool), mientras que 'new String(...)' fuerza la creación de un nuevo objeto en el montón (heap). Al tener direcciones distintas en memoria, '==' retorna false. Para comparar contenido se debe usar '.equals()'."
        ),
        Exercise(
            language: .java,
            title: "Bucle for simple",
            question: "¿Cuál es el valor final de la variable x?",
            codeSnippet: """
int x = 0;
for(int i = 0; i < 3; i++) {
    x += i;
}
""",
            options: ["3", "6", "0", "2"],
            correctOptionIndex: 0,
            hint: "El bucle se ejecuta con i = 0, i = 1 e i = 2.",
            explanation: "Las iteraciones del ciclo acumulan en 'x': primera iteración i=0 (x=0), segunda iteración i=1 (x=0+1=1), tercera iteración i=2 (x=1+2=3). Luego i se incrementa a 3, el ciclo se rompe y x queda en 3."
        ),
        Exercise(
            language: .java,
            title: "Post-incremento",
            question: "¿Qué imprime la siguiente instrucción?",
            codeSnippet: """
int x = 5;
System.out.println(x++);
""",
            options: ["5", "6", "0", "Error de compilación"],
            correctOptionIndex: 0,
            hint: "El operador post-incremento (x++) evalúa la expresión con el valor original y luego incrementa la variable.",
            explanation: "Al usar post-incremento 'x++', se pasa el valor actual de x (5) a la función println para que sea impreso, y posteriormente se incrementa x a 6. Por tanto, imprime 5."
        )
    ]
    
    static func randomExercise(for language: ProgrammingLanguage) -> Exercise {
        let filtered = allExercises.filter { $0.language == language }
        return filtered.randomElement() ?? allExercises[0]
    }
}
