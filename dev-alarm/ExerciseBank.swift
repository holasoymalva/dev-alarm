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
            titleEn: "Array Reference",
            titleEs: "Referencia de Arrays",
            questionEn: "What is the value printed to the console after executing this code?",
            questionEs: "¿Cuál es el valor impreso en la consola al ejecutar este código?",
            codeSnippet: """
let a = [1, 2];
let b = a;
b.push(3);
console.log(a.length);
""",
            optionsEn: ["2", "3", "undefined", "Compilation Error"],
            optionsEs: ["2", "3", "undefined", "Error de compilación"],
            correctOptionIndex: 1,
            hintEn: "In JavaScript, objects and arrays are assigned by reference, not by value.",
            hintEs: "En JavaScript, los objetos y arrays se asignan por referencia, no por copia.",
            explanationEn: "When doing 'let b = a', both variables point to the same array in memory. Modifying 'b' by pushing a value also modifies 'a', making the length of 'a' equal to 3.",
            explanationEs: "Al hacer 'let b = a', ambas variables apuntan al mismo array en memoria. Modificar 'b' agregando un elemento también modifica 'a', por lo que el largo de 'a' pasa a ser 3."
        ),
        Exercise(
            language: .javascript,
            titleEn: "Type Coercion (Addition)",
            titleEs: "Coerción de Tipos (Suma)",
            questionEn: "What is the result of the following expression?",
            questionEs: "¿Cuál es el resultado de la siguiente expresión?",
            codeSnippet: """
let result = "5" + 3;
console.log(result);
""",
            optionsEn: ["8", "53", "NaN", "TypeError"],
            optionsEs: ["8", "53", "NaN", "TypeError"],
            correctOptionIndex: 1,
            hintEn: "The '+' operator acts as string concatenation if at least one operand is a string.",
            hintEs: "El operador '+' se sobrecarga para concatenación cuando hay un string involucrado.",
            explanationEn: "Because one of the operands of '+' is a string, JavaScript implicitly converts the number 3 to a string and concatenates them, resulting in '53'.",
            explanationEs: "Cuando uno de los operandos del operador '+' es un string, JavaScript convierte el otro operando (el número 3) en string y los concatena, dando como resultado '53'."
        ),
        Exercise(
            language: .javascript,
            titleEn: "Type Coercion (Subtraction)",
            titleEs: "Coerción de Tipos (Resta)",
            questionEn: "What is the result of the following expression?",
            questionEs: "¿Cuál es el resultado de la siguiente expresión?",
            codeSnippet: """
let result = "5" - 3;
console.log(result);
""",
            optionsEn: ["2", "NaN", "TypeError", "53"],
            optionsEs: ["2", "NaN", "TypeError", "53"],
            correctOptionIndex: 0,
            hintEn: "Unlike '+', the '-' operator does not support string concatenation, so it forces numeric conversion.",
            hintEs: "A diferencia de '+', el operador '-' no tiene significado para strings, por lo que JavaScript intenta convertir todo a números.",
            explanationEn: "The subtraction operator '-' triggers implicit numeric coercion. The string '5' is cast to number 5, and 3 is subtracted, resulting in 2.",
            explanationEs: "El operador '-' realiza coerción numérica implícita. El string '5' se convierte al número 5 y se le resta 3, dando como resultado el número 2."
        ),
        Exercise(
            language: .javascript,
            titleEn: "typeof null",
            titleEs: "Tipo de dato Null",
            questionEn: "What does this expression return?",
            questionEs: "¿Qué retorna la siguiente expresión?",
            codeSnippet: """
console.log(typeof null);
""",
            optionsEn: ["'null'", "'undefined'", "'object'", "'string'"],
            optionsEs: ["'null'", "'undefined'", "'object'", "'string'"],
            correctOptionIndex: 2,
            hintEn: "This is a historic bug in JavaScript's design that has been preserved for backward compatibility.",
            hintEs: "Es un error histórico conocido en el diseño de JavaScript que se ha mantenido por compatibilidad.",
            explanationEn: "In the first implementation of JavaScript, values were stored in binary tags. The null value was represented by the zero pointer, which shared a prefix with objects. Hence, it returns 'object'.",
            explanationEs: "En la primera implementación de JavaScript, los valores se representaban en tipos binarios. El valor null se representaba con el puntero cero, que compartía prefijo con los objetos. Por eso retorna 'object'."
        ),
        Exercise(
            language: .javascript,
            titleEn: "Default Parameters",
            titleEs: "Parámetros por Defecto",
            questionEn: "What is the result of calling the function f(3)?",
            questionEs: "¿Cuál es el resultado de llamar a la función f(3)?",
            codeSnippet: """
const f = (x, y = 2) => x * y;
console.log(f(3));
""",
            optionsEn: ["NaN", "3", "6", "TypeError"],
            optionsEs: ["NaN", "3", "6", "TypeError"],
            correctOptionIndex: 2,
            hintEn: "If you don't provide the second parameter, the default value assigned in the declaration is used.",
            hintEs: "Si no proporcionas el segundo parámetro, se usará el valor por defecto asignado en la declaración.",
            explanationEn: "The function defines 'y' with a default value of 2. Calling 'f(3)' maps 'x' to 3 and 'y' to the default value 2. The result of 3 * 2 is 6.",
            explanationEs: "La función define 'y' con un valor por defecto de 2. Al llamar 'f(3)', 'x' toma el valor 3 e 'y' toma el valor por defecto 2. El resultado de 3 * 2 es 6."
        ),
        Exercise(
            language: .javascript,
            titleEn: "Operator Precedence",
            titleEs: "Precedencia de Operadores",
            questionEn: "What is the result printed by this code?",
            questionEs: "¿Cuál es el resultado impreso por este código?",
            codeSnippet: """
let x = true;
let y = false;
console.log(x || y && false);
""",
            optionsEn: ["true", "false", "undefined", "TypeError"],
            optionsEs: ["true", "false", "undefined", "TypeError"],
            correctOptionIndex: 0,
            hintEn: "The AND operator (&&) has higher precedence than the OR operator (||) and is evaluated first.",
            hintEs: "El operador AND (&&) tiene mayor precedencia que el operador OR (||) y se evalúa primero.",
            explanationEn: "Due to operator precedence, 'y && false' is evaluated first, resulting in 'false'. Then, 'x || false' is evaluated, which is 'true || false', resulting in 'true'.",
            explanationEs: "Por precedencia de operadores, 'y && false' se evalúa primero dando 'false'. Luego se evalúa 'x || false' que equivale a 'true || false', lo cual es 'true'."
        ),
        Exercise(
            language: .javascript,
            titleEn: "Map and Filter",
            titleEs: "Map y Filter",
            questionEn: "What is the final value of the constant 'res'?",
            questionEs: "¿Cuál es el valor final de la constante 'res'?",
            codeSnippet: """
const arr = [1, 2, 3];
const res = arr.map(x => x * 2).filter(x => x > 3);
console.log(res);
""",
            optionsEn: ["[2, 4, 6]", "[4, 6]", "[6]", "[1, 2, 3]"],
            optionsEs: ["[2, 4, 6]", "[4, 6]", "[6]", "[1, 2, 3]"],
            correctOptionIndex: 1,
            hintEn: "First apply the multiplication to all elements, then filter for values greater than 3.",
            hintEs: "Primero aplicas la multiplicación a todos los elementos, luego filtras los que son mayores a 3.",
            explanationEn: "'arr.map(x => x * 2)' produces [2, 4, 6]. Next, '.filter(x => x > 3)' keeps only elements greater than 3, resulting in [4, 6].",
            explanationEs: "'arr.map(x => x * 2)' produce [2, 4, 6]. Luego, '.filter(x => x > 3)' mantiene solo los elementos mayores a 3, es decir, [4, 6]."
        ),
        Exercise(
            language: .javascript,
            titleEn: "Object Properties",
            titleEs: "Propiedades Inexistentes",
            questionEn: "What is printed to the console after deleting the property?",
            questionEs: "¿Qué se imprime en la consola tras borrar la propiedad?",
            codeSnippet: """
const o = { x: 1 };
delete o.x;
console.log(o.x);
""",
            optionsEn: ["null", "undefined", "1", "ReferenceError"],
            optionsEs: ["null", "undefined", "1", "ReferenceError"],
            correctOptionIndex: 1,
            hintEn: "Accessing a non-existent property on a JavaScript object returns a special value instead of throwing an error.",
            hintEs: "Acceder a una propiedad que no existe en un objeto en JS no arroja un error, sino un valor especial.",
            explanationEn: "Using 'delete o.x' completely removes the property 'x' from the object. Accessing any non-existent property in JS returns 'undefined'.",
            explanationEs: "Al usar 'delete o.x', la propiedad 'x' se elimina completamente del objeto. Acceder a cualquier propiedad inexistente en JS devuelve 'undefined'."
        ),
        
        // MARK: - PYTHON EXERCISES
        Exercise(
            language: .python,
            titleEn: "Negative Indexing",
            titleEs: "Indexación Negativa",
            questionEn: "What does the following code print?",
            questionEs: "¿Qué imprime el siguiente código?",
            codeSnippet: """
x = [1, 2, 3]
print(x[-1])
""",
            optionsEn: ["1", "3", "IndexError", "None"],
            optionsEs: ["1", "3", "IndexError", "None"],
            correctOptionIndex: 1,
            hintEn: "In Python, negative indexes start counting backwards from the end of the collection.",
            hintEs: "En Python, los índices negativos empiezan a contar desde el final de la colección.",
            explanationEn: "The index -1 refers to the very last element of the list, which in this case is the number 3.",
            explanationEs: "El índice -1 hace referencia al último elemento de la lista, que en este caso es el número 3."
        ),
        Exercise(
            language: .python,
            titleEn: "String Slicing",
            titleEs: "Slicing de Strings",
            questionEn: "What is the output of this string slice?",
            questionEs: "¿Cuál es el resultado de este recorte de texto (slice)?",
            codeSnippet: """
x = "Python"
print(x[1:4])
""",
            optionsEn: ["\"Pyt\"", "\"yth\"", "\"ytho\"", "\"yt\""],
            optionsEs: ["\"Pyt\"", "\"yth\"", "\"ytho\"", "\"yt\""],
            correctOptionIndex: 1,
            hintEn: "Python slicing is inclusive of the start index and exclusive of the end index: [start:end].",
            hintEs: "El slicing en Python es inclusivo en el inicio y exclusivo en el fin: [inicio:fin].",
            explanationEn: "The slice x[1:4] extracts characters from index 1 up to (but not including) index 4. In 'Python', index 1 is 'y', 2 is 't', and 3 is 'h', yielding 'yth'.",
            explanationEs: "El recorte x[1:4] toma los caracteres en las posiciones 1, 2 y 3. En 'Python', el índice 1 es 'y', el 2 es 't' y el 3 es 'h'. El resultado es 'yth'."
        ),
        Exercise(
            language: .python,
            titleEn: "Dictionary get Method",
            titleEs: "Método get en Diccionarios",
            questionEn: "What value is printed on the screen?",
            questionEs: "¿Qué valor se imprime en pantalla?",
            codeSnippet: """
d = {"a": 1}
print(d.get("b", 2))
""",
            optionsEn: ["1", "None", "2", "KeyError"],
            optionsEs: ["1", "None", "2", "KeyError"],
            correctOptionIndex: 2,
            hintEn: "The get method looks up a key, and if it doesn't exist, returns the default value passed as the second argument.",
            hintEs: "El método get busca una llave y, si no existe, devuelve el valor por defecto proporcionado como segundo argumento.",
            explanationEn: "The key 'b' does not exist in the dictionary 'd'. Instead of throwing a KeyError, the '.get()' method returns the default value specified: 2.",
            explanationEs: "La llave 'b' no existe en el diccionario 'd'. El método '.get()' en lugar de lanzar un KeyError, retorna el valor por defecto especificado: 2."
        ),
        Exercise(
            language: .python,
            titleEn: "List Comprehension",
            titleEs: "Comprensión de Listas",
            questionEn: "What is the final value of list 'x'?",
            questionEs: "¿Cuál es el valor final de la lista 'x'?",
            codeSnippet: """
x = [i for i in range(5) if i % 2 == 0]
print(x)
""",
            optionsEn: ["[0, 2, 4]", "[2, 4]", "[0, 1, 2, 3, 4]", "[1, 3]"],
            optionsEs: ["[0, 2, 4]", "[2, 4]", "[0, 1, 2, 3, 4]", "[1, 3]"],
            correctOptionIndex: 0,
            hintEn: "range(5) generates numbers from 0 to 4. We evaluate the modulo condition for even numbers.",
            hintEs: "range(5) genera números del 0 al 4. Evaluamos la condición de número par.",
            explanationEn: "range(5) yields 0, 1, 2, 3, 4. The condition 'i % 2 == 0' filters only even numbers. Thus, the resulting list is [0, 2, 4].",
            explanationEs: "range(5) produce 0, 1, 2, 3, 4. La condición 'i % 2 == 0' filtra solo los números pares. Así, la lista resultante es [0, 2, 4]."
        ),
        Exercise(
            language: .python,
            titleEn: "Floor Division",
            titleEs: "División Entera",
            questionEn: "What value is stored in the variable x?",
            questionEs: "¿Qué valor se guarda en la variable x?",
            codeSnippet: """
x = 5 // 2
print(x)
""",
            optionsEn: ["2.5", "2", "3", "2.0"],
            optionsEs: ["2.5", "2", "3", "2.0"],
            correctOptionIndex: 1,
            hintEn: "The '//' operator performs floor division (rounding down to the nearest integer).",
            hintEs: "El operador '//' realiza una división de piso (floor division).",
            explanationEn: "The '//' operator divides and rounds down to the nearest integer. 5 divided by 2 is 2.5, which rounds down to 2.",
            explanationEs: "El operador '//' divide los números y redondea hacia abajo al entero más cercano. 5 dividido por 2 es 2.5, redondeado hacia abajo es 2."
        ),
        Exercise(
            language: .python,
            titleEn: "List References",
            titleEs: "Referencias en Listas",
            questionEn: "What is the final length of list 'a'?",
            questionEs: "¿Cuál es el largo de la lista 'a' al final?",
            codeSnippet: """
a = [1, 2]
b = a
b.append(3)
print(len(a))
""",
            optionsEn: ["2", "3", "4", "AttributeError"],
            optionsEs: ["2", "3", "4", "AttributeError"],
            correctOptionIndex: 1,
            hintEn: "In Python, assigning a list to another variable copies the reference to the object, not the values.",
            hintEs: "En Python, al asignar una lista a otra variable se copia la referencia al objeto.",
            explanationEn: "'b' points to the exact same list as 'a'. Therefore, calling 'b.append(3)' updates the underlying list, changing the length of 'a' to 3.",
            explanationEs: "'b' apunta a la misma lista que 'a'. Por lo tanto, usar 'b.append(3)' altera la lista subyacente y modifica el largo de 'a' a 3."
        ),
        Exercise(
            language: .python,
            titleEn: "String Multiplication",
            titleEs: "Multiplicación de Strings",
            questionEn: "What does this operation output in Python?",
            questionEs: "¿Qué imprime esta operación en Python?",
            codeSnippet: """
print("py" * 3)
""",
            optionsEn: ["\"py3\"", "\"pypypy\"", "\"py py py\"", "TypeError"],
            optionsEs: ["\"py3\"", "\"pypypy\"", "\"py py py\"", "TypeError"],
            correctOptionIndex: 1,
            hintEn: "In Python, multiplying a string by an integer repeats the string that many times.",
            hintEs: "En Python, multiplicar un string por un entero repite el string ese número de veces.",
            explanationEn: "The '*' operator applied between a string and an integer performs repetition. 'py' repeated 3 times results in 'pypypy'.",
            explanationEs: "El operador '*' cuando se aplica a un string y un entero realiza repetición. 'py' repetido 3 veces resulta en 'pypypy'."
        ),
        Exercise(
            language: .python,
            titleEn: "Tuple Immutability",
            titleEs: "Inmutabilidad de Tuplas",
            questionEn: "What happens when trying to run this assignment?",
            questionEs: "¿Qué sucede al intentar ejecutar esta asignación?",
            codeSnippet: """
x = (1, 2)
x[0] = 3
""",
            optionsEn: ["x becomes (3, 2)", "TypeError", "SyntaxError", "None"],
            optionsEs: ["x pasa a ser (3, 2)", "TypeError", "SyntaxError", "None"],
            correctOptionIndex: 1,
            hintEn: "Tuples are ordered and immutable sequences in Python, unlike lists.",
            hintEs: "Las tuplas son colecciones ordenadas e inmutables, a diferencia de las listas.",
            explanationEn: "Tuples in Python are immutable. Once created, you cannot modify or reassign their items. Trying to do so raises a 'TypeError'.",
            explanationEs: "Las tuplas en Python son inmutables. Una vez creadas, no puedes reasignar o modificar sus elementos. Intentar hacerlo lanza un 'TypeError'."
        ),
        
        // MARK: - JAVA EXERCISES
        Exercise(
            language: .java,
            titleEn: "Integer Division",
            titleEs: "División de Enteros",
            questionEn: "What does this Java code snippet print?",
            questionEs: "¿Qué imprime este fragmento de código Java?",
            codeSnippet: """
int x = 5;
int y = 2;
double z = x / y;
System.out.println(z);
""",
            optionsEn: ["2.5", "2.0", "2", "Compilation Error"],
            optionsEs: ["2.5", "2.0", "2", "Error de compilación"],
            correctOptionIndex: 1,
            hintEn: "Division between two integers in Java evaluates to an integer before being converted to double.",
            hintEs: "La división de dos enteros en Java resulta en un entero antes de ser asignado a un tipo double.",
            explanationEn: "Since 'x' and 'y' are both integers, 'x / y' executes integer division yielding 2. Then, that 2 is implicitly cast to double to fit into 'z', resulting in 2.0.",
            explanationEs: "Dado que 'x' e 'y' son enteros, 'x / y' hace una división entera dando como resultado 2. Luego, ese 2 se convierte implícitamente a double para guardarse en 'z', resultando en 2.0."
        ),
        Exercise(
            language: .java,
            titleEn: "String Immutability",
            titleEs: "Inmutabilidad de Strings",
            questionEn: "What is the printed value of the variable 's'?",
            questionEs: "¿Cuál es el valor impreso de la variable 's'?",
            codeSnippet: """
String s = "Java";
s.concat("11");
System.out.println(s);
""",
            optionsEn: ["\"Java11\"", "\"Java 11\"", "\"Java\"", "NullPointerException"],
            optionsEs: ["\"Java11\"", "\"Java 11\"", "\"Java\"", "NullPointerException"],
            correctOptionIndex: 2,
            hintEn: "String objects are immutable in Java. Modifying methods return a new string instance.",
            hintEs: "Los objetos String en Java son inmutables. Los métodos de modificación retornan una nueva cadena.",
            explanationEn: "The 'concat' method does not modify the original string 's'; it returns a new string. Since the return is not reassigned back to 's', 's' remains 'Java'.",
            explanationEs: "El método 'concat' no modifica la cadena original 's' sino que devuelve un nuevo String. Como el retorno no se asigna de nuevo a 's', 's' se mantiene intacto como 'Java'."
        ),
        Exercise(
            language: .java,
            titleEn: "Array Length",
            titleEs: "Longitud de un Arreglo",
            questionEn: "How do you fetch the size of an array in Java?",
            questionEs: "¿Cómo se obtiene el tamaño de un array en Java?",
            codeSnippet: """
int[] arr = {1, 2, 3};
System.out.println(arr.length);
""",
            optionsEn: ["arr.length()", "arr.size()", "arr.length", "arr.getSize()"],
            optionsEs: ["arr.length()", "arr.size()", "arr.length", "arr.getSize()"],
            correctOptionIndex: 2,
            hintEn: "In Java arrays, size is fetched via a final property (length), not a method call.",
            hintEs: "En arrays, el tamaño es una propiedad directa (length), no un método.",
            explanationEn: "In Java, arrays have a public final property called 'length' that holds their capacity. Parentheses are not used unlike String length calls.",
            explanationEs: "En Java, los arreglos tienen una propiedad pública final llamada 'length' que contiene su capacidad. No se utilizan paréntesis como en los métodos de String."
        ),
        Exercise(
            language: .java,
            titleEn: "Logical Short-Circuit",
            titleEs: "Cortocircuito Lógico",
            questionEn: "What is the final value of the variable 'b'?",
            questionEs: "¿Qué valor final tiene la variable 'b'?",
            codeSnippet: """
boolean a = true;
boolean b = false;
System.out.println(a || (b = true));
System.out.println(b);
""",
            optionsEn: ["true", "false", "Compilation Error", "null"],
            optionsEs: ["true", "false", "Error de compilación", "null"],
            correctOptionIndex: 1,
            hintEn: "The logical OR '||' operator short-circuits. If the first operand is true, it does not evaluate the second one.",
            hintEs: "El operador OR lógico '||' es de cortocircuito (short-circuit). Si el primer operando es verdadero, no evalúa el segundo.",
            explanationEn: "Because 'a' is true, the expression 'a || (b = true)' evaluates to true immediately without executing the second part '(b = true)'. Thus, 'b' remains 'false'.",
            explanationEs: "Como 'a' es true, la expresión 'a || (b = true)' se evalúa como verdadera inmediatamente sin ejecutar el segundo operando '(b = true)'. Por lo tanto, 'b' sigue siendo 'false'."
        ),
        Exercise(
            language: .java,
            titleEn: "Compound Assignment",
            titleEs: "Operador de Asignación Compuesta",
            questionEn: "What is the value of x after the operation?",
            questionEs: "¿Cuál es el valor de x tras la operación?",
            codeSnippet: """
int x = 10;
x += 5 * 2;
""",
            optionsEn: ["30", "20", "25", "Syntax Error"],
            optionsEs: ["30", "20", "25", "Error de sintaxis"],
            correctOptionIndex: 1,
            hintEn: "Arithmetic operators like multiplication have higher priority than assignment operators.",
            hintEs: "Los operadores aritméticos como la multiplicación tienen mayor prioridad que los operadores de asignación.",
            explanationEn: "First, the multiplication '5 * 2' is executed, resulting in 10. Then, the compound operator 'x += 10' adds 10 to the initial value (10), totaling 20.",
            explanationEs: "Primero se ejecuta la multiplicación '5 * 2' resultando en 10. Luego se ejecuta el operador compuesto 'x += 10', sumándole 10 al valor inicial (10), dando un total de 20."
        ),
        Exercise(
            language: .java,
            titleEn: "Object Comparison",
            titleEs: "Comparación de Objetos",
            questionEn: "What does the comparison between these two strings print?",
            questionEs: "¿Qué imprime la comparación de estos dos strings?",
            codeSnippet: """
String a = "hello";
String b = new String("hello");
System.out.println(a == b);
""",
            optionsEn: ["true", "false", "compile error", "null"],
            optionsEs: ["true", "false", "compile error", "null"],
            correctOptionIndex: 1,
            hintEn: "The '==' operator compares object references in memory, not their content.",
            hintEs: "El operador '==' compara las referencias en memoria de los objetos, no sus contenidos.",
            explanationEn: "'a' points to the literal string in the String Pool, while 'new String(...)' forces a new object on the heap. Having different addresses, '==' returns false. Use '.equals()' for content comparison.",
            explanationEs: "'a' apunta a la cadena literal en la piscina de strings (string pool), mientras que 'new String(...)' fuerza la creación de un nuevo objeto en el montón (heap). Al tener direcciones distintas en memoria, '==' retorna false. Para comparar contenido se debe usar '.equals()'."
        ),
        Exercise(
            language: .java,
            titleEn: "Simple for loop",
            titleEs: "Bucle for simple",
            questionEn: "What is the final value of the variable x?",
            questionEs: "¿Cuál es el valor final de la variable x?",
            codeSnippet: """
int x = 0;
for(int i = 0; i < 3; i++) {
    x += i;
}
""",
            optionsEn: ["3", "6", "0", "2"],
            optionsEs: ["3", "6", "0", "2"],
            correctOptionIndex: 0,
            hintEn: "The loop executes with i = 0, i = 1, and i = 2.",
            hintEs: "El bucle se ejecuta con i = 0, i = 1 e i = 2.",
            explanationEn: "The loop iterations accumulate in x: first i=0 (x=0), second i=1 (x=1), third i=2 (x=3). Then i becomes 3, the loop breaks, and x remains 3.",
            explanationEs: "Las iteraciones del ciclo acumulan en 'x': primera iteración i=0 (x=0), segunda iteración i=1 (x=0+1=1), tercera iteración i=2 (x=1+2=3). Luego i se incrementa a 3, el ciclo se rompe y x queda en 3."
        ),
        Exercise(
            language: .java,
            titleEn: "Post-Increment",
            titleEs: "Post-incremento",
            questionEn: "What does the following statement print?",
            questionEs: "¿Qué imprime la siguiente instrucción?",
            codeSnippet: """
int x = 5;
System.out.println(x++);
""",
            optionsEn: ["5", "6", "0", "Compilation Error"],
            optionsEs: ["5", "6", "0", "Error de compilación"],
            correctOptionIndex: 0,
            hintEn: "The post-increment operator (x++) evaluates the expression using the original value first, and then increments.",
            hintEs: "El operador post-incremento (x++) evalúa la expresión con el valor original y luego incrementa la variable.",
            explanationEn: "Using the post-increment 'x++', the current value of x (5) is passed to the println method, and afterward x is incremented to 6. Thus, 5 is printed.",
            explanationEs: "Al usar post-incremento 'x++', se pasa el valor actual de x (5) a la función println para que sea impreso, y posteriormente se incrementa x a 6. Por tanto, imprime 5."
        )
    ]
    
    static func randomExercise(for language: ProgrammingLanguage) -> Exercise {
        let filtered = allExercises.filter { $0.language == language }
        return filtered.randomElement() ?? allExercises[0]
    }
}
