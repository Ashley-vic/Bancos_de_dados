 SET search_path = bilheteria;

 CREATE TABLE FILME (
  CODIGO SERIAL PRIMARY KEY,
  TITULO VARCHAR(100) NOT NULL,
  SINOPSE TEXT,
  DURACAO_MIN INTEGER NOT NULL,
  CLASSIFICACAO VARCHAR(10)
 );

 CREATE TABLE SALA (
   NUMERO SERIAL PRIMARY KEY,
   QTD_POLTRONAS INTEGER
 );

 CREATE TABLE POLTRONA (
   NUMERO_SALA INTEGER,
   COD_POLTRONA VARCHAR(3),
   PRIMARY KEY(NUMERO_SALA,COD_POLTRONA),
   FOREIGN KEY(NUMERO_SALA) REFERENCES SALA(NUMERO)
 );

 CREATE TABLE SESSAO (
   COD_SESSAO SERIAL PRIMARY KEY,
   DT DATE,
   HORARIO INTEGER,
   DIM CHAR(2),
   LINGUAGEM VARCHAR(20),
   SALA_NUM INTEGER,
   FILME_ID INTEGER,
   FOREIGN KEY(SALA_NUM) REFERENCES SALA(NUMERO),
   FOREIGN KEY(FILME_ID) REFERENCES FILME(CODIGO),
   UNIQUE(DT, HORARIO, SALA_NUM)
 );

 INSERT INTO SALA (QTD_POLTRONAS) VALUES (20);

 INSERT INTO POLTRONA (NUMERO_SALA, COD_POLTRONA) VALUES
   (1, 'A1'), (1, 'A2');

 INSERT INTO POLTRONA (NUMERO_SALA, COD_POLTRONA) VALUES
   (1, 'A3');

 SELECT * FROM SALA;



 --1. Questao
 alter table poltrona
 add column idp integer;

 alter table poltrona
 add constraint unk_idp unique(idp);


-- 2. Questao
 --Inserindo 5 filmes
 INSERT INTO FILME (TITULO, SINOPSE, DURACAO_MIN, CLASSIFICACAO) VALUES
('American Pie: O primeiro pedaço', 'Um grupo de amigos decide fazer um pacto para perder a virgindade antes do baile de formatura do colegial.', 95, '16 anos'),
('American Pie 2: A segunda vez é ainda melhor', 'Os amigos se reencontram no verão e decidem passar as férias em uma casa na praia.', 108, '16 anos'),
('American Pie: O casamento', 'Jim e Michelle ficam noivos e planejam o casamento, mas o pai da noiva não aprova o noivo.', 96, '14 anos'),
('American Pie: Tocando a Maior Zona', 'Matt Stifler, irmão mais novo de Steve Stifler, organiza uma festa em sua casa que promete ser épica.', 95, '18 anos'),
('American Pie: O reencontro', 'Os amigos se reencontram dez anos após o ensino médio e decidem fazer uma nova festa para recordar os velhos tempos.', 113, '16 anos');

 --Inserindo 5 salas
 INSERT INTO SALA (QTD_POLTRONAS) VALUES
   (100), (80), (60), (40), (20);

 --Inserindo 5 poltronas em cada sala
 INSERT INTO POLTRONA (NUMERO_SALA, COD_POLTRONA) VALUES
   (32, 'A1'), (33, 'A2'),
   (34, 'A1'), (32, 'A2'),
   (32, 'C2'), (34, 'B1'),
   (33, 'A1'), (35, 'B1'),
   (35, 'C1'), (35, 'D1');

 --Inserindo 5 sessões
 INSERT INTO SESSAO (DT, HORARIO, DIM, LINGUAGEM, SALA_NUM, FILME_ID) VALUES
   ('2023-04-17', 14, '2D', 'Dublado', 1, 26),
   ('2023-04-18', 16, '2D', 'Legendado', 32, 27),
   ('2023-04-19', 18, '3D', 'Dublado', 33, 28),
   ('2023-04-20', 20, '3D', 'Legendado', 34, 29),
   ('2023-04-21', 22, '2D', 'Dublado', 35, 30);
  

 --3. Questão
 SELECT * FROM FILME;
 SELECT * FROM SESSAO;
 SELECT * FROM POLTRONA;
 SELECT * FROM SALA;


 --4. Questão
 --a) Seria cod_sessao que faria referência á cod_sessao da tabela SESSAO e id_poltrona que faria referência á cod_poltrona da tabela POLTRONA.
 --b) As chaves candidatas seria a combinação de (cod_sessao, id_poltrona) e cod_bilhete. O (cod_sessao, id_poltrona) pode ser a chave primaria
 --c) 
 CREATE TABLE Bilhete (
   cod_sessao INTEGER,
   id_poltrona VARCHAR(3),
   cod_bilhete SERIAL PRIMARY KEY,
   FOREIGN KEY (cod_sessao, id_poltrona) REFERENCES Poltrona(numero_sala, cod_poltrona)
 );
-- d)
 INSERT INTO Bilhete (cod_sessao, id_poltrona)
 VALUES 
   (1, 'A1'),
   (1, 'A2'),
   (1, 'A3'),
   (32, 'A1'),
   (33, 'A2');

 --5. Questão
 CREATE TABLE GeneroFilme (
   id SERIAL PRIMARY KEY,
   codigo_filme INTEGER,
   genero VARCHAR(50),
   FOREIGN KEY (codigo_filme) REFERENCES Filme(codigo)
 );

 INSERT INTO GeneroFilme (codigo_filme, genero)
 VALUES
   (26, 'Comédia'),
   (26, 'Comédia'),
   (27, 'Comédia romântica'),
   (27, 'Comédia'),
   (28, 'Comédia romântica')

 --6. Questão
 DELETE FROM FILME WHERE codigo= 30
 O comando da erro, pois o filme ta sendo referenciado em uma outra tabela

 --7. Questão
 UPDATE POLTRONA SET id_poltrona=Y WHERE id_poltrona=X
 O comando da erro, pois e não é permitido atualizar um registro referenciado enquanto houver registros na tabela referenciadora que dependam dele