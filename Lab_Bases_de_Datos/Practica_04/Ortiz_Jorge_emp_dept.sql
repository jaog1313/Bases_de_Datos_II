-- Crea la tabla DEPARTAMENTOS que será la tabla principal de la tabla empleado.
create table departamentos(   
	  deptid     number(2,0),   
	  dnombre      varchar2(14),   
	  ciudad        varchar2(13),   
	  constraint pk_departamento primary key ( deptid )   
);

-- Crea la tabla EMPLEADOS la cual tiene una llave foránea que referencia a la tabla DEPARTAMENTO.  La llave foránea requerirá que el deptid en la tabla empleado exista en la columna deptid en la tabla departamento.
create table empleados(   
	  empid     number(4,0),   
	  enombre    varchar2(10),   
	  cargo      varchar2(15),   
	  jefe      number(4,0),   
	  fechaingreso date,
	  salario      number(7,2),   
	  comision     number(7,2),   
	  deptid   number(2,0),   
	  constraint pk_empleado primary key (empid ),   
	  constraint fk_deptid foreign key (deptid) references departamentos (deptid)   
);

insert into departamentos (deptid, dnombre, ciudad) 
values(10, 'CONTABILIDAD', 'BOGOTA'); 
 
-- Inserta una fila en la tabla departamento por la posición de la columna 
insert into departamentos   
values(20, 'INVESTIGACION', 'CALI'); 
 
insert into departamentos   
values(30, 'VENTAS', 'CARTAGENA'); 
 
insert into departamentos   
values(40, 'TECNOLOGIA', 'POPAYAN'); 
 
-- Inserta una fila en la tabla empleado usando la función TO_DATE para convertir cadenas literales en un formato de FECHA Oracle 
insert into empleados   
values(   
	 7839, 'MIGUEL', 'PRESIDENTE', null,   
	 to_date('17-11-1981','dd-mm-yyyy'),   
	 5000, null, 10   
); 
 
insert into empleados   
values(   
	 7698, 'JUAN', 'GERENTE', 7839,   
	 to_date('1-5-1981','dd-mm-yyyy'),   
	 2850, null, 30   
);

insert into empleados   
values(   
	 7566, 'JULIA', 'GERENTE', 7839,   
	 to_date('2-4-1981','dd-mm-yyyy'),   
	 2975, null, 20   
); 
 
insert into empleados   
values(   
	 7788, 'SOFIA', 'ANALISTA', 7566,   
	 to_date('13-JUL-87','dd-mm-rr') - 85,   
	 3000, null, 20   
); 
 
insert into empleados   
values(   
	 7902, 'FREDY', 'ANALISTA', 7566,   
	 to_date('3-12-1981','dd-mm-yyyy'),   
	 3000, null, 20   
); 
 
insert into empleados   
values(   
	 7369, 'SANTIAGO', 'EMPLEADO', 7902,   
	 to_date('17-12-1980','dd-mm-yyyy'),   
	 800, null, 20   
); 
 
insert into empleados  
values(   
	 7499, 'ANA', 'VENDEDOR', 7698,   
	 to_date('20-2-1981','dd-mm-yyyy'),   
	 1600, 300, 30   
); 
 
insert into empleados   
values(   
	 7521, 'WILSON', 'VENDEDOR', 7698,   
	 to_date('22-2-1981','dd-mm-yyyy'),   
	 1250, 500, 30   
); 
 
insert into empleados   
values(   
	 7654, 'MARTIN', 'VENDEDOR', 7698,   
	 to_date('28-9-1981','dd-mm-yyyy'),   
	 1250, 1400, 30   
); 
 
insert into empleados   
values(   
	 7844, 'TOMAS', 'VENDEDOR', 7698,   
	 to_date('8-9-1981','dd-mm-yyyy'),   
	 1500, 0, 30   
); 
 
insert into empleados   
values(   
	 7876, 'ADOLFO', 'EMPLEADO', 7788,   
	 to_date('13-JUL-87', 'dd-mm-rr') - 51,   
	 1100, null, 20   
); 
 
insert into empleados   
values(   
	 7900, 'JULIO', 'EMPLEADO', 7698,   
	 to_date('3-12-1981','dd-mm-yyyy'),   
	 950, null, 30   
); 
 
insert into empleados   
values(   
	 7934, 'MISAEL', 'EMPLEADO', 7782,   
	 to_date('23-1-1982','dd-mm-yyyy'),   
	 1300, null, 10   
);
