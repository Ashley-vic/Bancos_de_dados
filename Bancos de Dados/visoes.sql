CREATE TABLE fornecedor
(
 fnome varchar(20),
 cidade varchar(20),
 fid integer NOT NULL,
 CONSTRAINT id PRIMARY KEY (fid)
);
CREATE TABLE projeto
(
 jid integer NOT NULL,
 jnome varchar(20),
 cidade varchar(20),
 CONSTRAINT j_pkey PRIMARY KEY (jid)
);
CREATE TABLE peca
(
 pid integer NOT NULL,
 pnome varchar(20),
 cor varchar(20),
 CONSTRAINT p_pkey PRIMARY KEY (pid)
);
CREATE TABLE fpj
(
 fid integer NOT NULL,
 pid integer NOT NULL,
 jid integer NOT NULL,
qtd integer NOT NULL,
 CONSTRAINT p_pkey1 PRIMARY KEY (fid,pid,jid),
 constraint fk_1 foreign key(fid) references fornecedor(fid),
 constraint fk_2 foreign key(pid) references peca(pid),
 constraint fk_3 foreign key(jid) references projeto(jid)
);
insert into fornecedor values ('Maria','Fortaleza',1);
insert into fornecedor values('Lucia','São Paulo',2);
insert into fornecedor values('João','Fortaleza',3);
insert into fornecedor values('Ana','Rio de Janeiro',4);
insert into fornecedor values('Pedro','Teresina',5);
insert into peca values (1,'peca1','preto');
insert into peca values(2,'peca2','branco');
insert into peca values(3,'peca3','preto');
insert into projeto values (1,'projeto1','Fortaleza');
insert into projeto values(2,'projeto2','São Paulo');
insert into projeto values(3,'projeto3','Teresina');
insert into projeto values (4,'projeto4','Fortaleza');
insert into projeto values(5,'projeto5','São Paulo');
insert into projeto values(6,'projeto6','Teresina');
insert into fpj values (3,3,3,300);
insert into fpj values(2,1,4,500);
insert into fpj values(2,1,5,450);
insert into fpj values (2,1,1,300);
insert into fpj values(3,2,5,200);
insert into fpj values(1,2,6,100);
insert into fpj values(3,1,3,200);

--1.

SELECT p.pnome AS peça,
       COUNT(DISTINCT fpj.jid) AS número_total_de_projetos,
       SUM(fpj.qtd) AS quantidade_total_usada,
       SUM(fpj.qtd) AS quantidade_total_usada_por_projeto
FROM peca p
LEFT JOIN fpj ON p.pid = fpj.pid
GROUP BY p.pid, p.pnome;

--2.

SELECT fpj.jid AS número_do_projeto
FROM fpj
INNER JOIN peca ON fpj.pid = peca.pid
WHERE peca.pnome = 'peca1'
GROUP BY fpj.jid
HAVING AVG(fpj.qtd) > (SELECT MAX(qtd) FROM fpj WHERE jid = 1);

--3.

SELECT p.pnome AS nome_da_peca,
       MAX(fpj.qtd) AS quantidade_maxima_fornecida,
       MIN(fpj.qtd) AS quantidade_minima_fornecida
FROM peca p
INNER JOIN fpj ON p.pid = fpj.pid
GROUP BY p.pid, p.pnome;

--4.

CREATE VIEW entregas_peca AS
SELECT p.pnome AS nome_da_peca,
       MAX(fpj.qtd) AS quantidade_maxima_fornecida,
       MIN(fpj.qtd) AS quantidade_minima_fornecida
FROM peca p
INNER JOIN fpj ON p.pid = fpj.pid
WHERE fpj.fid <> 1
GROUP BY p.pid, p.pnome;

SELECT * FROM entregas_peca;


