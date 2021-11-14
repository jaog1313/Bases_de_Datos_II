DROP TABLE libro;
/
CREATE TABLE libro(
	codigo number NOT NULL,
	titulo varchar2(100) NOT NULL,
	autor varchar2(50) NOT NULL,
	editorial varchar2(50),
	precio number,
	constraint pk_libro primary key(codigo)
	);
INSERT INTO libro VALUES (10, 'El Señor de los Anillos: La comunidad del anillo', 'J.R.R. Tolkien', 'Planeta', 40000);
INSERT INTO libro VALUES (20, 'Harry Potter y el prisionero de Azkaban', 'J.K. Rowling', 'Salamandra', 30000);
INSERT INTO libro VALUES (30, 'El principito', 'Antoine de Saint Exupéry', 'Panamericana', 20000);
INSERT INTO libro VALUES (40, 'Tom Sawyer', 'Mark Twain', 'Nuevo siglo', 15000);
INSERT INTO libro VALUES (50, 'Dracula', 'Bram Stoker', 'Austral', 25000);
INSERT INTO libro VALUES (60, 'Inteligencia Artificial', 'Russel', 'Pearson', 90000);
INSERT INTO libro VALUES (70, 'Cien años de Soledad', 'Gabriel García Márquez', 'Planeta', 24000);
INSERT INTO libro VALUES (80, 'Java en 10 minutos', 'Mario Molina', 'Siglo XXI', 45000);
INSERT INTO libro VALUES (90, 'Romeo y Julieta', 'William Shakespeare', 'Panamericana', 34000);
INSERT INTO libro VALUES (11, 'La metamorfosis', 'Frankz Kafka', 'Panamericana', 35000);


-- Procedimiento 01
-- Se imprimen todos los datos de un libro 
CREATE OR REPLACE PROCEDURE IMPRIMIR_LIBRO(
    prm_cod_libro NUMBER
)
IS
	r_libro libro%ROWTYPE;
BEGIN
	--Obtener el libro de acuerdo con codigo proporcionado
	SELECT *
	INTO r_libro
	FROM libro
	where libro.codigo = prm_cod_libro;
	
	-- Imprimir toda la info del libro
	DBMS_OUTPUT.PUT_LINE('Código : ' || r_libro.codigo);
	DBMS_OUTPUT.PUT_LINE('Titulo : ' || r_libro.titulo);
	DBMS_OUTPUT.PUT_LINE('Autor : ' || r_libro.autor);
	DBMS_OUTPUT.PUT_LINE('Editorial : ' || r_libro.editorial);
	DBMS_OUTPUT.PUT_LINE('Precio : ' || r_libro.precio);

EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('No exite este libro con el código : ' || prm_cod_libro);
END;
/
-- Ejemplos de llamado al procedimiento IMPRIMIR_LIBRO
-- Primero buscamos un libro con código aceptable
EXECUTE IMPRIMIR_LIBRO(20);

-- Buscamos un código que no existe
EXECUTE IMPRIMIR_LIBRO(21);



-- Procedimiento 02
CREATE OR REPLACE PROCEDURE aplicar_descuento(
	prm_editorial libro.editorial%TYPE,
	prm_descuento POSITIVE
)

IS
	mal_descuento EXCEPTION;
BEGIN
	--Obtener el libro de acuerdo con la editorial
	IF prm_descuento < 1 or prm_descuento > 100 THEN
		RAISE mal_descuento;
	ELSE
		UPDATE libro
		SET libro.precio = libro.precio * (1 - prm_descuento/100)
		WHERE libro.editorial = prm_editorial;
		
	END IF;
EXCEPTION
	WHEN mal_descuento THEN
		DBMS_OUTPUT.PUT_LINE('ERROR: El descuento debe ser un número entre 1 y 100');
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('La editorial no existe');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( SQLERRM );
END;
/
-- Ejecucion del procedimiento 02 con parámetros válidos
EXECUTE aplicar_descuento('Planeta', 10);

-- ejecución del procedimiento 02 con un parámetro inválido
EXECUTE aplicar_descuento('Fondo Económico de Cultura', 20);

-- ejecución del procedimiento 02 con el descuento inválido
EXECUTE aplicar_descuento('Planeta', -10);

-- ejecución del procedimiento 02 con el descuento inválido
EXECUTE aplicar_descuento('Planeta', 0);

-- ejecución del procedimiento 02 con el descuento inválido
EXECUTE aplicar_descuento('Planeta', 200);

-- Comprobando que el procedimiento 02 funciona. Modifico los precios de la editorial dada
-- 	y no modificó los demás.
select *
from libro;

-- Procedimiento 03
CREATE OR REPLACE PROCEDURE INCREMENTAR
IS

BEGIN
	UPDATE libro
	SET libro.precio = libro.precio * 0.9
	WHERE libro.precio <= 30000 and libro.precio >= 20000;
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( SQLERRM );
END;
/

EXECUTE INCREMENTAR();

select *
from libro;

-- Procedimiento 04
-- SET VERIFY OFF --Para evitar que el sistema nos muestre el valor que tenía la variable antes.
-- ACCEPT v_codigo libro.codigo%TYPE PROMPT 'Introduzca el codigo del libro '

DECLARE
	v_codigo libro.codigo%TYPE;
BEGIN
	
	UPDATE libro
		SET precio = case
			WHEN precio < 20000 THEN precio * 1.1
			WHEN precio > 30000 THEN precio * 1.01
			ELSE precio * 1.05
			END
		WHERE libro.codigo='&v_codigo';
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('El libro con el codigo ' || v_codigo || ' no existe.');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( SQLERRM );
END;
/
/*
for C2 in cursor_sal loop
	update emp
			set name = case
						 when something     then 'George'
						 when somethingelse then 'something2'
						 else 'somthing 3'
					   end
			where current of C2
end loop;
*/
