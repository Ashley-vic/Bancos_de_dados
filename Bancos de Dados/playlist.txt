set schema 'playlist';

CREATE TABLE Artista
(
  cod_autor INT NOT NULL,
  nome VARCHAR(50) NOT NULL,
  PRIMARY KEY (cod_autor)
);

CREATE TABLE Gravadora
(
  nome VARCHAR(50) NOT NULL,
  id_gravadora INT NOT NULL,
  endereco VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_gravadora)
);

CREATE TABLE Musica
(
  cod_musica INT NOT NULL,
  titulo VARCHAR(50) NOT NULL,
  id_gravadora INT NOT NULL,
  PRIMARY KEY (cod_musica),
  FOREIGN KEY (id_gravadora) REFERENCES Gravadora(id_gravadora)
);

CREATE TABLE Usuario
(
  id_usuario INT NOT NULL,
  nome VARCHAR(50)  NOT NULL,  
  PRIMARY KEY (id_usuario)
  
);

CREATE TABLE Playlist
(
  id_playlist INT NOT NULL,
  nome VARCHAR(50) NOT NULL,
  descricao VARCHAR(50) NOT NULL,
  id_usu INT NOT NULL,
  PRIMARY KEY (id_playlist),
  FOREIGN KEY (id_usu) REFERENCES Usuario(id_usuario)
);



CREATE TABLE Musica_Artista
(
  cod_musica INT NOT NULL,
  cod_artista INT NOT NULL,
  PRIMARY KEY (cod_musica, cod_artista),
  FOREIGN KEY (cod_musica) REFERENCES Musica(cod_musica),
  FOREIGN KEY (cod_artista) REFERENCES Artista(cod_autor)
);



CREATE TABLE Playlist_Musica
(
  id_playlist INT NOT NULL,
  cod_musica INT NOT NULL,
  PRIMARY KEY (id_playlist, cod_musica),
  FOREIGN KEY (id_playlist) REFERENCES Playlist(id_playlist),
  FOREIGN KEY (cod_musica) REFERENCES Musica(cod_musica)
);

--- povoando o banco 

INSERT INTO public.usuario(id_usuario, nome)
	VALUES (10, 'Ana'), (11,'Bruno');

	
INSERT INTO public.artista(
            cod_autor, nome)
    VALUES (10, 'Engenheiros do Hawai');

INSERT INTO public.artista(
            cod_autor, nome)
    VALUES (11, 'Coldplay');

 INSERT INTO public.artista(
            cod_autor, nome)
    VALUES (12, 'Marisa Monte');

INSERT INTO public.gravadora(
            nome, id_gravadora, endereco)
    VALUES ('Som Livre', 1, 'Av. Itinerante, 10'), ('Max Discos', 2, 'Rua Pedro I, 20');
    

INSERT INTO public.musica(
            cod_musica, id_gravadora, titulo)
    VALUES (10, 1, 'Ifininta Highway'), (21, 2, 'The Scientist'), (22,2,'Vilarejo');

INSERT INTO public.musica_artista(
            cod_musica, cod_artista)
    VALUES (10, 10), (22,12), (21,11) ;

INSERT INTO public.playlist(
            id_playlist, id_usu, nome, descricao)
    VALUES 
    (1, 10, 'Variadas', 'Minhas preferidas'), 
    (2, 11, 'Nacionais', 'Músicas do Brasil');

INSERT INTO public.playlist_musica(
            id_playlist, cod_musica)
    VALUES (1,10), (1,21), (2,10),(2,22);

--1.Insira cinco novas músicas no banco de dados e seus respectivos artistas.

INSERT INTO public.Musica(cod_musica, titulo, id_gravadora)
VALUES (11, 'Yellow', 1)(12, 'Velha Infancia', 2)(13,'depois', 2)
      (14, 'Ate o fim', 1)(15, 'piano Bar', 1);

INSERT INTO public.Musica_Artista(cod_musica, cod_artista)
VALUES (11, 11)(12, 12)(13, 12)(14, 10)(15, 10);

--2.Insira cada música da questão em uma das playlists já criadas.

INSERT INTO public.playlist_musica(id_playlist, cod_musica) 
VALUES (1, 11), (1, 15), (2, 12), (2, 13), (1, 14);

--3.Obtenha o título da música cujo código é 10.

SELECT titulo FROM public.Musica WHERE cod_musica = 10; 

--4.Obtenha os dados da música cujo título é ‘Infinita Highway.

SELECT * FROM public.Musica WHERE titulo = Infinita Highway;

--5.Obtenha os títulos de todas as músicas.

SELECT titulo FROM public.Musica;

--6.Obtenha o título e nome da gravadora de todas as músicas.

SELECT Musica.titulo, Gravadora.nome
FROM Musica
JOIN Gravadora ON Musica.id_gravadora = Gravadora.id_gravadora;

--7.Obtenha os dados das playlists da Ana.

SELECT * FROM Playlist WHERE id_usu = 10; 

--8.Obtenha as músicas que começam com a letra A. 

SELECT titulo FROM Musica WHERE titulo LIKE 'A%';

--9.Obtenha as músicas que terminam com a letra A e tem 5 letras no título. 

SELECT titulo FROM Musica WHERE titulo LIKE '____A' AND length(titulo) = 5;

--10.Obtenha os dados dos artistas com código entre 3 e 10. Use o operador Between.

SELECT * FROM Artista WHERE cod_autor BETWEEN 3 AND 10;

--11.Obter, sem repetição, o título das músicas e a nome da gravadora das músicas que estão em
--alguma playlist de Bruno.

SELECT DISTINCT Musica.titulo, Gravadora.nome
FROM Musica M
JOIN Playlist_Musica PM ON M.cod_musica = PM.cod_musica
JOIN Playlist P ON PM.id_playlist = Gravadora.id_gravadora;
JOIN Gravadora G ON M.id_gravadora = G.id_gravadora
WHERE P.id_usu = 11;

--12.. Obter, sem repetição, os artistas das músicas que estão em alguma playlist da Ana.

SELECT DISTINCT A.nome
FROM Artista
JOIN Musica_Artista MA ON A.cod_autor = MA.cod_artista
JOIN Musica M ON MA.cod_musica = M.cod_musica
JOIN Playlist_Musica PM ON M.cod_musica = PM.cod_musica
JOIN Playlist P ON PM.id_playlist = P.id_playlist
WHERE P.id_usu = 10;

--13.Obter o título das músicas que estão em alguma playlist da Ana e também do Bruno.

SELECT DISTINCT Musica.titulo
FROM Musica M 
JOIN Playlist_Musica PM ON M.cod_musica = PM.cod_musica
JOIN Playlist P ON PM.id_playlist = P.id_playlist
WHERE P.id_usu = 10 OR P.id_usu = 11;

--14.. Obter todas as músicas que não estão em nenhuma playlist.

  SELECT * FROM Musica WHERE cod_musica NOT IN (SELECT cod_artista
  FROM Playlist_Musica);

--15.Obter o nome dos artistas que estão na playlist 1 ou 2, mas não em ambas.

  SELECT DISTINCT A.nome
  FROM Artista A 
  LEFT JOIN (
    SELECT DISTINCT cod_autor
    FROM Playlist_Musica PM
    JOIN Playlist P ON PM.id_playlist
    WHERE P.id_playlist = 1
  ) P1 ON A.cod_autor = P1.cod_autor
  LEFT JOIN (
    SELECT DISTINCT cod_autor
    FROM Playlist_Musica PM 
    JOIN Playlist P ON PM.id_playlist = P.id_playlist
    WHERE P.id_playlist = 2
  ) P2 ON A.cod_autor = P2.cod_autor
  WHERE (P1.cod_autor IS NOT NULL AND P2.cod_autor IS NULL) OR (P1.cod_autor IS NULL AND P2.cod_autor IS NOT NULL);
