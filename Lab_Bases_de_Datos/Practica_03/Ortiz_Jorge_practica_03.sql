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
SELECT *
FROM libro;

-- Procedimiento 03
CREATE OR REPLACE PROCEDURE INCREMENTAR
IS

BEGIN
	UPDATE libro
	SET libro.precio = libro.precio * 0.9
	WHERE libro.precio <= 30000 AND libro.precio >= 20000;
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( SQLERRM );
END;
/

EXECUTE INCREMENTAR();

SELECT *
FROM libro;

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

-- Procedimiento 05

CREATE OR REPLACE PROCEDURE INSERTAR_LIBRO(
	prm_titulo libro.titulo%TYPE,
	prm_autor libro.autor%TYPE,
	prm_editorial libro.editorial%TYPE,
	prm_precio libro.precio%TYPE
)
IS
	v_cont INTEGER := 0;
	nuevo_codigo libro.codigo%TYPE;
	r_libro libro%rowtype;
	v_cont2 INTEGER := 0;
BEGIN
	SELECT MAX(codigo)
	INTO nuevo_codigo
	FROM libro;
	-- DBMS_OUTPUT.PUT_LINE(nuevo_codigo);
	nuevo_codigo := nuevo_codigo + 1;
	
	SELECT COUNT(*)
	INTO v_cont
	FROM libro
	WHERE (titulo LIKE ( prm_titulo)) AND (autor LIKE(prm_autor)) AND (editorial LIKE(prm_editorial));
	
	SELECT COUNT(*)
	INTO v_cont2
	FROM libro
	WHERE codigo = nuevo_codigo;
	IF v_cont = 0 THEN
		
		IF v_cont2 = 0 THEN
			-- DBMS_OUTPUT.PUT_LINE(nuevo_codigo);
			INSERT INTO libro(codigo, titulo, autor, editorial, precio) VALUES(nuevo_codigo, prm_titulo, prm_autor, prm_editorial, prm_precio);
		ELSE
			DBMS_OUTPUT.PUT_LINE('Error, código duplicado. No fue posible agregar el libro, intente ingresar nuevamente el libro con un nuevo codigo');
		END IF;
	ELSE
		DBMS_OUTPUT.PUT_LINE('Error, el libro ya está registrado');
	END IF;
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( SQLERRM );

END;
/

EXECUTE INSERTAR_LIBRO('Odio, amistad, noviazgo, matrimonio', 'Alice Munro', 'RBA Libros', 50000);

select *
from libro;

-- Intentamos añadir el mismo libro, solo que cambiando algunas minúsculas por mayúsculas y viceversa
-- No debería dejarlo ingresar
EXECUTE INSERTAR_LIBRO('Odio, Amistad, Noviazgo, Matrimonio', 'Alice Munro', 'rba Libros', 50000);

SELECT *
from libro;

