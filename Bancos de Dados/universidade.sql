create schema universidade;

-- criação das tabelas --

create table universidade.Professor (nome varchar(30), siape int, categoria varchar, salario real, cod_depto int
	CONSTRAINT ck_categoria CHECK (categoria::text = ANY (ARRAY['Adjunto II'::character varying, 'Adjunto I'::character varying, 'Assistente I'::character varying]::text[]))
);

create table universidade.Disciplina (nome varchar(30), cod_disciplina serial, carga_horaria int);

create table universidade.Departamento (nome_depto varchar(30), numero_depto serial);

create table universidade.Ministra (siape int, cod_disciplina int, periodo varchar(6));

-- criação das restrições de chave e chave estrangeira --

alter table universidade.Professor add constraint pk_prof primary key  (siape);

alter table universidade.Disciplina add constraint pk_disc primary key  (cod_disciplina);

alter table universidade.Departamento add constraint pk_dept primary key  (numero_depto);

alter table universidade.Ministra add constraint pk_min primary key  (siape, cod_disciplina, periodo);

alter table universidade.Professor add constraint fk_prof_dep foreign key (cod_depto) references universidade.Departamento(numero_depto);

alter table universidade.Ministra add constraint fk_min_prof foreign key (siape) references universidade.Professor(siape);

alter table universidade.Ministra add constraint fk_min_disc foreign key (cod_disciplina) references universidade.Disciplina(cod_disciplina);

-- inserções -- 
insert into universidade.Departamento (nome_depto) values ('Computação'), ('Sistemas de Informação'), ('Redes'), ('Eng. Computação'), ('Design Digital');

insert into universidade.Professor values
	('Ricardo Silva', 124, 'Adjunto I', 2000.00, 1),
	('João Fernando', 134, 'Adjunto II', 3000.00, 1),
	('Claudia Sales', 144, 'Adjunto II', 3000.00, 2),
	('Marcelo Antonio', 154, 'Adjunto I', 2000.00, 3),
	('Paulo Cesar', 164, 'Adjunto I', 2500.00, 4),
	('Cristina Oliveira', 174, 'Assistente I', 1500.00, 1),
	('Aparecida Souza', 184, 'Adjunto I', 2500.00, 5),
	('Joana Maria', 194, 'Adjunto I', 2500.00, 4),
	('Denis Maia', 204, 'Adjunto I', 2500.00, 5);

insert into universidade.Disciplina (nome , carga_horaria) values
	('Fundamentos de Bancos de Dados', 64),
	('Teoria da Computação', 64),
	('Autômatos e Linguagens Formais', 60),
	('Redes de alta velocidade', 86),
	('Mineração de Dados', 86),
	('Teoria Geral dos Sistemas', 30),
	('Programação para desing', 86),
	('Programação linear', 86);


insert into universidade.Ministra (siape , cod_disciplina, periodo) values
	(124, 1, '2013.1'),
	(124, 1, '2013.2'),
	(124, 1, '2014.1'),
	(134, 2, '2015.1'),
	(144, 3, '2015.1'),
	(154, 4, '2015.1'),
	(164, 5, '2015.1'),
	(174, 6, '2015.1'),
	(194, 7, '2015.1'),
	(204, 8, '2015.1');

--1

SELECT d.nome_depto AS departamento, AVG(p.salario) AS media_salarial
FROM universidade.Departamento d
JOIN universidade.Professor p ON d.numero_depto = p.cod_depto
GROUP BY d.nome_depto
ORDER BY media_salarial ASC;

--2

SELECT d.nome_depto
FROM universidade.Departamento d
JOIN universidade.Professor p ON d.numero_depto = p.cod_depto
GROUP BY d.nome_depto
HAVING AVG(p.salario) >= 2500;

--3

SELECT p.nome AS professor, COUNT(m.cod_disciplina) AS quantidade_disciplinas
FROM universidade.Professor p
LEFT JOIN universidade.Ministra m ON p.siape = m.siape
GROUP BY p.nome
ORDER BY quantidade_disciplinas DESC;

--4

SELECT periodo, SUM(carga_horaria) AS carga_horaria_ofertada
FROM universidade.Ministra m
JOIN universidade.Disciplina d ON m.cod_disciplina = d.cod_disciplina
GROUP BY periodo;

--5

SELECT p.nome AS professor, m.periodo, SUM(d.carga_horaria) AS carga_horaria_ministrada
FROM universidade.Professor p
LEFT JOIN universidade.Ministra m ON p.siape = m.siape
LEFT JOIN universidade.Disciplina d ON m.cod_disciplina = d.cod_disciplina
GROUP BY p.nome, m.periodo;

--6

SELECT d.nome_depto AS departamento, SUM(p.salario) AS soma_salarios
FROM universidade.Departamento d
JOIN universidade.Professor p ON d.numero_depto = p.cod_depto
GROUP BY d.nome_depto;

--7
SELECT d.nome_depto AS departamento, COUNT(p.siape) AS quantidade_professores
FROM universidade.Departamento d
LEFT JOIN universidade.Professor p ON d.numero_depto = p.cod_depto
GROUP BY d.nome_depto;

--8

SELECT p.nome AS professor, d.nome_depto AS departamento
FROM universidade.Professor p
JOIN universidade.Departamento d ON p.cod_depto = d.numero_depto
WHERE (
    SELECT SUM(carga_horaria)
    FROM universidade.Ministra m
    JOIN universidade.Disciplina disc ON m.cod_disciplina = disc.cod_disciplina
    WHERE m.siape = p.siape
) > (
    SELECT AVG(total_carga_horaria)
    FROM (
        SELECT SUM(carga_horaria) AS total_carga_horaria
        FROM universidade.Ministra m
        JOIN universidade.Disciplina disc ON m.cod_disciplina = disc.cod_disciplina
        GROUP BY m.siape
    ) AS subquery
);


--9
SELECT p.nome AS professor, d.nome_depto AS departamento
FROM universidade.Professor p
JOIN universidade.Departamento d ON p.cod_depto = d.numero_depto
WHERE p.siape IN (
    SELECT m.siape
    FROM universidade.Ministra m
    JOIN universidade.Disciplina d ON m.cod_disciplina = d.cod_disciplina
    JOIN universidade.Professor p2 ON m.siape = p2.siape
    WHERE p.cod_depto = p2.cod_depto
    GROUP BY m.siape
    HAVING SUM(d.carga_horaria) > (
        SELECT AVG(d2.carga_horaria)
        FROM universidade.Ministra m2
        JOIN universidade.Disciplina d2 ON m2.cod_disciplina = d2.cod_disciplina
        WHERE p.cod_depto = p2.cod_depto
    )
);

--10

SELECT *
FROM universidade.Professor
WHERE siape NOT IN (
    SELECT siape
    FROM universidade.Ministra
    WHERE cod_disciplina = 1
);

--11

SELECT p.nome AS professor, d.nome_depto AS departamento
FROM universidade.Professor p
JOIN universidade.Departamento d ON p.cod_depto = d.numero_depto
WHERE p.siape = ALL (
    SELECT siape
    FROM universidade.Ministra
    GROUP BY siape
    HAVING COUNT(DISTINCT cod_disciplina) = (
        SELECT MAX(count_disciplinas)
        FROM (
            SELECT COUNT(DISTINCT cod_disciplina) AS count_disciplinas
            FROM universidade.Ministra
            GROUP BY siape
        ) AS subquery
    )
);

--12

SELECT p.nome AS professor, d.nome_depto AS departamento
FROM universidade.Professor p
JOIN universidade.Departamento d ON p.cod_depto = d.numero_depto
WHERE p.siape = ALL (
    SELECT siape
    FROM universidade.Ministra m
    JOIN universidade.Disciplina d ON m.cod_disciplina = d.cod_disciplina
    GROUP BY siape
    HAVING SUM(d.carga_horaria) = (
        SELECT MAX(sum_carga_horaria)
        FROM (
            SELECT SUM(d.carga_horaria) AS sum_carga_horaria
            FROM universidade.Ministra m
            JOIN universidade.Disciplina d ON m.cod_disciplina = d.cod_disciplina
            GROUP BY siape
        ) AS subquery
    )
);

--13

SELECT d.nome_depto AS departamento
FROM universidade.Departamento d
WHERE d.numero_depto IN (
    SELECT p.cod_depto
    FROM universidade.Professor p
    WHERE p.siape NOT IN (
        SELECT m.siape
        FROM universidade.Ministra m
        WHERE m.periodo = '2013.1'
    )
);

--14

SELECT *
FROM universidade.Disciplina d
WHERE d.cod_disciplina NOT IN (
    SELECT m.cod_disciplina
    FROM universidade.Ministra m
);

--15

SELECT p.nome AS professor, d.nome_depto AS departamento
FROM universidade.Professor p
JOIN universidade.Departamento d ON p.cod_depto = d.numero_depto
WHERE NOT EXISTS (
    SELECT *
    FROM universidade.Ministra m
    WHERE m.siape = p.siape
        AND m.periodo = '2013.1'
);

 