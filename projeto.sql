create database biblioteca_projeto;
use biblioteca_projeto;

create table livros 
(
liv_id int primary key,
liv_titulo varchar(55),
liv_autor varchar(55),
liv_ano year,
liv_editora varchar(55),
liv_categoria varchar(55),
liv_disponibilidade boolean) ;

create table leitores (
lei_id int primary key auto_increment,
lei_nome varchar(55), 
lei_email varchar(55),
lei_telefone varchar(55),
lei_data_nascimento date,
lei_data_cadastro date);
 
 create table reservas (
 res_id int primary key auto_increment,
 res_liv_id int,
 res_lei_id int,
 res_data_reserva date,
 res_data_retirada date,
 res_data_devolucao date,
 res_status varchar(55),
 foreign key (res_liv_id) references livros(liv_id),
 foreign key (res_lei_id) references leitores(lei_id)
 );
 
 INSERT INTO livros (liv_id, liv_titulo, liv_autor, liv_ano, liv_editora, liv_categoria, liv_disponibilidade)
VALUES
(1, 'O Senhor dos Anéis', 'J.R.R. Tolkien', 1954, 'HarperCollins', 'Fantasia', TRUE),
(2, '1984', 'George Orwell', 1949, 'Secker & Warburg', 'Distopia', TRUE),
(3, 'Dom Casmurro', 'Machado de Assis', 1899, 'Editora Nacional', 'Literatura Brasileira', TRUE),
(4, 'A Brief History of Time', 'Stephen Hawking', 1988, 'Bantam Books', 'Ciência', TRUE),
(5, 'Orgulho e Preconceito', 'Jane Austen', 1813, 'T. Egerton', 'Romance', TRUE),
(6, 'O Código Da Vinci', 'Dan Brown', 2003, 'Doubleday', 'Mistério', TRUE),
(7, 'O Hobbit', 'J.R.R. Tolkien', 1937, 'George Allen & Unwin', 'Fantasia', TRUE),
(8, 'O Sol é para Todos', 'Harper Lee', 1960, 'J.B. Lippincott & Co.', 'Drama', TRUE),
(9, 'A Revolução dos Bichos', 'George Orwell', 1945, 'Secker & Warburg', 'Política', TRUE),
(10, 'O Apanhador no Campo de Centeio', 'J.D. Salinger', 1951, 'Little, Brown and Company', 'Literatura Americana', TRUE),
(11, 'Cem Anos de Solidão', 'Gabriel García Márquez', 1967, 'Editorial Sudamericana', 'Realismo Mágico', TRUE),
(12, 'O Pequeno Príncipe', 'Antoine de Saint-Exupéry', 1943, 'Reynal & Hitchcock', 'Infantil', TRUE),
(13, 'O Caçador de Pipas', 'Khaled Hosseini', 2003, 'Riverhead Books', 'Drama', TRUE),
(14, 'A Menina que Roubava Livros', 'Markus Zusak', 2005, 'Zusak Books', 'Histórico', TRUE),
(15, 'A Ilha do Tesouro', 'Robert Louis Stevenson', 1883, 'Cassell & Co.', 'Aventura', TRUE),
(16, 'O Nome do Vento', 'Patrick Rothfuss', 2007, 'DAW Books', 'Fantasia', TRUE),
(17, 'Os Miseráveis', 'Victor Hugo', 1862, 'A. Lacroix, Verboeckhoven & Cie', 'Clássico', TRUE),
(18, 'A Guerra dos Tronos', 'George R.R. Martin', 1996, 'Bantam Books', 'Fantasia', TRUE),
(19, 'O Silêncio dos Inocentes', 'Thomas Harris', 1988, 'St. Martin\'s Press', 'Thriller', TRUE),
(20, 'O Lobo das Estepes', 'Hermann Hesse', 1927, 'S. Fischer Verlag', 'Romance Filosófico', TRUE),
(21, 'A Insustentável Leveza do Ser', 'Milan Kundera', 1984, 'Harvill Secker', 'Romance', TRUE),
(22, 'Morte e Vida Severina', 'João Cabral de Melo Neto', 1955, 'Editora José Olympio', 'Poesia', TRUE),
(23, 'O Silmarillion', 'J.R.R. Tolkien', 1977, 'George Allen & Unwin', 'Fantasia', TRUE),
(24, 'Neuromancer', 'William Gibson', 1984, 'Ace Books', 'Ciberpunk', TRUE),
(25, 'O Estrangeiro', 'Albert Camus', 1942, 'Gallimard', 'Filosofia', TRUE),
(26, 'Drácula', 'Bram Stoker', 1897, 'Archibald Constable and Company', 'Terror', TRUE),
(27, 'O Homem Invisível', 'H.G. Wells', 1897, 'Ward, Lock & Co.', 'Ficção Científica', TRUE),
(28, 'A Casa dos Espíritos', 'Isabel Allende', 1982, 'Editorial Sudamericana', 'Realismo Mágico', TRUE),
(29, 'O Grande Gatsby', 'F. Scott Fitzgerald', 1925, 'Scribner', 'Romance', TRUE),
(30, 'O Sol também é uma Estrela', 'Nicola Yoon', 2016, 'Penguin Young Readers', 'Romance', TRUE),
(31, 'A Arte da Guerra', 'Sun Tzu', -500, 'Wiley', 'Estratégia', TRUE),
(32, 'O Livro dos Espíritos', 'Allan Kardec', 1857, 'François Durbach', 'Espiritismo', TRUE),
(33, 'O Homem do Castelo Alto', 'Philip K. Dick', 1962, 'Putnam', 'Distopia', TRUE),
(34, 'O Conto da Aia', 'Margaret Atwood', 1985, 'McClelland & Stewart', 'Distopia', TRUE),
(35, 'A Divina Comédia', 'Dante Alighieri', 1320, 'Various', 'Poesia Épica', TRUE),
(36, 'O Médico e o Monstro', 'Robert Louis Stevenson', 1886, 'Longmans', 'Terror', TRUE),
(37, 'O Morro dos Ventos Uivantes', 'Emily Brontë', 1847, 'Thomas Cautley Newby', 'Romance Gótico', TRUE),
(38, 'A Revolução dos Bichos', 'George Orwell', 1945, 'Secker & Warburg', 'Política', TRUE),
(39, 'O Jogo do Anjo', 'Carlos Ruiz Zafón', 2008, 'Planeta', 'Mistério', TRUE),
(40, 'A Sombra do Vento', 'Carlos Ruiz Zafón', 2001, 'Planeta', 'Mistério', TRUE),
(41, 'Eu, Robô', 'Isaac Asimov', 1950, 'Gnome Press', 'Ficção Científica', TRUE),
(42, 'Duna', 'Frank Herbert', 1965, 'Chilton Books', 'Ficção Científica', TRUE),
(43, 'O Fim da Infância', 'Arthur C. Clarke', 1953, 'Harper & Brothers', 'Ficção Científica', TRUE),
(44, 'O Padrinho', 'Mario Puzo', 1969, 'G.P. Putnam\'s Sons', 'Crime', TRUE),
(45, 'O Jardim Secreto', 'Frances Hodgson Burnett', 1911, 'Heinemann', 'Infantil', TRUE),
(46, 'O Cemitério', 'Stephen King', 1983, 'Doubleday', 'Terror', TRUE),
(47, 'A Torre Negra', 'Stephen King', 1982, 'Viking', 'Fantasia', TRUE),
(48, 'A Mão Esquerda da Escuridão', 'Ursula K. Le Guin', 1969, 'Harcourt', 'Ficção Científica', TRUE),
(49, 'O Circo da Noite', 'Erin Morgenstern', 2011, 'Doubleday', 'Fantasia', TRUE),
(50, 'O Senhor das Moscas', 'William Golding', 1954, 'Faber and Faber', 'Romance', TRUE);
 
 
 select * from livros;
 