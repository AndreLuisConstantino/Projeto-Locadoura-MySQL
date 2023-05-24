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

#Podemos criar nomenclaturas virtuais
#Podemos criar nomenclaturas virtuais
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

alter table tbl_filme 
	add column valor_unitario float;
    
#update tbl_filme set valor_unitario = 43.50 where id = 1;
#update tbl_filme set valor_unitario = 30.10 where id = 3;
#update tbl_filme set valor_unitario = 50.10 where id = 4;
#update tbl_filme set valor_unitario = 60.00 where id = 5;

#Retorna o menor valor
select min(valor_unitario) as minimo from tbl_filme;
#Retorna o maior valor
select max(valor_unitario) as maximo from tbl_filme;
# AVG - Retorna a média de valores e ROUND realiza o arredondamento e limitação das casas decimais
select round(avg(valor_unitario), 2) as media from tbl_filme;
#Retorna a soma dos valores
select round(sum(valor_unitario), 2) as total from tbl_filme;

select tbl_filme.nome, tbl_filme.foto_capa, 
		concat('R$ ', tbl_filme.valor_unitario) as valor_unitario,
		concat('R$ ', round((tbl_filme.valor_unitario - ((tbl_filme.valor_unitario * 10)/100)),2)) as valor_desconto
from tbl_filme;

#OPERADORES DE COMPARAÇÃO
# =					Igualdade
# <					Menor
# >					Maior
# <=				Menor ou igual
# >=				Maior ou igual
# <> ou !=			Diferente
# like 
# is

#OPERADORES LÓGICOS
#and
#or
#not

select tbl_filme.nome, tbl_filme.foto_capa, tbl_filme.valor_unitario
from tbl_filme
where tbl_filme.valor_unitario < 40;

select tbl_filme.nome, tbl_filme.foto_capa, tbl_filme.valor_unitario
from tbl_filme
where tbl_filme.valor_unitario <= 40;

select tbl_filme.nome, tbl_filme.foto_capa, tbl_filme.valor_unitario
from tbl_filme
where tbl_filme.valor_unitario > 40;

select tbl_filme.nome, tbl_filme.foto_capa, tbl_filme.valor_unitario
from tbl_filme
where tbl_filme.valor_unitario >= 40
order by tbl_filme.valor_unitario;

#Utilizando operadores lógicos
select tbl_filme.nome, tbl_filme.foto_capa, tbl_filme.valor_unitario
from tbl_filme
where tbl_filme.valor_unitario <> 40 and tbl_filme.valor_unitario is not null;

#is null - retorna todos os registros nulos
#is not null - retorna todos os registros que não são nulos
select * from tbl_filme where tbl_filme.valor_unitario is not null;

select tbl_filme.nome, tbl_filme.foto_capa, tbl_filme.valor_unitario
from tbl_filme
where tbl_filme.valor_unitario >= 40 and tbl_filme.valor_unitario <= 50;

#between - retorna registros com um range de valores
select tbl_filme.nome, tbl_filme.foto_capa, tbl_filme.valor_unitario
from tbl_filme
where tbl_filme.valor_unitario between 40 and 50;


select tbl_filme.nome, tbl_filme.foto_capa, tbl_filme.valor_unitario
from tbl_filme
where tbl_filme.valor_unitario not between 40 and 50;

#LIKE
select * from tbl_filme where tbl_filme.nome like 'leão'; #Retorna somente a igualdade
select * from tbl_filme where tbl_filme.nome like 'leão%'; #Retorna o que inicia com a palavra chave
select * from tbl_filme where tbl_filme.nome like '%leão'; #Retorna o que termina com a palavra chave
select * from tbl_filme where tbl_filme.nome like '%leão%'; #Retorna por qualquer parte da busca

###FORMATANDO DATA E HORA

#Retorna a data atual do servidor
select curdate() as data_atual;
select current_date() as data_atual;

#Retorna a hora atual do servidor
select curtime() as hora_atual;
select current_time() as hora_atual;

#Retorna a data e a hora atual do servidor
select current_timestamp() as data_hora_atual;

#Formatando a hora
select time_format(curtime(), '%H')  as hora_formatada; #Retorna somente a hora (00 a 23)
select time_format(curtime(), '%h')  as hora_formatada; #Retorna somente a hora (00 a 12)
select time_format(curtime(), '%i')  as hora_formatada; #Retorna somente o minuto
select time_format(curtime(), '%s')  as hora_formatada; #Retorna somente o segundo
select time_format(curtime(), '%H:%i')  as hora_formatada; #Retorna hora e minuto
select time_format(curtime(), '%r')  as hora_formatada; #Retorna no padrão (AM / PM)

#Funções (hour, minute, second)
select hour(curtime()) as hora_formatada;
select minute(curtime()) as hora_formatada;
select second(curtime()) as hora_formatada;

#Formatando Data
select date_format(curdate(), '%d') as data_formatada;		#Retorna o dia
select date_format(curdate(), '%m') as data_formatada;		#Retorna o mês em numeral
select date_format(curdate(), '%M') as data_formatada;		#Retorna o mês por extenso
select date_format('2020-05-10', '%b') as data_formatada;	#Retorna o mês abreviado
select date_format('2020-04-10', '%M') as data_formatada;	#Retorna o mês por extenso
select date_format(curdate(), '%y') as data_formatada;		#Retorna o ano com 2 digitos
select date_format(curdate(), '%Y') as data_formatada;		#Retorna o ano com 4 digitos
select date_format(curdate(), '%w') as data_formatada;		#Retorna o numeral do dia da semana
select date_format(curdate(), '%#') as data_formatada;		#Retorna o nome do dia da semana

select day(curdate()) as data_formatada;			#Retorna o dia
select month(curdate()) as data_formatada;			#Retorna o mês
select year(curdate()) as data_formatada;			#Retorna o ano
select dayname(curdate()) as data_formatada;		#Retorna  o dia por extenso
select dayofmonth(curdate()) as data_formatada;		#Retorna o dia do mês
select dayofyear(curdate()) as data_formatada;		#Retorna o dia do ano
select dayofweek(curdate()) as data_formatada;		#Retorna o dia em numeral da semana
select monthname(curdate()) as data_formatada;		#Retorna o nome do mês
select yearweek(curdate()) as data_formatada;		#Retorna o ano e a semana
select weekofyear(curdate()) as data_formatada;		#Retorna apenas a semana do ano




select concat(day(curdate()), '/', month(curdate()), '/', year(curdate())) as data_formatada;
select date_format(curdate(), '%d/%m/%Y') as data_brasil;
select date_format(curdate(), '%Y/%m/%d') as data_brasil;

#Diferenças de datas
select datediff('2023-05-24', '2023-05-01') as quantidades_de_dias,
		(datediff('2023-05-24', '2023-05-01') * 5) as valor_pagar;

#Diferença de horas
select timediff('16:15:00', '10:05:00') as quantidades_de_horas,
		hour((timediff('16:15:00', '10:05:00') * 5)) as valor_pagar;


select addtime('06:00:00', '01:00:00');

#Criptografia de dados #

select 'senai' as dados,
	md5('eu to sas') as dados,
	sha('eu to sas') as dados,
	sha2('eu to sas', 256) as dados;


