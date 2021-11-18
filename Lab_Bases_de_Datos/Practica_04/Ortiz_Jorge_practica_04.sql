/
-- Funcion 01
CREATE OR REPLACE FUNCTION get_deptid_by_name(
	p_dnombre departamentos.dnombre%TYPE
)
RETURN NUMBER
IS
	v_deptid := 0;
BEGIN
	SELECT dept.deptno
	INTO v_deptid
	FROM departamentos
	WHERE LOWER(departamentos.dnombre) = LOWER(p_dnombre);
	RETURN v_deptid;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('No se encontro el departamento con el nombre' || p_dnombre);
		RETURN -1;
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( SQLERRM );
		RETURN -1;
END;
/

DECLARE
	v_text = 
BEGIN

EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( SQLERRM );
END;
