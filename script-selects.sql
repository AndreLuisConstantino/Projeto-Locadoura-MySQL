show tables;

#select
	#select - serve para especificar quais colunas serão exibidas
    #from - serve para definir qual(is) tabelas serão utilizadas
    #where - serve para definir o critperio de busca

use db_videolocadora_tarde_20231;

#Retorna todas as colunas de uma tabela e todos os registros
select * from tbl_filme;
select tbl_filme.* from tbl_filme;

#Retorna as colunas específicadas
select id, nome, nome_original from tbl_filme;use db_videolocadora_tarde_20231;
select tbl_filme.id, tbl_filme.nome, tbl_filme.nome_original from tbl_filme;use db_videolocadora_tarde_20231;

#Podemos criar nomenclaturas virtuais1 
#para as colunas e tabelas (isso não altera fisicamente a tabela)
select tbl_filme.id as id_filme,
		tbl_filme.nome as nome_filme,
		tbl_filme.nome_original
from tbl_filme;

#Permite ordenar de forma crescente e descrescente
select * from tbl_filme order by nome asc;  #crescente
select * from tbl_filme order by nome, data_lancamento desc; #descrescente
select * from tbl_filme order by nome desc, sinopse asc;

#Limitar a quantidade de registros que serão exibidos
select * from tbl_filme limit 2;

#ucase ou upper - padroniza o resultado dos dados em maiúsculo
#lcase ou lower - padroniza o resultado dos dados em minúsculo
#length -  retorna a quantidade de caracteres
#concat - permite concatenar strings
#substr - permite cortar strings
select filme.nome as nome_filme_original,
		ucase(filme.nome) as nome,
		lcase(filme.nome_original) as nome_original,
        length(filme.nome) as quantidade_caracteres,
        concat('Filme: ',filme.nome) as nome_filme_formatado,
        concat('<span>Filme: ',filme.nome, '</span>') as nome_filme_tag,
        filme.sinopse,
        concat(substr(filme.sinopse, 1, 50), '.. Leia mais') as sinopse_reduzida
 from tbl_filme as filme;

desc tbl_filme;