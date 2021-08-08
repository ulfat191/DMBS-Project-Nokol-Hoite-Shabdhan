create database Nokol_hoite_shabdhan
go

create table Government
(
   govt_reg_id nvarchar(50) not null primary key
   /*each company must have a govt_reg_id to operate in the market. */
)
create table Location
(
   country varchar(50) not null,
   city varchar(50) not null,
   area nvarchar(50) not null,
   house_no nvarchar(10) not null,
   flat_no nvarchar(10) not null,
   primary key (country, city, area, house_no, flat_no)
)
/*every company and store must have a location, and locations must be in particular places as set by the authority in this table*/
create table Material
(
   mat_id nvarchar(50) not null primary key,
   mat_name varchar(200) null,
   ingredients nvarchar(500) not null,
   pur_date date not null
)
create table Product
(
   prod_id nvarchar(50) not null primary key,
   govt_reg_num nvarchar(50) not null foreign key references [dbo].[Government],
   prod_name varchar(200) null,
   man_date date not null,
   exp_date date not null
)
create table Used
(
   mat_id nvarchar(50) not null foreign key references [dbo].[Material],
   prod_id nvarchar(50) not null foreign key references [dbo].[Product]
)

create table Company
(
   com_id nvarchar(50) not null primary key,
   govt_reg_num nvarchar(50) not null foreign key references [dbo].[Government],
   com_name varchar(200) not null, 
   con_num nvarchar(20) unique, 
   com_loc_country varchar(50) not null,
   com_loc_city varchar(50) not null,
   com_loc_area nvarchar(50) not null,
   com_loc_house_no nvarchar(10) not null,
   com_loc_flat_no nvarchar(10) not null,
   constraint company_fk1 foreign key (com_loc_country, com_loc_city, com_loc_area, com_loc_house_no, com_loc_flat_no) references [dbo].[Location],
)

create table Produces
(
   com_id nvarchar(50) not null foreign key references [dbo].[Company],
   prod_id nvarchar(50) not null foreign key references[dbo].[Product]
)

create table Stores
(
   store_id nvarchar(50) not null primary key,
   govt_reg_num nvarchar(50) not null foreign key references [dbo].[Government],
   sto_name varchar(200) not null, 
   sto_con_num nvarchar(20) unique, 
   sto_loc_country varchar(50) not null,
   sto_loc_city varchar(50) not null,
   sto_loc_area nvarchar(50) not null,
   sto_loc_house_no nvarchar(10) not null,
   sto_loc_flat_no nvarchar(10) not null,
   constraint store_fk1 foreign key (sto_loc_country,sto_loc_city, sto_loc_area, sto_loc_house_no, sto_loc_flat_no) references [dbo].[Location],
   com_id nvarchar(50) foreign key references [dbo].[Company],
   mat_id nvarchar(50) foreign key references [dbo].[Material]
)

insert into [dbo].[Government] values 
('COMp.1010.C_abx'),
('COMp.1020.C_odx'),
('COMp.1099.C_czy'),
('PROd.2011.P_gop'),
('PROd.2058.P_gcz'),
('PROd.3088.P_med'),
('STOr.5080.S_abc'),
('STOr.5059.S_txy')
/*Code starting with Comp means company code, prod is product code and stor is store code, 
stating whether a compnay is fit to produce, 
product is good to be consumed or store is hygienic enough to store */

insert into [dbo].[Location] values
('Bangladesh', 'Chattogram', 'Khatungonj', '342/Y-B', 'A01-10'),
('Singapore', 'Singapore', 'Redhill Forum', '418-78A', 'A1-A2'),
('Kuwait City', 'Kuwait', 'P.O.Box: 5092', '13051-B', 'B01-B10'),
('Italy', 'Baraggia', 'Varese', '112-X-A1', 'A11-A40'),
('Bangladesh', 'Dhaka', 'Narayangonj', '14/A-1', 'A11-D50'),
('Saudi Arabia', 'Jeddah', 'Jeddah Salama Dist.', '15/C-X', 'A31-A39')

insert into [dbo].[Material] values
('MAT_JEANS_A_34', 'JEANS', 'JEANS CLOTH X FABRIC', '2019-04-15'),
('MAT_APPLE_CIDER_A1', 'RAW LIQUID VINEGER', '5–8% acetic acid, ethanol. sugar', '2020-01-12'),
('MAT_HYDROCARBON_BODY_B07', 'FLAVORLESS MOISTURIZING HYDROCARBON', 'Petroleum jelly, petrolatum, white petrolatum, soft paraffin, or multi-hydrocarbon', '2021-01-01'),
('MAT_PLASTIC_G09', 'LOW MELTED PLASTIC', 'Polystyrene', '2020-08-07'),
('MAT_MEDICINE_NAS_DROP', 'NASAL DROP', 'Oxymetazoline HCL USP 0.02%', '2020-12-20')

insert into [dbo].[Product] values
('COM_1010_prod.C.514', 'PROd.2011.P_gop', 'Lip Ice', '2021-01-09', '2022-01-10'),
('COM_1020_prod.C.787', 'PROd.2058.P_gcz', 'Denim Jacket', '2019-05-01', '2023-05-02'),
('COM_1020_prod.F.001', 'PROd.3088.P_med', 'Afrin', '2020-12-25', '2022-12-24')
/*(Company with com 1010 id uses product. Every compnay can assign a product code of its own,
but it must be government registerd*/

insert into [dbo].[Used] values
('MAT_HYDROCARBON_BODY_B07', 'COM_1010_prod.C.514'),
('MAT_JEANS_A_34', 'COM_1020_prod.C.787'),
('MAT_MEDICINE_NAS_DROP', 'COM_1020_prod.F.001')

insert into [dbo].[Company] values
('COM_1010', 'COMp.1010.C_abx', 'Mojumdar Group of Industries', '01A188X5545', 'Saudi Arabia', 'Jeddah', 'Jeddah Salama Dist.', '15/C-X', 'A31-A39'),
('COM_1020', 'COMp.1020.C_odx', 'Moina Limited', '01B188Z8577', 'Bangladesh', 'Chattogram', 'Khatungonj', '342/Y-B', 'A01-10'),
('COM_1099', 'COMp.1099.C_czy', 'Mojumdar Group of Industries', null, 'Singapore', 'Singapore', 'Redhill Forum', '418-78A', 'A1-A2')

insert into [dbo].[Produces] values
('COM_1010', 'COM_1010_prod.C.514'),
('COM_1020', 'COM_1020_prod.F.001'),
('COM_1020', 'COM_1020_prod.C.787')



insert into [dbo].[Stores] values
('STO_AB1', 'STOr.5059.S_txy', 'Majuma Apparel Store', '01D188Y8P77', 'Bangladesh', 'Dhaka', 'Narayangonj', '14/A-1', 'A11-D50', 'COM_1020', 'MAT_JEANS_A_34'), 
('STO_MI6', 'STOr.5059.S_txy', 'Ibrahim Petroleum', '01Q188ZN877', 'Kuwait City', 'Kuwait', 'P.O.Box: 5092', '13051-B', 'B01-B10',  'COM_1010', 'MAT_HYDROCARBON_BODY_B07')

/*1. Find the Company names of all companies and remove duplicates*/
select distinct [com_name]from [dbo].[Company]

/*2. Find the Company names of all companies*/
select all [com_name] from [dbo].[Company]

/*3. Display all attributes from Company*/
select * from [dbo].[Company]

/*4. Select all the Company contact numbers and show the list of Contact number along with company name and city*/
select concat([com_name], ' ; Phone Number:', [con_num], ' in the city of ',  [com_loc_city]) 
as 'Company eith Contact and Address' from [dbo].[Company]

/*5. To find all stores located in Bangladesh*/
select [sto_name]
from [dbo].[Stores]
where [sto_loc_country] like 'Bangladesh'

/*6. Find names of all materials which were used to produce at least some products*/
select * from [dbo].[Material], [dbo].[Used]
where [dbo].[Material].[mat_id]=[dbo].[Used].[mat_id]

/*7. Find all products name and id that have 'lip' in its name*/
select [prod_name] as 'Winter Cosmetics for lips'
from [dbo].[Product]
where [prod_name] like '%lip%'

/*8. List in alphabetical order names of all products*/
select [prod_name]
from [dbo].[Product]
order by [prod_name]

/*9. Find companies that are in the Arab countries along with the name of the city*/
select [com_name] from [dbo].[Company] where [com_loc_country] like '%Arab%'
union
select [city] from [dbo].[Location] where [country] like '%Arab%'

/*10. Find all cities in country having companies of 'Bangla' without any city name starting with 'Nara'*/
select [city] from [dbo].[Location] where [country] like 'Bangla%'
except 
select [city] from [dbo].[Location] where [country] like 'Nara%'

/*11. Find the companies whose phone numbers are missing*/
select concat([com_name], ' ID:', [com_id], ' has a missing phone number') from [dbo].[Company]
where [con_num] is null

/*12. Count the total number of companies, materials, stores and products*/
select count([com_id]) as 'Number of Companies' from [dbo].[Company]
select count([mat_id]) as 'Number of Materials' from [dbo].[Material]
select count([prod_id]) as 'Number of Products' from [dbo].[Product]
select count([store_id]) as 'Number of Stores' from [dbo].[Stores]

/*13. Find the number of companies per country*/
select distinct [country], count([com_id]) 
from [dbo].[Location], [dbo].[Company]
where [dbo].[Location].[country]=[dbo].[Company].[com_loc_country]
group by [country]

/*14. Find the average number of companies between Bangladesh, Saudi Arabia and Singapore*/
select avg(comps)
from (select count([com_id]) as comps from [dbo].[Location], [dbo].[Company]
where [dbo].[Location].[country]=[dbo].[Company].[com_loc_country]
group by [country]) as t

/*15. Find the number of location the govt brings product from outside of Bangladesh*/
select distinct [country] as 'Export Zones' from [dbo].[Location]
where [country] not in ('Bangladesh')

/*16. Find all the companies that produce more than 1 product*/
select [com_name] from [dbo].[Company]
where [dbo].[Company].[com_id] in 
(select [dbo].[Company].[com_id] from [dbo].[Company], [dbo].[Produces]
where [dbo].[Company].[com_id]=[dbo].[Produces].[com_id]
group by [dbo].[Company].[com_id]
having count([prod_id])>1)

/*17. Provide a readable format including the company id, company name and the products it is producing currently*/
SELECT [dbo].[Company].[com_id], [com_name], [prod_name]
FROM [dbo].[Company], [dbo].[Product], [dbo].[Produces]
WHERE  [dbo].[Company].[com_id]= [dbo].[Produces].[com_id] 
and [dbo].[Product].[prod_id] = [dbo].[Produces].[prod_id]
ORDER BY [com_name], [prod_name]

select * from [dbo].[Government]
select * from [dbo].[Location]
select * from [dbo].[Material]
select * from [dbo].[Product]
select * from [dbo].[Used]
select * from [dbo].[Company]
select * from [dbo].[Produces]
select * from [dbo].[Stores]