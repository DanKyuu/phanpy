/*select * from rawdata limit 10;*/

/*
Produtos mais procurados
OBS: Entendemos que o touchproduct = 0 não é um produto.
*/
select
touchproduct
,count(1) qtdLinhas
from
rawdata
where
touchproduct <> 0
group by
touchproduct
order by 2 desc
limit 100;

select * from rawdata where touchproduct = 0;
