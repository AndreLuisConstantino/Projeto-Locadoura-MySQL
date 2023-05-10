#Permite exibir todos os DataBases existentes
show databases;

#Cria um database
create database db_videolocadora_tarde_20231;

#Deleta um database
#drop database db_videolocadora_tarde_20231;

#Permite selecionar database que sera utilizado
use db_videolocadora_tarde_20231;

#Exibe todas as tabelas existentes no database
show tables;

#TABELA: CLASSIFICAÇÃO
create table tbl_classificacao (
	id int not null auto_increment primary key,
    sigla varchar(2) not null,
    nome varchar(45) not null,
    descricao varchar(80) not null,
    
    unique index(id)
);

#TABELA: GENERO
create table tbl_genero (
	id int not null auto_increment primary key,
    nome varchar(45) not null,
    
    unique index (id)
);

#TABELA: SEXO
create table tbl_sexo (
	id int not null auto_increment primary key,
    sigla varchar(5) not null,
    nome varchar(45) not null,
    
    unique index (id)
);

#TABELA: NACIONALIDADE
create table tbl_nacionalidade (
	id int not null auto_increment primary key,
    nome varchar(45) not null,
    
    unique index (id)
);

#Permite visualizar a estrutura de uma tabela
desc tbl_nacionalidade;
describe tbl_nacionalidade;

### COMANDOS PARA ALTERAR UMA TABELA ###

#add column - adciona uma nova coluna na tabela 
alter table tbl_nacionalidade
	add column descricao varchar(50) not null;
    
alter table tbl_nacionalidade
	add column teste int,
    add column teste2 varchar(10) not null;

#drop column - Exclui uma coluna da tabela
alter table tbl_nacionalidade
	drop column teste2;

#modify column - Permite alterar a estrutura de uma coluna (como se tivesse criando um campo do zero)
alter table tbl_nacionalidade
	modify column teste varchar(5) not null;

#change - Permite alterar a escrita e a sua estrutura (escrita)
alter table tbl_nacionalidade
	change teste teste_nacionalidade int not null;

#drop table tbl_nacionalidade;

### CRIANDO TABELAS COM FK ###

#TABELA: FILME
create table tbl_filme (
	id int not null auto_increment primary key,
    nome varchar(100) not null,
    nome_original varchar(100) not null,
    data_lancamento date not null,
    data_relancamento date,
    duracao time not null,
    foto_capa varchar(150) not null,
    sinopse text not null,
    id_classificacao int not null,
    
    #É atribuido um nome ao processo de criar a FK
    constraint FK_Classificacao_Filme
    #É o atributo desta tabela que será a FK
    foreign key (id_classificacao)
    #Especifica de onde irá vir a FK
    references tbl_classificacao (id),
    
    unique index (id)
);

#TABELA: FILME_GENERO
create table tbl_filme_genero (
	id int not null auto_increment,
    id_filme int not null,
    id_genero int not null,
    
    #relacionamento: Filme_FilmeGenero
    constraint FK_Filme_FilmeGenero
    foreign key (id_filme)
    references tbl_filme (id),
    
    #relacionamento: Genero_FilmeGenero
    constraint FK_Genero_FilmeGenero
    foreign key (id_genero)
    references tbl_genero (id),
    
    primary key (id),
    unique index (id)
);

desc tbl_filme_genero;
desc tbl_filme;

drop table tbl_genero;

#Permite excluir uma constraint de uma tabela
	# ( somente podemos alterar a estrutura de uma tabela que fornece uma FK,
    # se apagarmos a(s) sua(s) constraint(s) )
alter table tbl_filme_genero
	drop foreign key FK_Genero_FilmeGenero;

#Permite criar uma constraint e suas relaçãores em uma tela já existente
alter table tbl_filme_genero
	add constraint FK_Genero_FilmeGenero
    foreign key (id_genero)
    references tbl_genero (id);
    
#TABELA: FILME_AVALIACAO
create table tbl_filme_avaliacao (
	id int not null auto_increment primary key,
    nota float not null,
    comentario varchar(300),
    id_filme int not null,
    
    constraint FK_Filme_FilmeAvaliacao
    foreign key (id_filme)
    references tbl_genero (id),
    
    unique index (id)
);

desc tbl_filme_avaliacao;

#TABELA: ATOR
create table tbl_ator (
	id int not null auto_increment primary key,
    nome varchar(100) not null,
    nome_artistico varchar(100),
    data_de_nascimento date not null,
    data_de_falescimento date,
    foto varchar(250) not null,
    biografia text not null,
    id_sexo int not null,
    
    constraint FK_Sexo_Ator
    foreign key (id_sexo)
    references tbl_sexo (id),
    
    unique index (id)
);

desc tbl_ator;

#TABELA: FILME_ATOR
create table tbl_filme_ator (
	id int not null auto_increment primary key,
    id_filme int not null,
    id_ator int not null,
    
    constraint FK_Filme_FilmeAtor
    foreign key (id_filme)
    references tbl_filme (id),
    
    unique index (id)
);

alter table tbl_filme_ator
	add constraint FK_Ator_FilmeAtor
    foreign key (id_ator)
    references tbl_ator (id);

desc tbl_filme_ator;

show tables;

create table tbl_ator_nacionalidade (
	id int not null auto_increment primary key,
    id_nacionalidade int not null,
    id_ator int not null,
    
    constraint FK_Ator_AtorNacionalidade
    foreign key (id_ator)
    references tbl_ator (id),
    
    constraint FK_Nacionalidade_AtorNacionalidade
    foreign key (id_nacionalidade)
    references tbl_nacionalidade (id),
    
    unique index (id)
);

desc tbl_ator_nacionalidade;

create table tbl_diretor (
	id int not null auto_increment primary key,
    nome varchar(100) not null,
    nome_artistico varchar(100),
    data_de_nascimento date not null,
    biografia text not null,
    foto varchar(250) not null,
    id_sexo int not null,
    
    constraint FK_Sexo_Diretor
    foreign key (id_sexo)
    references tbl_sexo (id),
    
    unique index (id)
);

desc tbl_diretor;

create table tbl_filme_diretor (
	id int not null auto_increment primary key,
    id_filme int not null,
    id_diretor int not null,
    
    constraint FK_Filme_FilmeDiretor
    foreign key (id_filme)
    references tbl_filme (id),
    
    constraint FK_Diretor_FilmeDiretor
    foreign key (id_diretor)
    references tbl_diretor (id),
    
    unique index (id)
);

create table tbl_diretor_nacionalidade (
	id int not null auto_increment primary key,
    id_diretor int not null,
    id_nacionalidade int not null,
    
    constraint FK_Diretor_DiretorNacionalidade
    foreign key (id_diretor)
    references tbl_diretor (id),
    
    constraint FK_Nacionalidade_DiretorNacionalidade
    foreign key (id_nacionalidade)
    references tbl_nacionalidade (id),
    
    unique index (id)
);

desc tbl_diretor_nacionalidade;

show tables;

desc tbl_filme_diretor;

### Manipulação de Dados ###

#INSERT
# TABELA DE GENERO
insert into tbl_genero (nome) values ('Policial');
insert into tbl_genero (nome) values ('Drama');

#Exemplo de insert com multiplos valores
insert into tbl_genero (nome) values ('Comédia'),
									 ('Romance'),
									 ('Aventura'),
									 ('Animação'),
									 ('Musical');

select * from tbl_genero;

#UPDATE
update tbl_genero set nome = 'Comédia' where id = 1;
update tbl_genero set nome = 'Comedia';


#TABELA CLASSIFICAÇÃO

select * from tbl_classificacao;

desc tbl_classificacao;

alter table tbl_classificacao modify column descricao varchar(150) not null;
alter table tbl_classificacao modify column nome varchar(100) not null;

insert into tbl_classificacao (sigla, nome, descricao) values 
														('L', 
                                                        'LIVRE (L)', 
                                                        'Violência: Arma sem violência; Morte sem violência; '),
														('10', 
                                                        'Não recomendado para menores de 10 (dez) anos', 
                                                        'Violência: Angústia; Arma com violência;'),
														('12', 
                                                        'Não recomendado para menores de 12 (doze) anos', 
                                                        'Drogas: Consumo de droga lícita; '),
														(
                                                        '14', 
                                                        'Não recomendado para menores de 14 (quatorze) anos', 
                                                        'Violência: Aborto; '),
														('16', 
                                                        'Não recomendado para menores de 16 (dezesseis) anos',
                                                        'Violência: Ato de pedofilia; .'),
														(
                                                        '18', 
                                                        'Não recomendado para menores de 18 (dezoito) anos',
                                                        'Violência: Apologia à violência.');
                                                        
#INSERT
#TABELA: FILME
insert into tbl_filme ( nome, 
						nome_original,
                        data_lancamento,
                        data_relancamento,
                        duracao,
                        foto_capa,
                        sinopse,
                        id_classificacao
                        ) values (
						'O Poderoso Chefão',
                        'The Godfather',
                        '1972-03-24',
                        '2022-02-04',
                        '02:55:00',
                        'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/90/93/20/20120876.jpg',
                        'Don Vito Corleone (Marlon Brando) é o chefe de uma "família" de Nova York que está feliz, pois Connie (Talia Shire), sua filha, se casou com Carlo (Gianni Russo). Porém, durante a festa, Bonasera (Salvatore Corsitto) é visto no escritório de Don Corleone pedindo "justiça", vingança na verdade contra membros de uma quadrilha, que espancaram barbaramente sua filha por ela ter se recusado a fazer sexo para preservar a honra. Vito discute, mas os argumentos de Bonasera o sensibilizam e ele promete que os homens, que maltrataram a filha de Bonasera não serão mortos, pois ela também não foi, mas serão severamente castigados. Vito porém deixa claro que ele pode chamar Bonasera algum dia para devolver o "favor". Do lado de fora, no meio da festa, está o terceiro filho de Vito, Michael (Al Pacino), um capitão da marinha muito decorado que há pouco voltou da 2ª Guerra Mundial. Universitário educado, sensível e perceptivo, ele quase não é notado pela maioria dos presentes, com exceção de uma namorada da faculdade, Kay Adams (Diane Keaton), que não tem descendência italiana mas que ele ama. Em contrapartida há alguém que é bem notado, Johnny Fontane (Al Martino), um cantor de baladas românticas que provoca gritos entre as jovens que beiram a histeria. Don Corleone já o tinha ajudado, quando Johnny ainda estava em começo de carreira e estava preso por um contrato com o líder de uma grande banda, mas a carreira de Johnny deslanchou e ele queria fazer uma carreira solo. Por ser seu padrinho Vito foi procurar o líder da banda e ofereceu 10 mil dólares para deixar Johnny sair, mas teve o pedido recusado. Assim, no dia seguinte Vito voltou acompanhado por Luca Brasi (Lenny Montana), um capanga, e após uma hora ele assinou a liberação por apenas mil dólares, mas havia um detalhe: nas "negociações" Luca colocou uma arma na cabeça do líder da banda. Agora, no meio da alegria da festa, Johnny quer falar algo sério com Vito, pois precisa conseguir o principal papel em um filme para levantar sua carreira, mas o chefe do estúdio, Jack Woltz (John Marley), nem pensa em contratá-lo. Nervoso, Johnny começa a chorar e Vito, irritado, o esbofeteia, mas promete que ele conseguirá o almejado papel. Enquanto a festa continua acontecendo, Don Corleone comunica a Tom Hagen (Robert Duvall), seu filho adotivo que atua como conselheiro, que Carlo terá um emprego mas nada muito importante, e que os "negócios" não devem ser discutidos na sua frente. Os verdadeiros problemas começam para Vito quando Sollozzo (Al Lettieri), um gângster que tem apoio de uma família rival, encabeçada por Phillip Tattaglia (Victor Rendina) e seu filho Bruno (Tony Giorgio). Sollozzo, em uma reunião com Vito, Sonny e outros, conta para a família que ele pretende estabelecer um grande esquema de vendas de narcóticos em Nova York, mas exige permissão e proteção política de Vito para agir. Don Corleone odeia esta idéia, pois está satisfeito em operar com jogo, mulheres e proteção, mas isto será apenas a ponta do iceberg de uma mortal luta entre as "famílias".',
                        16
                        );
                        
select * from tbl_filme;

desc tbl_filme;
                    
#INSERT
#TABELA DE RELAÇÃO ENTRE FILME E GENERO
insert into tbl_filme_genero (id_filme, id_genero) values(1, 2), (1, 6);

insert into tbl_filme ( nome, 
						nome_original,
                        data_lancamento,
                        data_relancamento,
                        duracao,
                        foto_capa,
                        sinopse,
                        id_classificacao
                        ) values (
						'Forrest Gump - O Contador de Histórias',
                        'Forrest Gump',
                        '1994-12-07',
                        null,
                        '02:20:00',
                        'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/30/21/19874092.jpg',
                        'Quarenta anos da história dos Estados Unidos, vistos pelos olhos de Forrest Gump (Tom Hanks), um rapaz com QI abaixo da média e boas intenções. Por obra do acaso, ele consegue participar de momentos cruciais, como a Guerra do Vietnã e Watergate, mas continua pensando no seu amor de infância, Jenny Curran.',
                        16
                        );
                        
insert into tbl_filme ( nome, 
						nome_original,
                        data_lancamento,
                        data_relancamento,
                        duracao,
                        foto_capa,
                        sinopse,
                        id_classificacao
                        ) values (
						'O Rei Leão',
                        'The Lion King',
                        '1994-07-08',
                        '2011-08-26',
                        '02:20:00',
                        'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/84/28/19962110.jpg',
                        'Clássico da Disney, a animação acompanha Mufasa (voz de James Earl Jones), o Rei Leão, e a rainha Sarabi (voz de Madge Sinclair), apresentando ao reino o herdeiro do trono, Simba (voz de Matthew Broderick). O recém-nascido recebe a bênção do sábio babuíno Rafiki (voz de Robert Guillaume), mas ao crescer é envolvido nas artimanhas de seu tio Scar (voz de Jeremy Irons), o invejoso e maquiavélico irmão de Mufasa, que planeja livrar-se do sobrinho e herdar o trono.',
                        14
                        );
                        
insert into tbl_filme ( nome, 
						nome_original,
                        data_lancamento,
                        data_relancamento,
                        duracao,
                        foto_capa,
                        sinopse,
                        id_classificacao
                        ) values (
						'À Espera de um Milagre',
                        'The Green Mile',
                        '2000-03-10',
                        null,
                        '03:09:00',
                        'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/91/66/66/20156966.jpg',
                        '1935, no corredor da morte de uma prisão sulista. Paul Edgecomb (Tom Hanks) é o chefe de guarda da prisão, que temJohn Coffey (Michael Clarke Duncan) como um de seus prisioneiros. Aos poucos, desenvolve-se entre eles uma relação incomum, baseada na descoberta de que o prisioneiro possui um dom mágico que é, ao mesmo tempo, misterioso e milagroso.',
                        16
                        );
                        
insert into tbl_filme ( nome, 
						nome_original,
                        data_lancamento,
                        data_relancamento,
                        duracao,
                        foto_capa,
                        sinopse,
                        id_classificacao
                        ) values (
						'Batman - O Cavaleiro das Trevas',
                        'The Dark Knight',
                        '2008-07-18',
                        null,
                        '02:32:00',
                        'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/86/98/32/19870786.jpg',
                        'Após dois anos desde o surgimento do Batman (Christian Bale), os criminosos de Gotham City têm muito o que temer. Com a ajuda do tenente James Gordon (Gary Oldman) e do promotor público Harvey Dent (Aaron Eckhart), Batman luta contra o crime organizado. Acuados com o combate, os chefes do crime aceitam a proposta feita pelo Coringa (Heath Ledger) e o contratam para combater o Homem-Morcego.',
                        15
                        );
                        
insert into tbl_filme ( nome, 
						nome_original,
                        data_lancamento,
                        data_relancamento,
                        duracao,
                        foto_capa,
                        sinopse,
                        id_classificacao
                        ) values (
						'Vingadores: Ultimato',
                        'Avengers: Endgame',
                        '2019-07-11',
                        null,
                        '03:01:00',
                        'https://br.web.img2.acsta.net/c_310_420/pictures/19/04/26/17/30/2428965.jpg',
                        'Em Vingadores: Ultimato, após Thanos eliminar metade das criaturas vivas em Vingadores: Guerra Infinita, os heróis precisam lidar com a dor da perda de amigos e seus entes queridos. Com Tony Stark (Robert Downey Jr.) vagando perdido no espaço sem água nem comida, o Capitão América/Steve Rogers (Chris Evans) e a Viúva Negra/Natasha Romanov (Scarlett Johansson) precisam liderar a resistência contra o titã louco.',
                        15
                        );
                        
	
select * from tbl_filme;

desc tbl_sexo;

insert into tbl_sexo (
					nome,
                    sigla
					) values (
					'Masculino',
					'M'
					);
                    
insert into tbl_sexo (
					nome,
                    sigla
					) values (
					'Feminino',
					'F'
					);
                    
select * from tbl_sexo;

insert into tbl_diretor (
						nome,
						nome_artistico,
						data_de_nascimento,
						biografia,
						foto,
						id_sexo
						) values (
						'Robert Lee Zemeckis',
                        'ROBERT ZEMECKIS',
                        '1952-05-14',
                        '- Especialista em efeitos especiais, 
                        Robert Zemeckis é um dos partidários dos filmes do também diretor 
                        Steven Spielberg, que já produziu vários de seus filmes; - 
                        Trabalhando geralmente com seu parceiro de roteiros Bob Gale, 
                        os primeiros filmes de Robert apresentou ao público seu talento 
                        para comédias tipo pastelão, como Tudo por uma Esmeralda (1984); 
                        1941 - Uma Guerra Muito Louca (1979) e, acrescentando efeitos muito
                        especiais em Uma Cilada para Roger Rabbit (1988) e De Volta para o 
                        Futuro (1985); - Apesar destes filmes terem sidos feitos meramente 
                        para o puro entretenimento, com raros desenvolvimentos dos personagens
                        ou mesmo com uma trama cuidadosa, eles são diversão na certa; 
                        - Seus filmes posteriores no entanto, se tornaram mais sérios e 
                        reflexivos, como o enormemente bem sucedido filme estrelado por Tom 
                        Hanks Forrest Gump (1994) e o filme estrelado por Jodie Foster ...',
                        'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/57/81/20030814.jpg',
						1
						);


select * from tbl_diretor;
desc tbl_diretor;