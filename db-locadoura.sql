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
#INSERT
#TABELA FILME DIRETOR
select * from tbl_filme;
select * from tbl_diretor;
insert into tbl_filme_diretor (id_filme, id_diretor) values (1,2);
insert into tbl_filme_diretor (id_filme, id_diretor) values (2,1);
insert into tbl_filme_diretor (id_filme, id_diretor) values (3,3), (3,8);


select * from tbl_filme_diretor;

### Manipulação de Dados ###

#INSERT
# TABELA DE GENERO
insert into tbl_genero (nome) values ('Policial');
insert into tbl_genero (nome) values ('Drama');
insert into tbl_genero (nome) values ('Musical');
insert into tbl_genero (nome) values ('Familia');
insert into tbl_genero (nome) values ('Fantasia');
insert into tbl_genero (nome) values ('Fantasia');
insert into tbl_genero (nome) values ('Ação');
insert into tbl_genero (nome) values ('Suspense');
insert into tbl_genero (nome) values ('Ficção Cientifica');

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

desc tbl_filme;
                    
#INSERT
#TABELA DE RELAÇÃO ENTRE FILME E GENERO
select * from tbl_filme;
select * from tbl_genero;

insert into tbl_filme_genero (id_filme, id_genero) values(1, 2), (1, 6);
insert into tbl_filme_genero (id_filme, id_genero) values (2,3), (2,6), (2,1);

update tbl_filme_genero set id_filme = 3 where id = 6;
update tbl_filme_genero set id_filme = 3 where id = 7;
update tbl_filme_genero set id_filme = 3 where id = 8;
update tbl_filme_genero set id_filme = 3 where id = 9;
update tbl_filme_genero set id_filme = 3 where id = 10;
insert into tbl_filme_genero (id_filme, id_genero) values (3,5), (3,4), (3,1), (3,7), (3,8);
insert into tbl_filme_genero (id_filme, id_genero) values (4,9), (4,2);
insert into tbl_filme_genero (id_filme, id_genero) values (5,10), (5,11);
insert into tbl_filme_genero (id_filme, id_genero) values (6,10), (6,4), (6,12), (6,9);

select * from tbl_filme_genero;

##INSERT
#TABELA DE FILME
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

##iNSERT
#TABELA SEXO
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

##INSERT
#TABELA DIRETOR
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

insert into tbl_diretor (
						nome,
						nome_artistico,
						data_de_nascimento,
						biografia,
						foto,
						id_sexo
						) values (
						'Francis Ford Coppola',
                        'Francis F. Copolla',
                        '1939-04-07',
                        '- Em 1969, fundou juntamente com George Lucas a produtora American Zoetrope, em São Francisco, tendo como primeiro projeto o filme THX 1138 (1970);- 
                        É tio do ator Nicolas Cage;- Pai da tambem diretora Sofia Coppola;- Foi assistente de direção de Roger Corman;- Graduado na Universidade da Califórnia (UCLA),
                        a mesma dos diretores, George Lucas e Steven Spielberg.',
                        'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/35/21/99/19187501.jpg',
						1
						);
                        
insert into tbl_diretor (
						nome,
						nome_artistico,
						data_de_nascimento,
						biografia,
						foto,
						id_sexo
						) values (
						'Robert Ralph Minkoff',
                        'ROB MINKOFF',
                        '1962-07-11',
                        'Minkoff conseguiu sua grande chance quando ele dirigiu para a Walt Disney Animation Studios O Rei Leão (1994), ao lado de Roger Allers. Desde então, ele também dirigiu o seu primeiro filme live-action O Pequeno Stuart Little (1999), e Stuart Little 2 (2002), que eram uma mistura de live-action e animação por computador e depois alguns filmes totalmente em live-actions como A Mansão Assombrada (2003), O Reino Proibido (2008) e Flypaper (2011).
                        Ele também participa como membro do júri para a NYICFF, no Festival de Cinema da Cidade de Nova York dedicado a triagem de filmes para crianças com idades entre 3 a 18 anos.[2]',
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/Rob_Minkoff.jpg/200px-Rob_Minkoff.jpg',
						1
						);
                        
insert into tbl_diretor (
						nome,
						nome_artistico,
						data_de_nascimento,
						biografia,
						foto,
						id_sexo
						) values (
						'Roger Allers',
                        null,
                        '1949-06-29',
                        'Roger Allers é um diretor, roteirista, artista de storyboard, cartunista e dramaturgo americano. Ele é mais conhecido por co-dirigir o 
                        filme de animação tradicional de maior bilheteria na história, O Rei Leão da Walt Disney Animation Studios, e por escrever a adaptação da Broadway, O Rei Leão.',
                        'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/91/54/06/20150846.jpg',
						1
						);
                        
insert into tbl_diretor (
						nome,
						nome_artistico,
						data_de_nascimento,
						biografia,
						foto,
						id_sexo
						) values (
						'Ferenc Árpád Darabont',
                        'FRANK DARABONT',
                        '1959-01-28',
                        '- É o autor dos roteiros de "A Hora do Pesadelo 3", "A Mosca 2" e "Frankenstein de Mary Shelley".- Trabalhou como roteirista na série de TV norte-americana "O Jovem Indiana Jones".',
                        'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/90/95/95/20122149.jpg',
						1
						);
       
insert into tbl_diretor (
						nome,
						nome_artistico,
						data_de_nascimento,
						biografia,
						foto,
						id_sexo
						) values (
						'Christopher Edward Nolan',
                        'CHRISTOPHER NOLAN',
                        '1970-07-30',
                        '- É o autor dos roteiros de "A Hora do Pesadelo 3", "A Mosca 2" e "Frankenstein de Mary Shelley".- Trabalhou como roteirista na série de TV norte-americana "O Jovem Indiana Jones".',
                        'https://br.web.img3.acsta.net/c_310_420/pictures/15/02/26/15/33/118611.jpg',
						1
						);
                        
insert into tbl_diretor (
						nome,
						nome_artistico,
						data_de_nascimento,
						biografia,
						foto,
						id_sexo
						) values (
						'Joseph Vincent Russo',
                        'JOE RUSSO',
                        '1971-07-08',
                        'Anthony Russo e Joseph V. Russo, também conhecidos como Irmãos Russo, são diretores de cinema e televisão americanos. Os dois fazem a maior parte de seu trabalho em conjunto, e também, ocasionalmente, trabalham como roteiristas, atores e editores. Dirigiram a segunda maior bilheteria mundial.',
                        'https://br.web.img2.acsta.net/c_310_420/pictures/15/11/24/17/01/231901.jpg',
						1
						);
                        
insert into tbl_diretor (
						nome,
						nome_artistico,
						data_de_nascimento,
						biografia,
						foto,
						id_sexo
						) values (
						'Anthony J. Russo',
                        'ANTHONY RUSSO',
                        '1970-02-3',
                        'Anthony Russo e Joseph V. Russo, também conhecidos como Irmãos Russo, são diretores de cinema e televisão americanos. Os dois fazem a maior parte de seu trabalho em conjunto, e também, ocasionalmente, trabalham como roteiristas, atores e editores. Dirigiram a segunda maior bilheteria mundial.',
                        'https://br.web.img2.acsta.net/c_310_420/pictures/15/11/24/16/59/250993.jpg',
						1
						);
       
select * from tbl_diretor;

##INSERT
#TABELA ATOR
desc tbl_ator;
select * from tbl_ator;

insert into tbl_ator (
					nome,
                    nome_artistico,
                    data_de_nascimento,
                    data_de_falescimento,
                    foto,
                    biografia,
                    id_sexo
					) values (
					'MARLON BRANDO',
                    null,
					'1924-04-02',
                    '2004-07-01',
                    'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/51/54/20040663.jpg',
                    '- Trabalhou como ascensorista de elevador em uma loja por 4 dias, antes de se tornar famoso.
                    - Possui uma ilha particular no oceano Pacífico, na Polinésia, desde 1966.
                    - O Oscar que ganhou por "Sindicato dos Ladrões" foi roubado de sua casa, com o ator tendo solicitado à Academia de Artes e Ciências Cinematográficas a reposição da estatueta, em 1970.
                    - Recusou o Oscar recebido por "O Poderoso Chefão", em protesto pelo modo como os Estados Unidos e, especialmente, Hollywood vinham discriminando os índios nativos do país. Brando não compareceu à cerimônia de entrega do Oscar e enviou em seu lugar a atriz Sacheen Littlefeather, que subiu ao palco para receber a estatueta do ator como se fosse uma índia verdadeira, divulgando seu protesto.
                    - Em determinado momento das filmagens de "A Cartada Final", se recusava a estar no mesmo set que o diretor Frank Oz.
					- Possui uma estrela na Calçada da Fama, localizada em 1777 Vine Street.',
                    '1'
                    );
                    
insert into tbl_ator (
					nome,
                    nome_artistico,
                    data_de_nascimento,
                    data_de_falescimento,
                    foto,
                    biografia,
                    id_sexo
					) values (
					'Alfredo James Pacino',
                    'AL PACINO',
					'1940-04-25',
                    null,
                    'https://br.web.img3.acsta.net/c_310_420/pictures/19/03/19/18/33/1337912.jpg',
                    '- É um grande fã de ópera;- É um dos poucos astros de Hollywood que nunca casou;- Foi preso em janeiro de 1961, acusado de carregar consigo uma arma escondida;
                    - Recusou o personagem Han Solo, da trilogia original de "Star Wars";
                    - Foi o primeiro na história do Oscar a ser indicado no mesmo ano nas categorias de 
                    melhor ator e melhor ator coadjuvante.',
                    '1'
                    );
                    
insert into tbl_ator (
					nome,
                    nome_artistico,
                    data_de_nascimento,
                    data_de_falescimento,
                    foto,
                    biografia,
                    id_sexo
					) values (
					'Thomas Jeffrey Hanks',
                    'TOM HANKS',
					'1956-07-09',
                    null,
                    'https://br.web.img3.acsta.net/c_310_420/pictures/18/08/08/18/47/1167635.jpg',
                    'Tom Hanks iniciou a carreira no cinema aos 24 anos, com um papel no filme de baixo orçamento Trilha de Corpos. Logo migrou para a TV, onde estrelou por dois anos a série Bosom Buddies. 
                    Nela passou a trabalhar com comédia, algo com o qual não estava habituado, rendendo convites para pequenas participações nas séries Táxi, Caras & Caretas e Happy Days.
                    Em 1984, veio seu primeiro sucesso no cinema: a comédia Splash - Uma Sereia em Minha Vida, na qual era dirigido por Ron Howard e contracenava com Daryl Hannah. Em seguida vieram várias comédias, 
                    entre elas A Última Festa de Solteiro (1984), Um Dia a Casa Cai (1986) e Dragnet - Desafiando o Perigo (1987), tornando-o conhecido do grande público.
                    Com Quero Ser Grande (1988) Hanks obteve sua primeira indicação ao Oscar de melhor ator. Apesar de consagrado como comediante, aos poucos passou a experimentar outros gêneros. 
                    Em 1993 surpreendeu em Filadélfia como um advogado homossexual que luta na justiça contra sua demissão, motivada por preconceito devido a ele ser portador do vírus da AIDS. Pelo papel conquistou seu primeiro Oscar.
                    Já no ano seguinte Hanks ganharia sua segunda estatueta dourada, repetindo um feito apenas obtido por Spencer Tracy, quase 60 anos antes. Forrest Gump - O Contador de Histórias foi sucesso de público e crítica, 
                    ganhando seis Oscar.Estabelecido como um dos maiores astros de Hollywood, Hanks passou a emendar um sucesso atrás do outro: Apollo 13 - Do Desastre ao Triunfo (1995), Toy Story (1995), O Resgate do Soldado Ryan (1998), Mens@gem Para Você (1998), Toy Story 2 (1999), À Espera de um Milagre (1999), Náufrago (2000), Prenda-me Se For Capaz (2002) e Estrada para Perdição (2002).
                    Em 1996, resolveu se dedicar à sua estreia na direção. O resultado foi The Wonders - O Sonho Não Acabou, divertida comédia que rendeu a contagiante música "That Thing You Do!". Hanks voltaria a trabalhar como diretor em episódios das séries de TV Da Terra à Lua (1998) e Band of Brothers (2001) e também na comédia romântica Larry Crowne - O Amor Está de Volta (2011).
                    Em 2004, o ator encampou a ideia de interpretar vários personagens na animação O Expresso Polar, dirigida pelo colega Robert Zemeckis. Usando o método de captura de movimento, Hanks interpretou seis personagens de idades variadas.
                    Um de seus personagens mais famosos é o simbologista Robert Langdon, criado pelo autor Dan Brown. Hanks o interpretou em dois filmes, O Código Da Vinci (2006) e Anjos e Demônios (2009).',
                    '1'
                    );
                    
insert into tbl_ator (
					nome,
                    nome_artistico,
                    data_de_nascimento,
                    data_de_falescimento,
                    foto,
                    biografia,
                    id_sexo
					) values (
					'Gary Alan Sinise',
                    'GARY SINISE',
					'1955-03-17',
                    null,
                    'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/92/45/36/20200745.jpg',
                    'Gary Alan Sinise é um ator norte-americano, diretor de cinema e músico. Durante sua carreira, 
                    ganhou vários prêmios, incluindo um Emmy e um Globo de Ouro, além de ser nomeado para um Oscar. 
                    Também é conhecido por estrelar como o detetive Mac Taylor na série CSI: New York',
                    '1'
                    );
                    
insert into tbl_ator (
					nome,
                    nome_artistico,
                    data_de_nascimento,
                    data_de_falescimento,
                    foto,
                    biografia,
                    id_sexo
					) values (
					'GARCIA JÚNIOR',
                    null,
					'1967-03-02',
                    null,
                    'https://br.web.img2.acsta.net/c_310_420/pictures/14/01/16/13/52/556410.jpg',
                    'Manoel Garcia Júnior é um ator, dublador, radialista, tradutor e diretor de dublagem brasileiro. Manoel é filho dos também dubladores Garcia Neto e Dolores Machado.',
                    '1'
                    );
                    
insert into tbl_ator (
					nome,
                    nome_artistico,
                    data_de_nascimento,
                    data_de_falescimento,
                    foto,
                    biografia,
                    id_sexo
					) values (
					'MATTHEW BRODERICK',
                    null,
					'1962-03-21',
                    null,
                    'https://br.web.img2.acsta.net/c_310_420/pictures/19/07/02/22/47/0236519.jpg',
                    'Matthew Broderick é um ator norte-americano, célebre pela sua atuação como Ferris Bueller em Ferris Buellers Day Off de 1986, e por outros papéis, como David Lightman em WarGames, 
                    Jimmy Garrett em Projeto Secreto: Macacos, Nick Tatopoulos, em Godzilla e o personagem título em Inspector Gadget.',
                    '1'
                    );
                    
insert into tbl_ator (
					nome,
                    nome_artistico,
                    data_de_nascimento,
                    data_de_falescimento,
                    foto,
                    biografia,
                    id_sexo
					) values (
					'MICHAEL CLARKE DUNCAN',
                    'Michael Duncan',
					'1957-12-10',
                    '2012-09-03',
                    'https://br.web.img3.acsta.net/c_310_420/pictures/14/09/06/19/41/147683.jpg',
                    'Michael Clarke Duncan é conhecido pela atuação em À Espera de um Milagre, que lhe rendeu indicações ao Oscar e ao Globo de Ouro de Melhor Ator Coadjuvante. 
                    Fez sua estreia nos cinemas em 1995, com um papel não creditado em Sexta-Feira em Apuros. O primeiro trabalho de destaque viria três anos depois com Armageddon. 
                    Agradou tanto que Bruce Willis recomendou que Frank Darabont contratasse ele para À Espera de um Milagre, em 1999.
					Muitas vezes tratado como Big Mike, por causa da altura de 1,96 m, o ator se destacou ainda em Meu Vizinho Mafioso, 
                    Planeta dos Macacos, O Escorpião Rei e A Ilha. Participou também de três adaptações dos quadrinhos: O Demolidor, Sin City
                    - A Cidade do Pecado e Lanterna Verde. Robert Rodriguez contava com o retorno dele para Sin City 2: A Dame to Kill For, algo que infelizmente não irá mais acontecer.
					Na TV, Clarke Duncan contou com participações em importantes seriados, como Um Maluco no Pedaço, Bones, 
                    Chuck e Two and a Half Men. Faleceu em setembro de 2012, aos 54 anos, após passar dois meses hospitalizado em Los Angeles.',
                    '1'
                    );
                    
insert into tbl_ator (
					nome,
                    nome_artistico,
                    data_de_nascimento,
                    data_de_falescimento,
                    foto,
                    biografia,
                    id_sexo
					) values (
					'Christian Charles Philip Bale',
                    'CHRISTIAN BALE',
					'1974-01-30',
                    null,
                    'https://br.web.img3.acsta.net/c_310_420/pictures/15/02/24/18/43/126776.jpg',
                    'Caçula de três irmãs mais velhas, filho de um piloto de aviação comercial e de uma dançarina de circo, Bale começou a atuar por influência de uma delas. Pouca gente recorda que este ator inglês é o menino Jim, 
                    que tocou corações em Império do Sol (1987), de Steven Spielberg. Para ganhar o papel, derrotou cerca de quatro mil candidatos e sua atuação ainda rendeu prêmios.
					Mesmo tendo começado cedo (aos 9 anos fez seu primeiro comercial de cereais), foi somente com Psicopata Americano (2000) que ganhou mais notoriedade no papel de Patrick Bateman, que seria, incialmente, de Leonardo DiCaprio.
					Sua dedicação ao trabalho é reconhecida e sua "entrega" para viver Trevor em O Operário (2004), quando emagreceu cerca de 30 kg, foi considerada chocante demais.
					Famoso por sua aversão a entrevistas, Bale é capaz de concedê-las com seu bom sotaque americano apenas para não confundir o público, caso o filme em questão seja de um personagem americano.
					Curiosamente, dois personagens famosos de sua galeria começam com a primeira letra de seu sobrenome: Bateman e Batman. Ao lado de Michael Keaton, foi o segundo ator a viver mais de uma vez o personagem no cinema, o primeiro não americano e o mais jovem. Em 2011, com O Vencedor (2010) tornou-se o segundo intérprete do homem-morcego a faturar o Oscar. O outro tinha sido George Clooney, por Syriana - A Indústria do Petróleo (2005).
					Reservado sobre sua vida pessoal, Bale é casado desde 2000 e tem uma filha, Emmaline Bale, nascida em 2005. Chegou a ser vegetariano, mas voltou a comer carne. Adora ler, é fã do jogo Mario Bros., 
                    apaixonado  por animais e defensor de causas sociais, constuma se envolver em organizações como Greenpeace e Dian Fossey Gorilla Fun, entre outros.',
                    '1'
                    );
                    
insert into tbl_ator (
					nome,
                    nome_artistico,
                    data_de_nascimento,
                    data_de_falescimento,
                    foto,
                    biografia,
                    id_sexo
					) values (
					'Heathcliff Andrew Ledger',
                    'Heath Ledger',
					'1979-04-04',
                    '2008-01-22',
                    'https://br.web.img2.acsta.net/c_310_420/pictures/18/08/16/19/43/2593099.jpg',
                    'Extremamente tímido, este australiano descendente de irlandeses e escoceses optou por atuar desde cedo. Mesmo com a rápida fama conquistada, em parte por sua beleza, ele procurou interpretar papéis que não explorassem este aspecto e conseguiu atuações marcantes em sua curta carreira. Premiado após sua morte pela atuação como Coringa, Ledger tem seu lugar marcado para sempre na história do cinema mundial. (RC)
					- Filho de Sally Ramshaw e Kim Ledger;
					- Descendente de irlandeses e escoceses;
                    - Teve três irmãs: Catherine (Kate) Ledger, Olivia Ledger e Ashleigh Bell;
					- Seu nome e o da irmã mais velha, Kate Ledger, foram retirados dos personagens principais do romance "Wuthering Heights" de Emily Brontë;
					- Teve um canguru de esimação, achado por sua mãe quando ainda era filhote;
                    - Na escola, era concentrado em atuar e nos esportes. Quando pediram para decidir entre os dois, optou por atuar;
                    - Foi selecionado para a seleção de hóquei Sub-17, mas preferiu abrir mão para tentar a carreira de ator;
                    - Seu primeiro papel foi Peter Pan, aos 10 anos de idade, numa peça de teatro local;
                    - Namorou a atriz Heather Graham de Outubro de 2000 até June de 2001;
                    - Namorou a atriz Naomi Watts de agosto de 2002 até maio de 2004;
                    - Conheceu sua esposa Michelle Williams nas filmagens de O Segredo de Brokeback Mountain (2005);
                    - O ator Jake Gyllenhaal é o padrinho de sua filha Matilda Ledger;
                    - É um dos sete padrinhos de Damien, filho da atriz Elizabeth Hurley;
                    - Fez parte do elenco dos seriado "Roar" (1997) onde atuou ao lado de Vera Farmiga, na época, uma atriz desconhecida;
                    - Fez teste para o papel de Max no seriado "Roswell" (1999), mas por ter participado de "Roar", que teve baixa audiência, foi recusado pela Fox;
                    - Desistiu de fazer Australia (2008) para interpretar o Coringa em Batman - O Cavaleiro das Trevas;
                    - Foi eleito, ou esteve entre os principais, Mais Sexy, Mais Bonito, de publicações como People Magazine, Empire, entre outras;
                    - Quando atuou em Josie e as Gatinhas (2001) foi chamado de "o novo Matt Damon", com que ele foi atuar somente em 2005 em Os Irmãos Grimm;
                    - Tinha sido a escolha original para estrelar Alexandre (2004), de Oliver Stone, mas o papel acabou ficando com Colin Farrell;
                    - Estrelou três filmes que foram exibidos no Festival de Veneza: O Segredo de Brokeback Mountain (2005), Os Irmãos Grimm (2005) e Casanova (2005);
                    - Entres seus astros favoritos figuravam Gene Kelly, Judy Garland, Bob Fosse, Stanley Kubrick, Katharine Hepburn, Jack Nicholson, Marcel Cann, Terrence Malick, Mel Gibson e Meryl Streep;
                    - Trabalhou com Mel Gibson em O Patriota;
                    - Substituiu Jack Nicholson no personagem Coringa;
                    - Buscou inspiração para o Coringa no filme Laranja Mecânica de Kubrick;
                    - Admirava Johnny Depp e era muito amigo dos atores Russell Crowe, Joaquin Phoenix e do músico Ben Harper;',
                    '1'
                    );
		
insert into tbl_ator (
					nome,
                    nome_artistico,
                    data_de_nascimento,
                    data_de_falescimento,
                    foto,
                    biografia,
                    id_sexo
					) values (
					'Robert John Downey Jr',
                    'ROBERT DOWNEY JR.',
					'1965-04-04',
                    null,
                    'https://br.web.img3.acsta.net/c_310_420/pictures/18/06/29/00/35/0101925.jpg',
                    'Do céu ao inferno e ao céu novamente. Se alguém pensou no mito do pássaro fênix que renasce das cinzas, até que a comparação poderia se encaixar para definir este brilhante ator que já deu vida para personagens 
                    tão distantes em tempo e estilo, como Charles Chaplin (Chaplin - 1992) e Tony Stark (Homem de Ferro - 2008).
					Na ativa por mais de quatro décadas e dono de uma voz grave, afinada, Downey já dublou desenho animado (God, the Devil and Bob - 2000),
                    se aventurou no mundo da música, em 2004, com o disco The Futurist (Sony) e fez bonito na televisão, onde faturou o Globo de Ouro, além de outros prêmios e indicações por Larry Paul, 
                    personagem do seriado Ally McBeal (2000 - 2002).',
                    '1'
                    );
                    
insert into tbl_ator (
					nome,
                    nome_artistico,
                    data_de_nascimento,
                    data_de_falescimento,
                    foto,
                    biografia,
                    id_sexo
					) values (
					'Christopher Robert Evans',
                    'CHRIS EVANS',
					'1981-06-13',
                    null,
                    'https://br.web.img3.acsta.net/c_310_420/pictures/19/04/22/19/59/2129500.jpg',
                    'Depois de uma infância e estudos ​​em Boston, Chris Evans decidiu ir para Nova York para tentar a sorte na comédia. Ele rapidamente consegue entrar na profissão, 
                    principalmente participando em séries de televisão (Boston Public). Sua carreira no cinema começou em 2001, em uma comédia para adolescentes (Não é Mais um Besteirol Americano). Mas sem ficar preso a apenas um gênero de filme, o ator vai para outras produções: trapaceia nas provas com Scarlett Johansson na comédia policial Nota Máxima (2004), 
                    interpreta o papel de Kim Basinger no thriller Celular - Um Grito de Socorro (2004) e seduz Jessica Biel em London (2005).',
                    '1'
                    );
                    
