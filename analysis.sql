
1. Sprawdzenie liczby rekordów

select count(*)
from "superstore2.xlsx.csv";

2. Podgląd najważniejszych danych

select "Order ID",
  "Order Date",
  "Category",
  "Sales"
  "Profit"
from "superstore2.xlsx.csv";

3. Filtrowanie danych - kategoria Technology

select "Order ID",
  "Order Date",
  "Category",
  "Sales"
  "Profit"
from "superstore2.xlsx.csv"
where "Category" = 'Technology';

4. Identyfikacja transakcji przynoszących stratę

select "Order ID",
"Category",
  "Sales",
  cast(replace("Profit",',','.')as double)as "Profit"
from "superstore2.xlsx.csv"
where cast(replace("Profit",',','.')as double) < 0;

5. Liczba stratnych rekordów

select count(*) as "Liczba stratnych rekordów"
 from "superstore2.xlsx.csv"
where cast(replace("Profit",',','.')as double) < 0;

6. Łączna wartość strat

select sum(cast(replace("Profit",',','.')as double)) as "Łączny Profit"
 from "superstore2.xlsx.csv"
where cast(replace("Profit",',','.')as double) < 0;

7. Sprzedaż według kategorii

select "Category",
  sum(cast(replace("Sales",',','.')as double)) as "Total Sales"
 from "superstore2.xlsx.csv"
group by "Category";

8. Sprzedaż i zysk według kategorii

select "Category",
  sum(cast(replace("Sales",',','.')as double)) as "Total Sales",
  sum(cast(replace("Profit",',','.')as double)) as "Total Profit"
 from "superstore2.xlsx.csv"
group by "Category"
order by "Total Profit" desc;

9. Wysokie wartości sprzedaży w kategorii Technology

select "Order ID",
  "Category",
  "Sales",
  "Profit"
from "superstore2.xlsx.csv"
where "Category" = 'Technology'
and cast(replace("Sales",',','.') as double) > 1000;

10. Średnia wartość sprzedaży według kategorii

select "Category",
  avg(cast(replace("Sales",',','.') as double)) as "Average Sales"
from "superstore2.xlsx.csv"
group by "Category";

11. Klasyfikacja transakcji według wyniku

select "Order ID",
  "Category",
  "Profit",
  case
  when cast(replace("Profit",',','.') as double) > 0 then 'Zysk'
  when cast(replace("Profit",',','.') as double) < 0 then 'Strata'
  else 'Zero'
  end as "Typ wyniku"
from "superstore2.xlsx.csv";

12. Liczba transakcji według wyniku

select 
  case
  when cast(replace("Profit",',','.') as double) > 0 then 'Zysk'
  when cast(replace("Profit",',','.') as double) < 0 then 'Strata'
  else 'Zero'
  end as "Typ wyniku",
  count(*) as "Liczba rekordów"
from "superstore2.xlsx.csv"
group by "Typ wyniku";

13. Utworzenie tabeli z nazwami kategorii po polsku

create table category_info as
select 
  "Category",
  case
  when "Category" = 'Furnture' then 'Meble'
  when "Category" = 'Office Supplies' then 'Materiały biurowe'
  when "Category" = 'Technology' then 'Technologia'
  end as "Nazwa PL"
  from "superstore2.xlsx.csv"
group by "Category";

14. Sprzedaż według kategorii z polskimi nazwami

select 
  s."Category",
  c."Nazwa PL",
  sum(cast(replace(s."Sales",',','.')as double))as "Total Sales"
  from "superstore2.xlsx.csv" as s
join category_info as c
on s."Category" = c."Category"
group by s."Category", c."Nazwa PL"
order by "Total Sales" desc;


15.Sprzedaż, zysk i marża według kategorii

select 
  "Category",
  sum(cast(replace("Sales", ',', '.')as double)) as "Total Sales",
  sum(cast(replace("Profit", ',', '.')as double)) as "Total Profit",
  ROUND(
  sum(cast(replace("Profit", ',', '.')as double))
  / sum(cast(replace("Sales", ',', '.')as double)) * 100,
  2
  ) as "Profit Margin %"
from "superstore2.xlsx.csv"