CREATE TABLE public.l01_morador (
    mcpf numeric(11,0) NOT NULL,
    mtipo character varying(12) NOT NULL,
    mnome character varying(100) NOT NULL,
    msobrenome character varying(100) NOT NULL,
    nrofamiliares numeric DEFAULT 0 NOT NULL,
    CONSTRAINT ck_mtipo CHECK (((mtipo)::text = ANY ((ARRAY['proprietario'::character varying, 'inquilino'::character varying, 'inexistente'::character varying])::text[])))
);


ALTER TABLE public.l01_morador OWNER TO postgres;

CREATE TABLE public.l02_unidade (
    unro numeric(3,0) NOT NULL,
    uarea numeric(3,0) DEFAULT 100 NOT NULL,
    uvalorbasecond numeric(5,2) DEFAULT 300 NOT NULL,
    ucpfmorador numeric(11,0) DEFAULT 0 NOT NULL,
    CONSTRAINT ck_uarea CHECK ((uarea >= (100)::numeric))
);


ALTER TABLE public.l02_unidade OWNER TO postgres;

CREATE TABLE public.l03_veiculo (
    vplaca character varying(7) NOT NULL,
    vmodelo character varying(100),
    vcor character varying(100),
    vtipo character varying(5) NOT NULL,
    vnrounidade numeric(3,0) NOT NULL,
    CONSTRAINT ck_vtipo CHECK (((vtipo)::text = ANY ((ARRAY['moto'::character varying, 'carro'::character varying])::text[])))
);


ALTER TABLE public.l03_veiculo OWNER TO postgres;

CREATE TABLE public.l04_familiar (
    fanome character varying(100) NOT NULL,
    fanomemorador character varying(100) NOT NULL,
    fasobrenomemorador character varying(100) NOT NULL,
    faparentesco character varying(8) NOT NULL,
    CONSTRAINT ck_fparentesco CHECK (((faparentesco)::text = ANY ((ARRAY['conjuge'::character varying, 'filho'::character varying, 'agregado'::character varying])::text[])))
);


ALTER TABLE public.l04_familiar OWNER TO postgres;

CREATE TABLE public.l05_prestador (
    prcpf numeric(11,0) NOT NULL,
    prnome character varying(100) NOT NULL,
    prsobrenome character varying(100) NOT NULL,
    prdescricao character varying(300)
);


ALTER TABLE public.l05_prestador OWNER TO postgres;

CREATE TABLE public.l06_requisita (
    rdata date NOT NULL,
    rcpfmorador numeric(11,0) NOT NULL,
    rcpfprestador numeric(11,0) NOT NULL
);


ALTER TABLE public.l06_requisita OWNER TO postgres;

CREATE TABLE public.l07_administracao (
    afuncao character varying(100) NOT NULL,
    aano numeric(4,0) NOT NULL,
    acpfmorador numeric(11,0) NOT NULL,
    CONSTRAINT ck_admin CHECK (((afuncao)::text = ANY ((ARRAY['sindico'::character varying, 'vice-sindico'::character varying, 'tesoureiro'::character varying])::text[])))
);


ALTER TABLE public.l07_administracao OWNER TO postgres;

CREATE TABLE public.l08_despesa (
    dnro numeric(6,0) NOT NULL,
    dtipo character varying(10) DEFAULT 'manutencao'::character varying NOT NULL,
    dfuncaoadmin character varying(100) NOT NULL,
    danoadmin numeric(4,0) NOT NULL,
    ddatadespesa date,
    dvalordespesa numeric(10,2),
    CONSTRAINT ck_dtipo CHECK (((dtipo)::text = ANY ((ARRAY['pessoal'::character varying, 'manutencao'::character varying, 'agua'::character varying, 'gas'::character varying])::text[])))
);


ALTER TABLE public.l08_despesa OWNER TO postgres;

CREATE TABLE public.l09_funcionario (
    fucpf numeric(11,0) NOT NULL,
    funome character varying(100) NOT NULL,
    fusobrenome character varying(100) NOT NULL,
    fufuncao character varying(100) NOT NULL,
    futipo character(1) NOT NULL,
    CONSTRAINT ck_ffuncao CHECK (((fufuncao)::text = ANY ((ARRAY['zelador'::character varying, 'porteiro'::character varying, 'faxineiro'::character varying])::text[]))),
    CONSTRAINT ck_ftipo CHECK ((futipo = ANY (ARRAY['p'::bpchar, 't'::bpchar])))
);


ALTER TABLE public.l09_funcionario OWNER TO postgres;

CREATE TABLE public.l10_permanente (
    pecpf numeric(11,0) NOT NULL,
    peinss numeric(10,0) NOT NULL
);


ALTER TABLE public.l10_permanente OWNER TO postgres;

CREATE TABLE public.l11_terceirizado (
    tcpf numeric(11,0) NOT NULL,
    tcustopordia numeric(6,2) NOT NULL,
    tempresa character varying(150) NOT NULL
);


ALTER TABLE public.l11_terceirizado OWNER TO postgres;

CREATE TABLE public.l12_contrata (
    codata date NOT NULL,
    cocpffun numeric(11,0) NOT NULL,
    cofuncaoadmin character varying(100) DEFAULT 'sindico'::character varying NOT NULL,
    coanoadmin numeric(4,0) NOT NULL,
    codatainicio date NOT NULL,
    codatatermino date
);


ALTER TABLE public.l12_contrata OWNER TO postgres;

INSERT INTO public.l01_morador (mcpf, mtipo, mnome, msobrenome, nrofamiliares) VALUES (0, 'inexistente', 'desocupado', 'desocupado', 0);
INSERT INTO public.l01_morador (mcpf, mtipo, mnome, msobrenome, nrofamiliares) VALUES (1, 'proprietario', 'Adilson', 'Silva', 0);
INSERT INTO public.l01_morador (mcpf, mtipo, mnome, msobrenome, nrofamiliares) VALUES (2, 'proprietario', 'Ademar', 'Gomes', 0);
INSERT INTO public.l01_morador (mcpf, mtipo, mnome, msobrenome, nrofamiliares) VALUES (3, 'proprietario', 'Alison', 'Matos', 0);
INSERT INTO public.l01_morador (mcpf, mtipo, mnome, msobrenome, nrofamiliares) VALUES (5, 'inquilino', 'Jose', 'Souza', 0);
INSERT INTO public.l01_morador (mcpf, mtipo, mnome, msobrenome, nrofamiliares) VALUES (6, 'inquilino', 'Jair', 'Ferreira', 0);
INSERT INTO public.l01_morador (mcpf, mtipo, mnome, msobrenome, nrofamiliares) VALUES (7, 'proprietario', 'Andre', 'Gomes', 0);
INSERT INTO public.l01_morador (mcpf, mtipo, mnome, msobrenome, nrofamiliares) VALUES (8, 'inquilino', 'Mario', 'Prado', 0);
INSERT INTO public.l01_morador (mcpf, mtipo, mnome, msobrenome, nrofamiliares) VALUES (30, 'inquilino', 'livia', 'almada cruz', 0);
INSERT INTO public.l01_morador (mcpf, mtipo, mnome, msobrenome, nrofamiliares) VALUES (4, 'inquilino', 'Joao', 'Maia', 8);
INSERT INTO public.l02_unidade (unro, uarea, uvalorbasecond, ucpfmorador) VALUES (101, 100, 100.00, 6);
INSERT INTO public.l02_unidade (unro, uarea, uvalorbasecond, ucpfmorador) VALUES (102, 200, 200.00, 5);
INSERT INTO public.l02_unidade (unro, uarea, uvalorbasecond, ucpfmorador) VALUES (103, 300, 300.00, 4);
INSERT INTO public.l02_unidade (unro, uarea, uvalorbasecond, ucpfmorador) VALUES (104, 400, 400.00, 3);
INSERT INTO public.l02_unidade (unro, uarea, uvalorbasecond, ucpfmorador) VALUES (105, 500, 500.00, 2);
INSERT INTO public.l02_unidade (unro, uarea, uvalorbasecond, ucpfmorador) VALUES (106, 600, 600.00, 1);
INSERT INTO public.l02_unidade (unro, uarea, uvalorbasecond, ucpfmorador) VALUES (107, 700, 700.00, 7);
INSERT INTO public.l02_unidade (unro, uarea, uvalorbasecond, ucpfmorador) VALUES (108, 800, 800.00, 8);
INSERT INTO public.l03_veiculo (vplaca, vmodelo, vcor, vtipo, vnrounidade) VALUES ('A1', 'Fiat', 'Azul', 'carro', 101);
INSERT INTO public.l03_veiculo (vplaca, vmodelo, vcor, vtipo, vnrounidade) VALUES ('B1', 'Ford', 'Preto', 'carro', 101);
INSERT INTO public.l03_veiculo (vplaca, vmodelo, vcor, vtipo, vnrounidade) VALUES ('C1', 'Honda', 'Vermelho', 'moto', 101);
INSERT INTO public.l03_veiculo (vplaca, vmodelo, vcor, vtipo, vnrounidade) VALUES ('A2', 'Kia', 'Prata', 'carro', 102);
INSERT INTO public.l03_veiculo (vplaca, vmodelo, vcor, vtipo, vnrounidade) VALUES ('B2', 'Hyundai', 'Preto', 'carro', 102);
INSERT INTO public.l03_veiculo (vplaca, vmodelo, vcor, vtipo, vnrounidade) VALUES ('C2', 'BMW', 'Verde', 'moto', 102);
INSERT INTO public.l03_veiculo (vplaca, vmodelo, vcor, vtipo, vnrounidade) VALUES ('A3', 'Mitsubshi', 'Verde', 'carro', 103);
INSERT INTO public.l03_veiculo (vplaca, vmodelo, vcor, vtipo, vnrounidade) VALUES ('B3', 'Kawasaki', 'Amarelo', 'moto', 103);
INSERT INTO public.l03_veiculo (vplaca, vmodelo, vcor, vtipo, vnrounidade) VALUES ('A4', 'Chevrolet', 'Azul', 'carro', 104);
INSERT INTO public.l03_veiculo (vplaca, vmodelo, vcor, vtipo, vnrounidade) VALUES ('B4', 'BMW', 'Amarelo', 'carro', 104);
INSERT INTO public.l03_veiculo (vplaca, vmodelo, vcor, vtipo, vnrounidade) VALUES ('A5', 'Audi', 'Preto', 'carro', 105);
INSERT INTO public.l03_veiculo (vplaca, vmodelo, vcor, vtipo, vnrounidade) VALUES ('B5', 'Subaru', 'Vermelho', 'carro', 105);
INSERT INTO public.l03_veiculo (vplaca, vmodelo, vcor, vtipo, vnrounidade) VALUES ('A6', 'Mercedez', 'Prata', 'carro', 106);
INSERT INTO public.l03_veiculo (vplaca, vmodelo, vcor, vtipo, vnrounidade) VALUES ('A8', 'Ford', 'Prata', 'carro', 108);
INSERT INTO public.l04_familiar (fanome, fanomemorador, fasobrenomemorador, faparentesco) VALUES ('Ana', 'Adilson', 'Silva', 'conjuge');
INSERT INTO public.l04_familiar (fanome, fanomemorador, fasobrenomemorador, faparentesco) VALUES ('Alice', 'Adilson', 'Silva', 'filho');
INSERT INTO public.l04_familiar (fanome, fanomemorador, fasobrenomemorador, faparentesco) VALUES ('Alberto', 'Adilson', 'Silva', 'filho');
INSERT INTO public.l04_familiar (fanome, fanomemorador, fasobrenomemorador, faparentesco) VALUES ('Alba', 'Ademar', 'Gomes', 'conjuge');
INSERT INTO public.l04_familiar (fanome, fanomemorador, fasobrenomemorador, faparentesco) VALUES ('Anita', 'Ademar', 'Gomes', 'filho');
INSERT INTO public.l04_familiar (fanome, fanomemorador, fasobrenomemorador, faparentesco) VALUES ('Adriana', 'Alison', 'Matos', 'conjuge');
INSERT INTO public.l04_familiar (fanome, fanomemorador, fasobrenomemorador, faparentesco) VALUES ('Amelia', 'Joao', 'Maia', 'conjuge');
INSERT INTO public.l04_familiar (fanome, fanomemorador, fasobrenomemorador, faparentesco) VALUES ('Alfredo', 'Joao', 'Maia', 'filho');
INSERT INTO public.l04_familiar (fanome, fanomemorador, fasobrenomemorador, faparentesco) VALUES ('Antonio', 'Joao', 'Maia', 'filho');
INSERT INTO public.l04_familiar (fanome, fanomemorador, fasobrenomemorador, faparentesco) VALUES ('Alice', 'Joao', 'Maia', 'filho');
INSERT INTO public.l04_familiar (fanome, fanomemorador, fasobrenomemorador, faparentesco) VALUES ('Adriana', 'Joao', 'Maia', 'filho');
INSERT INTO public.l04_familiar (fanome, fanomemorador, fasobrenomemorador, faparentesco) VALUES ('Roberta', 'Jose', 'Souza', 'conjuge');
INSERT INTO public.l04_familiar (fanome, fanomemorador, fasobrenomemorador, faparentesco) VALUES ('Ronaldo', 'Jose', 'Souza', 'filho');
INSERT INTO public.l04_familiar (fanome, fanomemorador, fasobrenomemorador, faparentesco) VALUES ('Rita', 'Jair', 'Ferreira', 'conjuge');
INSERT INTO public.l04_familiar (fanome, fanomemorador, fasobrenomemorador, faparentesco) VALUES ('Marcia', 'Andre', 'Gomes', 'conjuge');
INSERT INTO public.l04_familiar (fanome, fanomemorador, fasobrenomemorador, faparentesco) VALUES ('Caio', 'Andre', 'Gomes', 'filho');
INSERT INTO public.l04_familiar (fanome, fanomemorador, fasobrenomemorador, faparentesco) VALUES ('Fabio', 'Mario', 'Prado', 'filho');
INSERT INTO public.l04_familiar (fanome, fanomemorador, fasobrenomemorador, faparentesco) VALUES ('Carla', 'Mario', 'Prado', 'conjuge');
INSERT INTO public.l05_prestador (prcpf, prnome, prsobrenome, prdescricao) VALUES (501, 'Benito', 'Barreto', 'Entregador de pizza');
INSERT INTO public.l05_prestador (prcpf, prnome, prsobrenome, prdescricao) VALUES (502, 'Barney', 'Barros', 'Eletricista');
INSERT INTO public.l05_prestador (prcpf, prnome, prsobrenome, prdescricao) VALUES (503, 'Baltazar', 'Batista', 'Encanador');
INSERT INTO public.l05_prestador (prcpf, prnome, prsobrenome, prdescricao) VALUES (504, 'Barbara', 'Beal', 'Pedreiro');
INSERT INTO public.l05_prestador (prcpf, prnome, prsobrenome, prdescricao) VALUES (505, 'Bartolomeu', 'Benini', 'Pintor');
INSERT INTO public.l05_prestador (prcpf, prnome, prsobrenome, prdescricao) VALUES (506, 'Beatriz', 'Bezerra', 'Chaveiro');
INSERT INTO public.l05_prestador (prcpf, prnome, prsobrenome, prdescricao) VALUES (507, 'Belmira', 'Bastian', 'Mecanico');
INSERT INTO public.l05_prestador (prcpf, prnome, prsobrenome, prdescricao) VALUES (508, 'Betania', 'Borges', 'Marceneiro');
INSERT INTO public.l05_prestador (prcpf, prnome, prsobrenome, prdescricao) VALUES (509, 'Bianca', 'Bueno', 'Corretor');
INSERT INTO public.l05_prestador (prcpf, prnome, prsobrenome, prdescricao) VALUES (510, 'Bill', 'Baldini', 'Veterinario');
INSERT INTO public.l06_requisita (rdata, rcpfmorador, rcpfprestador) VALUES ('0001-02-01 BC', 1, 510);
INSERT INTO public.l06_requisita (rdata, rcpfmorador, rcpfprestador) VALUES ('0001-04-06 BC', 2, 509);
INSERT INTO public.l06_requisita (rdata, rcpfmorador, rcpfprestador) VALUES ('0001-06-11 BC', 3, 508);
INSERT INTO public.l06_requisita (rdata, rcpfmorador, rcpfprestador) VALUES ('0001-08-16 BC', 4, 507);
INSERT INTO public.l06_requisita (rdata, rcpfmorador, rcpfprestador) VALUES ('0001-10-21 BC', 5, 506);
INSERT INTO public.l06_requisita (rdata, rcpfmorador, rcpfprestador) VALUES ('0001-12-26 BC', 6, 505);
INSERT INTO public.l06_requisita (rdata, rcpfmorador, rcpfprestador) VALUES ('0001-01-02 BC', 2, 504);
INSERT INTO public.l06_requisita (rdata, rcpfmorador, rcpfprestador) VALUES ('0001-03-09 BC', 3, 503);
INSERT INTO public.l06_requisita (rdata, rcpfmorador, rcpfprestador) VALUES ('0001-05-16 BC', 4, 502);
INSERT INTO public.l06_requisita (rdata, rcpfmorador, rcpfprestador) VALUES ('0001-07-23 BC', 5, 501);
INSERT INTO public.l06_requisita (rdata, rcpfmorador, rcpfprestador) VALUES ('0001-09-30 BC', 6, 510);
INSERT INTO public.l06_requisita (rdata, rcpfmorador, rcpfprestador) VALUES ('0001-11-02 BC', 1, 509);
INSERT INTO public.l06_requisita (rdata, rcpfmorador, rcpfprestador) VALUES ('0001-02-05 BC', 2, 508);
INSERT INTO public.l06_requisita (rdata, rcpfmorador, rcpfprestador) VALUES ('0001-04-08 BC', 3, 507);
INSERT INTO public.l06_requisita (rdata, rcpfmorador, rcpfprestador) VALUES ('0001-06-11 BC', 4, 506);
INSERT INTO public.l06_requisita (rdata, rcpfmorador, rcpfprestador) VALUES ('0001-08-14 BC', 5, 505);
INSERT INTO public.l06_requisita (rdata, rcpfmorador, rcpfprestador) VALUES ('0001-10-17 BC', 6, 504);
INSERT INTO public.l06_requisita (rdata, rcpfmorador, rcpfprestador) VALUES ('0001-12-20 BC', 1, 503);
INSERT INTO public.l06_requisita (rdata, rcpfmorador, rcpfprestador) VALUES ('0001-01-23 BC', 2, 502);
INSERT INTO public.l06_requisita (rdata, rcpfmorador, rcpfprestador) VALUES ('0001-03-26 BC', 3, 501);
INSERT INTO public.l06_requisita (rdata, rcpfmorador, rcpfprestador) VALUES ('0001-05-29 BC', 4, 510);
INSERT INTO public.l06_requisita (rdata, rcpfmorador, rcpfprestador) VALUES ('0001-07-03 BC', 5, 509);
INSERT INTO public.l06_requisita (rdata, rcpfmorador, rcpfprestador) VALUES ('0001-09-11 BC', 6, 508);
INSERT INTO public.l06_requisita (rdata, rcpfmorador, rcpfprestador) VALUES ('0001-11-19 BC', 1, 507);
INSERT INTO public.l06_requisita (rdata, rcpfmorador, rcpfprestador) VALUES ('0001-02-27 BC', 2, 506);
INSERT INTO public.l06_requisita (rdata, rcpfmorador, rcpfprestador) VALUES ('0001-04-09 BC', 3, 505);
INSERT INTO public.l06_requisita (rdata, rcpfmorador, rcpfprestador) VALUES ('0001-06-11 BC', 4, 504);
INSERT INTO public.l06_requisita (rdata, rcpfmorador, rcpfprestador) VALUES ('0001-08-13 BC', 5, 503);
INSERT INTO public.l06_requisita (rdata, rcpfmorador, rcpfprestador) VALUES ('0001-10-15 BC', 6, 502);
INSERT INTO public.l06_requisita (rdata, rcpfmorador, rcpfprestador) VALUES ('0001-12-17 BC', 1, 501);
INSERT INTO public.l07_administracao (afuncao, aano, acpfmorador) VALUES ('sindico', 2008, 5);
INSERT INTO public.l07_administracao (afuncao, aano, acpfmorador) VALUES ('vice-sindico', 2008, 3);
INSERT INTO public.l07_administracao (afuncao, aano, acpfmorador) VALUES ('tesoureiro', 2008, 6);
INSERT INTO public.l07_administracao (afuncao, aano, acpfmorador) VALUES ('sindico', 2009, 1);
INSERT INTO public.l07_administracao (afuncao, aano, acpfmorador) VALUES ('vice-sindico', 2009, 6);
INSERT INTO public.l07_administracao (afuncao, aano, acpfmorador) VALUES ('tesoureiro', 2009, 3);
INSERT INTO public.l07_administracao (afuncao, aano, acpfmorador) VALUES ('sindico', 2010, 2);
INSERT INTO public.l07_administracao (afuncao, aano, acpfmorador) VALUES ('vice-sindico', 2010, 4);
INSERT INTO public.l07_administracao (afuncao, aano, acpfmorador) VALUES ('tesoureiro', 2010, 1);
INSERT INTO public.l07_administracao (afuncao, aano, acpfmorador) VALUES ('sindico', 2011, 5);
INSERT INTO public.l07_administracao (afuncao, aano, acpfmorador) VALUES ('vice-sindico', 2011, 4);
INSERT INTO public.l07_administracao (afuncao, aano, acpfmorador) VALUES ('tesoureiro', 2011, 3);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (1, 'pessoal', 'sindico', 2008, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (2, 'manutencao', 'vice-sindico', 2008, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (3, 'agua', 'tesoureiro', 2008, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (4, 'gas', 'vice-sindico', 2008, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (5, 'pessoal', 'sindico', 2008, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (6, 'manutencao', 'tesoureiro', 2008, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (7, 'agua', 'tesoureiro', 2008, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (8, 'gas', 'vice-sindico', 2008, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (9, 'pessoal', 'sindico', 2008, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (10, 'manutencao', 'tesoureiro', 2008, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (11, 'agua', 'vice-sindico', 2009, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (12, 'gas', 'sindico', 2009, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (13, 'pessoal', 'vice-sindico', 2009, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (14, 'manutencao', 'tesoureiro', 2009, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (15, 'agua', 'tesoureiro', 2009, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (16, 'gas', 'tesoureiro', 2009, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (17, 'pessoal', 'sindico', 2009, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (18, 'manutencao', 'tesoureiro', 2009, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (19, 'agua', 'tesoureiro', 2009, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (20, 'gas', 'tesoureiro', 2009, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (21, 'pessoal', 'tesoureiro', 2010, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (22, 'manutencao', 'sindico', 2010, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (23, 'agua', 'vice-sindico', 2010, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (24, 'gas', 'vice-sindico', 2010, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (25, 'pessoal', 'sindico', 2010, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (26, 'manutencao', 'sindico', 2010, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (27, 'agua', 'tesoureiro', 2010, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (28, 'gas', 'tesoureiro', 2010, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (29, 'pessoal', 'sindico', 2010, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (30, 'manutencao', 'vice-sindico', 2010, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (31, 'agua', 'tesoureiro', 2011, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (32, 'gas', 'vice-sindico', 2010, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (33, 'pessoal', 'sindico', 2010, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (34, 'manutencao', 'tesoureiro', 2010, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (35, 'agua', 'vice-sindico', 2010, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (36, 'gas', 'sindico', 2010, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (37, 'pessoal', 'sindico', 2010, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (38, 'manutencao', 'tesoureiro', 2010, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (39, 'agua', 'vice-sindico', 2010, NULL, NULL);
INSERT INTO public.l08_despesa (dnro, dtipo, dfuncaoadmin, danoadmin, ddatadespesa, dvalordespesa) VALUES (40, 'gas', 'sindico', 2010, NULL, NULL);
INSERT INTO public.l09_funcionario (fucpf, funome, fusobrenome, fufuncao, futipo) VALUES (901, 'Fabio', 'Faber', 'zelador', 'p');
INSERT INTO public.l09_funcionario (fucpf, funome, fusobrenome, fufuncao, futipo) VALUES (902, 'Fernanda', 'Farias', 'porteiro', 'p');
INSERT INTO public.l09_funcionario (fucpf, funome, fusobrenome, fufuncao, futipo) VALUES (903, 'Flavio', 'Feiden', 'faxineiro', 'p');
INSERT INTO public.l09_funcionario (fucpf, funome, fusobrenome, fufuncao, futipo) VALUES (904, 'Fabiana', 'Ferla', 'faxineiro', 't');
INSERT INTO public.l09_funcionario (fucpf, funome, fusobrenome, fufuncao, futipo) VALUES (905, 'Fabricio', 'Figueira', 'porteiro', 'p');
INSERT INTO public.l09_funcionario (fucpf, funome, fusobrenome, fufuncao, futipo) VALUES (906, 'Faustina', 'Follman', 'faxineiro', 't');
INSERT INTO public.l09_funcionario (fucpf, funome, fusobrenome, fufuncao, futipo) VALUES (907, 'Felicia', 'Foster', 'zelador', 't');
INSERT INTO public.l09_funcionario (fucpf, funome, fusobrenome, fufuncao, futipo) VALUES (908, 'Felizardo', 'Franchini', 'porteiro', 'p');
INSERT INTO public.l09_funcionario (fucpf, funome, fusobrenome, fufuncao, futipo) VALUES (909, 'Ferdinanda', 'Franco', 'faxineiro', 't');
INSERT INTO public.l09_funcionario (fucpf, funome, fusobrenome, fufuncao, futipo) VALUES (910, 'Fidelio', 'Freitas', 'faxineiro', 'p');
INSERT INTO public.l09_funcionario (fucpf, funome, fusobrenome, fufuncao, futipo) VALUES (911, 'Flora', 'Friederich', 'porteiro', 't');
INSERT INTO public.l09_funcionario (fucpf, funome, fusobrenome, fufuncao, futipo) VALUES (912, 'Felipe', 'Furtado', 'faxineiro', 't');
INSERT INTO public.l09_funcionario (fucpf, funome, fusobrenome, fufuncao, futipo) VALUES (913, 'Floriana', 'Friz', 'zelador', 't');
INSERT INTO public.l09_funcionario (fucpf, funome, fusobrenome, fufuncao, futipo) VALUES (914, 'Firmino', 'Ferrari', 'porteiro', 't');
INSERT INTO public.l09_funcionario (fucpf, funome, fusobrenome, fufuncao, futipo) VALUES (915, 'Freda', 'Ferreira', 'faxineiro', 'p');
INSERT INTO public.l10_permanente (pecpf, peinss) VALUES (901, 9191);
INSERT INTO public.l10_permanente (pecpf, peinss) VALUES (902, 9292);
INSERT INTO public.l10_permanente (pecpf, peinss) VALUES (903, 9393);
INSERT INTO public.l10_permanente (pecpf, peinss) VALUES (905, 9595);
INSERT INTO public.l10_permanente (pecpf, peinss) VALUES (908, 9898);
INSERT INTO public.l10_permanente (pecpf, peinss) VALUES (910, 910910);
INSERT INTO public.l10_permanente (pecpf, peinss) VALUES (915, 915915);
INSERT INTO public.l11_terceirizado (tcpf, tcustopordia, tempresa) VALUES (904, 40.00, 'Seguranca e Cia.');
INSERT INTO public.l11_terceirizado (tcpf, tcustopordia, tempresa) VALUES (906, 60.00, 'Condominios S.A.');
INSERT INTO public.l11_terceirizado (tcpf, tcustopordia, tempresa) VALUES (907, 70.00, 'Construtiva');
INSERT INTO public.l11_terceirizado (tcpf, tcustopordia, tempresa) VALUES (909, 90.00, 'Segurarte');
INSERT INTO public.l11_terceirizado (tcpf, tcustopordia, tempresa) VALUES (911, 110.00, 'Firme e Forte');
INSERT INTO public.l11_terceirizado (tcpf, tcustopordia, tempresa) VALUES (912, 120.00, 'Condominius');
INSERT INTO public.l11_terceirizado (tcpf, tcustopordia, tempresa) VALUES (913, 130.00, 'Portal');
INSERT INTO public.l11_terceirizado (tcpf, tcustopordia, tempresa) VALUES (914, 140.00, 'Imoveis Seguros');
INSERT INTO public.l12_contrata (codata, cocpffun, cofuncaoadmin, coanoadmin, codatainicio, codatatermino) VALUES ('0001-03-20 BC', 901, 'sindico', 2008, '0001-03-21 BC', '0001-03-22 BC');
INSERT INTO public.l12_contrata (codata, cocpffun, cofuncaoadmin, coanoadmin, codatainicio, codatatermino) VALUES ('0001-02-20 BC', 902, 'vice-sindico', 2008, '0001-02-20 BC', '0001-02-27 BC');
INSERT INTO public.l12_contrata (codata, cocpffun, cofuncaoadmin, coanoadmin, codatainicio, codatatermino) VALUES ('0001-01-05 BC', 903, 'sindico', 2008, '0001-01-10 BC', '0001-01-11 BC');
INSERT INTO public.l12_contrata (codata, cocpffun, cofuncaoadmin, coanoadmin, codatainicio, codatatermino) VALUES ('0001-05-25 BC', 904, 'vice-sindico', 2008, '0001-05-30 BC', '0001-06-03 BC');
INSERT INTO public.l12_contrata (codata, cocpffun, cofuncaoadmin, coanoadmin, codatainicio, codatatermino) VALUES ('0001-02-17 BC', 910, 'sindico', 2008, '0001-02-21 BC', '0001-02-21 BC');
INSERT INTO public.l12_contrata (codata, cocpffun, cofuncaoadmin, coanoadmin, codatainicio, codatatermino) VALUES ('0001-06-18 BC', 905, 'vice-sindico', 2009, '0001-06-25 BC', '0001-06-27 BC');
INSERT INTO public.l12_contrata (codata, cocpffun, cofuncaoadmin, coanoadmin, codatainicio, codatatermino) VALUES ('0001-07-22 BC', 911, 'vice-sindico', 2009, '0001-07-27 BC', '0001-07-30 BC');
INSERT INTO public.l12_contrata (codata, cocpffun, cofuncaoadmin, coanoadmin, codatainicio, codatatermino) VALUES ('0001-09-13 BC', 906, 'tesoureiro', 2009, '0001-09-15 BC', '0001-09-21 BC');
INSERT INTO public.l12_contrata (codata, cocpffun, cofuncaoadmin, coanoadmin, codatainicio, codatatermino) VALUES ('0001-10-17 BC', 907, 'sindico', 2009, '0001-10-18 BC', '0001-10-23 BC');
INSERT INTO public.l12_contrata (codata, cocpffun, cofuncaoadmin, coanoadmin, codatainicio, codatatermino) VALUES ('0001-11-18 BC', 908, 'vice-sindico', 2009, '0001-11-29 BC', '0001-11-30 BC');
INSERT INTO public.l12_contrata (codata, cocpffun, cofuncaoadmin, coanoadmin, codatainicio, codatatermino) VALUES ('0001-12-28 BC', 909, 'vice-sindico', 2010, '0001-12-30 BC', '0001-01-15 BC');
INSERT INTO public.l12_contrata (codata, cocpffun, cofuncaoadmin, coanoadmin, codatainicio, codatatermino) VALUES ('0001-02-27 BC', 901, 'vice-sindico', 2010, '0001-03-01 BC', '0001-03-04 BC');
INSERT INTO public.l12_contrata (codata, cocpffun, cofuncaoadmin, coanoadmin, codatainicio, codatatermino) VALUES ('0001-03-17 BC', 910, 'vice-sindico', 2010, '0001-03-21 BC', '0001-03-29 BC');
INSERT INTO public.l12_contrata (codata, cocpffun, cofuncaoadmin, coanoadmin, codatainicio, codatatermino) VALUES ('0001-05-10 BC', 912, 'tesoureiro', 2010, '0001-05-15 BC', '0001-05-17 BC');
INSERT INTO public.l12_contrata (codata, cocpffun, cofuncaoadmin, coanoadmin, codatainicio, codatatermino) VALUES ('0001-07-20 BC', 913, 'sindico', 2011, '0001-07-20 BC', '0001-07-28 BC');
INSERT INTO public.l12_contrata (codata, cocpffun, cofuncaoadmin, coanoadmin, codatainicio, codatatermino) VALUES ('0001-07-12 BC', 914, 'vice-sindico', 2011, '0001-07-22 BC', '0001-09-22 BC');
INSERT INTO public.l12_contrata (codata, cocpffun, cofuncaoadmin, coanoadmin, codatainicio, codatatermino) VALUES ('0001-09-21 BC', 903, 'sindico', 2011, '0001-09-23 BC', '0001-09-30 BC');
INSERT INTO public.l12_contrata (codata, cocpffun, cofuncaoadmin, coanoadmin, codatainicio, codatatermino) VALUES ('0001-08-11 BC', 910, 'vice-sindico', 2011, '0001-08-21 BC', '0001-10-25 BC');
INSERT INTO public.l12_contrata (codata, cocpffun, cofuncaoadmin, coanoadmin, codatainicio, codatatermino) VALUES ('0001-10-07 BC', 911, 'sindico', 2011, '0001-10-10 BC', '0001-10-18 BC');
INSERT INTO public.l12_contrata (codata, cocpffun, cofuncaoadmin, coanoadmin, codatainicio, codatatermino) VALUES ('0001-10-21 BC', 906, 'vice-sindico', 2011, '0001-10-21 BC', '0001-10-30 BC');

ALTER TABLE ONLY public.l07_administracao
    ADD CONSTRAINT pk_admin PRIMARY KEY (afuncao, aano);

ALTER TABLE ONLY public.l12_contrata
    ADD CONSTRAINT pk_contr PRIMARY KEY (codata, cocpffun, cofuncaoadmin, coanoadmin);

ALTER TABLE ONLY public.l08_despesa
    ADD CONSTRAINT pk_despesa PRIMARY KEY (dnro);

ALTER TABLE ONLY public.l04_familiar
    ADD CONSTRAINT pk_familiar PRIMARY KEY (fanome, fanomemorador, fasobrenomemorador);

ALTER TABLE ONLY public.l09_funcionario
    ADD CONSTRAINT pk_func PRIMARY KEY (fucpf);

ALTER TABLE ONLY public.l01_morador
    ADD CONSTRAINT pk_morad PRIMARY KEY (mcpf);

ALTER TABLE ONLY public.l10_permanente
    ADD CONSTRAINT pk_perm PRIMARY KEY (pecpf);

ALTER TABLE ONLY public.l05_prestador
    ADD CONSTRAINT pk_prestador PRIMARY KEY (prcpf);

ALTER TABLE ONLY public.l06_requisita
    ADD CONSTRAINT pk_requisita PRIMARY KEY (rdata, rcpfprestador, rcpfmorador);

ALTER TABLE ONLY public.l11_terceirizado
    ADD CONSTRAINT pk_terc PRIMARY KEY (tcpf);

ALTER TABLE ONLY public.l02_unidade
    ADD CONSTRAINT pk_unidade PRIMARY KEY (unro);

ALTER TABLE ONLY public.l03_veiculo
    ADD CONSTRAINT pk_veiculo PRIMARY KEY (vplaca);

ALTER TABLE ONLY public.l07_administracao
    ADD CONSTRAINT un_admin UNIQUE (aano, acpfmorador);

ALTER TABLE ONLY public.l01_morador
    ADD CONSTRAINT un_mmorad UNIQUE (mnome, msobrenome);

CREATE INDEX l08 ON public.l08_despesa USING btree (dnro);

ALTER TABLE ONLY public.l07_administracao
    ADD CONSTRAINT fk_amorador FOREIGN KEY (acpfmorador) REFERENCES public.l01_morador(mcpf) ON DELETE CASCADE;

ALTER TABLE ONLY public.l12_contrata
    ADD CONSTRAINT fk_coadmin FOREIGN KEY (cofuncaoadmin, coanoadmin) REFERENCES public.l07_administracao(afuncao, aano);

ALTER TABLE ONLY public.l12_contrata
    ADD CONSTRAINT fk_cofun FOREIGN KEY (cocpffun) REFERENCES public.l09_funcionario(fucpf);

ALTER TABLE ONLY public.l08_despesa
    ADD CONSTRAINT fk_dadmin FOREIGN KEY (dfuncaoadmin, danoadmin) REFERENCES public.l07_administracao(afuncao, aano);

ALTER TABLE ONLY public.l04_familiar
    ADD CONSTRAINT fk_morador FOREIGN KEY (fanomemorador, fasobrenomemorador) REFERENCES public.l01_morador(mnome, msobrenome) ON DELETE CASCADE;

ALTER TABLE ONLY public.l10_permanente
    ADD CONSTRAINT fk_pefunc FOREIGN KEY (pecpf) REFERENCES public.l09_funcionario(fucpf);

ALTER TABLE ONLY public.l06_requisita
    ADD CONSTRAINT fk_rmorador FOREIGN KEY (rcpfmorador) REFERENCES public.l01_morador(mcpf) ON DELETE CASCADE;

ALTER TABLE ONLY public.l06_requisita
    ADD CONSTRAINT fk_rprestador FOREIGN KEY (rcpfprestador) REFERENCES public.l05_prestador(prcpf);

ALTER TABLE ONLY public.l11_terceirizado
    ADD CONSTRAINT fk_tfunc FOREIGN KEY (tcpf) REFERENCES public.l09_funcionario(fucpf);

ALTER TABLE ONLY public.l02_unidade
    ADD CONSTRAINT fk_umorador FOREIGN KEY (ucpfmorador) REFERENCES public.l01_morador(mcpf);

ALTER TABLE ONLY public.l03_veiculo
    ADD CONSTRAINT fk_vunidade FOREIGN KEY (vnrounidade) REFERENCES public.l02_unidade(unro);

--1 - Liste o número de requisições de serviços de cada prestador juntamente com o nome do prestador.

SELECT prnome, COUNT(*) AS num_requisicoes
FROM public.l05_prestador
JOIN public.l06_requisita ON l05_prestador.prcpf = l06_requisita.rcpfprestador
GROUP BY prnome;

--2 - Liste a quantidade total de moradores do condomínio, contando com o morador e seus familiares.

SELECT SUM(nrofamiliares + 1) AS total_moradores
FROM public.l01_morador
LEFT JOIN public.l04_familiar ON l01_morador.mcpf = l04_familiar.fanomemorador;

--3 - Liste o valor total arrecadado com condomínio de todas as unidades. 

SELECT SUM(uvalorbasecond) AS valor_total_arrecadado
FROM public.l02_unidade;

--4 - Liste o maior e o menor valor pago de condomínio.

--Não é possível obter maior e menor valor pago por condominio, pois não há informaçẽs sobre o valor pago por cada morador.

--5 - Liste a quantidade de funcionários contratados para cada função.

SELECT fufuncao, COUNT(*) AS qtd_funcionarios
FROM l09_funcionario
GROUP BY fufuncao;

--6 - Liste os prestadores que realizaram mais que 3 serviços.

SELECT P.prnome, COUNT(*) AS num_servico 
FROM public.l05_prestador P
JOIN public.l06_requisita R ON R.rcpfprestador = P.prcpf
GROUP BY P.prnome
HAVING COUNT(*) > 3;

--7 - Liste as unidades que possuem mais de dois veículos.

SELECT V.vnrounidade, COUNT(*) AS qtd_veiculos 
FROM l03_veiculo V
JOIN l02_unidade U ON V.vnrounidade = U.unro
GROUP BY V.vnrounidade
HAVING COUNT(*) > 2;

--8 - Liste todas as unidades que não possuem veículos.

SELECT V.vnrounidade, COUNT(*) AS qtd_veiculos 
FROM l03_veiculo V
JOIN l02_unidade U ON V.vnrounidade = U.unro
GROUP BY V.vnrounidade
HAVING COUNT(*) = NULL;

--9 - Calcule o valor médio das despesas por tipo. 

SELECT dtipo, AVG(dvalordespesa) AS valor_medio
FROM public.l08_despesa
GROUP BY dtipo;

--10 - Liste os tipos de despesas cujo custo  médio foi maior que 20.

SELECT dtipo, AVG(dvalordespesa) AS valor_medio
FROM public.l08_despesa
GROUP BY dtipo
HAVING AVG(dvalordespesa) > 20;
