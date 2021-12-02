end;
/
-- Solucion Parcial 01 por Jorge Ortiz

-- Punto 01
declare
 
	cursor c_titulos is
		select titulo, gennombre
		from pelicula
		inner join genero on genero = genid;
	r_titulos c_titulos%rowtype;
begin
	open c_titulos;
	DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('INICIO SALIDA DEL EJERCICIO 01');
	DBMS_OUTPUT.PUT_LINE('| titulo | genero |');
	LOOP
		fetch c_titulos into r_titulos;
		exit when c_titulos%notfound;
		
		DBMS_OUTPUT.PUT_LINE('| ' || r_titulos.titulo || ' | ' || r_titulos.gennombre);
	END LOOP;
	close c_titulos;
	DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('FIN SALIDA DEL EJERCICIO 01');
end;
/

create or replace procedure aumentoPrecio (
	p_pelid pelicula.pelid%type
)
is
	cursor c_pelicula is
		select titulo, precio, duracion
		from pelicula;
	r_pelicula c_pelicula%rowtype;
	v_cond varchar2(40);
	v_valor number;
begin
	update pelicula
		SET precio = case
			WHEN duracion > 120 THEN precio * 1.1
			ELSE precio * 1.05
			END
		WHERE pelid = p_pelid;
	open c_pelicula;
	DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('INICIO SALIDA DEL EJERCICIO 02');
	DBMS_OUTPUT.PUT_LINE('Titulo ' || ' | ' || 'Precio' || ' | ' || 'Duracion' || ' | ' || 'Valor' || ' | ' || 'Porcentaje');
	loop
		fetch c_pelicula into r_pelicula;
		exit when c_pelicula%notfound;
		if r_pelicula.duracion > 120 then
			v_cond := 'El precio sube 10%';
			v_valor := r_pelicula.precio * 0.1;
		else
			v_cond := 'El precio sube 5%';
			v_valor := r_pelicula.precio * 0.05;
		end if;
		DBMS_OUTPUT.PUT_LINE(r_pelicula.titulo || ' | ' || r_pelicula.precio || ' | ' || r_pelicula.duracion || ' | ' || v_valor || ' | ' || v_cond);
	end loop;
	DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------');
	close c_pelicula;
	DBMS_OUTPUT.PUT_LINE('FIN SALIDA DEL EJERCICIO 02');
exception
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('La pelicula con el id  ' || p_pelid || ' no existe.');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( SQLERRM );

end;
/

-- Ejecuciones
execute aumentoPrecio(1);
execute aumentoPrecio(3);
select * from pelicula
