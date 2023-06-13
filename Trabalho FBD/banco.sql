create schema "Condominio_Consumo";

CREATE TABE condominio(
	endereco character varying(100) NOT NULL,
	Unidades numeric DEFAULT 0 NOT NULL
);

create table casa(
	numero numeric NOT NULL,
	qtd_moradores int NOT NULL,
	nro_unidade numeric NOT NULL,
	FOREIGN KEY casa (nro_unidade) REFERENCES condominio (Unidades)
);

CREATE TABLE morador (
    mcpf numeric(11,0) NOT NULL, 
    mnome character varying(100) NOT NULL,
    nro_moradores numeric DEFAULT 0 NOT NULL,
	nro_casa numeric NOT NULL,
	FOREIGN KEY morador (nro_casa) REFERENCES casa (numero)
);

