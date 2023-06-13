CREATE TABLE public.aluno
(
    matricula integer primary key,
    cpf character varying(12) unique,
    nome character varying(50) ,
    cod_curso integer
);

CREATE TABLE public.disciplina
(
    cod_disciplina integer primary key,
	nome varchar(20),
    cod_curso integer
);

CREATE TABLE public.livro
(
    cod integer primary key,
    isbn character varying(15) unique,
    titulo character varying(100),
    editora character varying(50),
	nome_autor character varying(50)
);

CREATE TABLE public.livro_adotado
(
    cod_disciplina integer,
    cod_livro integer,
	primary key(cod_disciplina,cod_livro), 
	foreign key(cod_disciplina) references disciplina(cod_disciplina),
	foreign key(cod_livro) references livro(cod)
);

--Questão 2. a)

CREATE TABLE historico(
        matricula_aluno INTEGER NOT NULL,
        cod_disciplina INTEGER NOT NULL,
        semestre INT NOT NULL,
        ano INT NOT NULL,
        nota NUMERIC NOT NULL,

        PRIMARY KEY (matricula_aluno, cod_disciplina),
        FOREIGN KEY (cod_disciplina) REFERENCES disciplina (cod_disciplina),
        FOREIGN KEY (matricula_aluno) REFERENCES aluno (matricula)
);

--Questão 2. b)

INSERT INTO public.aluno VALUES (56, 876323, 'Igor', 7), (50, 323564, 'Karina', 8);
INSERT INTO public.disciplina VALUES (1, 'historia', 7), (2, 'inglês', 8);
INSERT INTO public.livro VALUES (5, 7654321, 'Sapiens', 'saraiva', 'Noah Harari'), (6, 1234567, 'Game of thrones', 'saraiva', 'George R.R');
INSERT INTO public.livro_adotado VALUES (1, 5), (2, 6);
INSERT INTO public.aluno VALUES (876323, 1, 1, 2023, 10), (323564, 2, 1, 2023, 10);

--Questão 2. c)

DELETE FROM aluno WHERE matricula = 56;

-- Este comando gera um erro pois a matricula é referenciada na tabela histórico, portanto ela viola 
-- restrição de chave estrangeira.

--Questão 3. a) 

SELECT nome_autor 
FROM livro L
WHERE L.nome_autor = '%A'

--Questão 3. b)

SELECT aluno.nome, disciplina.cod_disciplina
FROM public.aluno
INNER JOIN public.historico ON aluno.matricula = historico.matricula_aluno
INNER JOIN public.disciplina ON historico.cod_disciplina = disciplina.cod_disciplina;

--Questão 3. c)

SELECT livro.titulo, COUNT(livro_adotado.cod_disciplina) AS qtd_disciplinas
FROM public.livro
LEFT JOIN public.livro_adotado ON livro.cod = livro_adotado.cod_livro
GROUP BY livro.cod, livro.titulo;

--Qestão 3. d)

SELECT cod_disciplina
FROM public.historico
WHERE nota > 9
GROUP BY cod_disciplina
HAVING COUNT(DISTINCT matricula_aluno) > 10;
