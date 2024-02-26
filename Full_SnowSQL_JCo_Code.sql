---TABLE CREATION
use role sysadmin;

use warehouse compute_wh;

create or replace sequence customer_sequence start = 1 increment = 1;
create or replace table customer_dim (
c_customer_key number default customer_sequence.nextval,
c_customer_id varchar(),
c_company_name varchar(),
c_contact_name varchar(),
c_contact_title varchar(),
c_address varchar(),
c_city varchar(),
c_region varchar(),
c_postal_code varchar(),
c_country varchar(),
c_phone varchar(),
c_fax varchar(),
PRIMARY KEY (c_customer_key)
);

create or replace sequence employee_sequence start = 1 increment = 1;
create or replace table employee_dim (
e_employee_key number default employee_sequence.nextval,
e_employee_id int,
e_last_name varchar(),
e_first_name varchar(),
e_title varchar(),
e_title_of_courtesy varchar(),
e_birth_date varchar(),
e_hire_date varchar(),
e_address varchar(),
e_city varchar(),
e_region varchar(),
e_postal_code varchar(),
e_country varchar(),
e_home_phone varchar(),
e_extension varchar(),
e_notes varchar(),
e_reports_to varchar(),
PRIMARY KEY (e_employee_key)
);


create or replace sequence shipper_sequence start = 1 increment = 1;
create or replace table shipper_dim (
sh_shipper_key number default shipper_sequence.nextval,
sh_shipper_id int,
sh_company_name varchar(),
sh_phone varchar(),
PRIMARY KEY (sh_shipper_key)
);


create or replace sequence date_sequence start = 1 increment = 1;
create or replace table date_dim (
d_date_key number default date_sequence.nextval,
d_date_id varchar(),
d_day_of_month varchar(),
d_month varchar(),
d_year varchar(),
d_quarter varchar(),
d_day_of_week varchar(),
d_week_num varchar(),
PRIMARY KEY (d_date_key)
);

create or replace sequence warehouse_sequence start = 1 increment = 1;
create or replace table warehouse_dim (
w_warehouse_key number default warehouse_sequence.nextval,
w_warehouse_id int,
w_address varchar(),
w_state_region varchar(),
w_country varchar(),
w_manager varchar(),
PRIMARY KEY (w_warehouse_key)
);

create or replace sequence category_sequence start = 1 increment = 1;
create or replace table category_dim (
cat_category_key number default category_sequence.nextval,
cat_category_id int,
cat_category_name varchar(),
cat_description varchar(),
PRIMARY KEY (cat_category_key)
);

create or replace sequence product_sequence start = 1 increment = 1;
create or replace table product_dim (
p_product_key number default product_sequence.nextval,
p_product_id int,
p_product_name varchar(),
p_category_key int,
p_quantity_per_unit varchar(),
p_unit_price float,
PRIMARY KEY (p_product_key)
);

create or replace sequence outbound_order_fact_sequence start = 1 increment = 1;
create or replace table outbound_order_fact (
oo_outbound_order_key number default outbound_order_fact_sequence.nextval,
oo_customer_key int,
oo_shipper_key int,
oo_employee_key int,
oo_product_key int,
oo_warehouse_key int,
oo_freight float,
oo_order_date int,
oo_required_date int,
oo_ship_date int,
oo_ship_name varchar(),
oo_ship_address varchar(),
oo_ship_city varchar(),
oo_ship_region varchar(),
oo_ship_postal_code varchar(),
oo_ship_country varchar(),
PRIMARY KEY (oo_outbound_order_key)
);


create or replace sequence inbound_order_fact_sequence start = 1 increment = 1;
create or replace table inbound_order_fact (
io_inbound_order_key number default inbound_order_fact_sequence.nextval,
io_date_key varchar(),
io_product_key varchar (), 
io_warehouse_key varchar (),
io_supplier_key varchar (),
io_unit_price float,
io_quantity float,
io_discount float,
PRIMARY KEY (io_inbound_order_key)
);

create or replace sequence inventory_sequence start = 1 increment = 1;
create or replace table inventory_fact (
i_inventory_key number default inventory_sequence.nextval,
i_date_key int,
i_product_key int,
i_supplier_key int,
i_warehouse_key int,
i_units_in_stock int,
i_units_on_order int,
i_reorder_level int,
i_discontinued boolean,
PRIMARY KEY (i_inventory_key)
);

create or replace sequence supplier_sequence start = 1 increment = 1;
create or replace table supplier_dim (
s_supplier_key number default supplier_sequence.nextval,
s_supplier_id int,
s_company_name varchar(),
s_contact_name varchar(),
s_contact_title varchar(),
s_address varchar(),
s_city varchar(),
s_region varchar(),
s_postal_code varchar(),
s_country varchar(),
s_phone varchar(),
s_fax varchar(),
s_home_page varchar(),
PRIMARY KEY (s_supplier_key)
);

---DATA STAGE
-- Use role sysadmin. 
use role sysadmin;

-- Use warehouse compute_wh.
use warehouse compute_wh;

-- Create or replace a database named demo_db.
use database jenson_db;


--Create a stage to load the data into. 
create or replace stage categories_stage;
create or replace stage customers_stage;
create or replace stage employees_stage;
create or replace stage order_details_stage;
create or replace stage orders_stage;
create or replace stage products_stage;
create or replace stage shippers_stage;
create or replace stage suppliers_stage;

--Create a file format to load the data into the stage from a .csv file using SnowSQL.
create or replace file format jenson_db.public.csv_file_format
type = 'csv'
compression = 'auto'
field_delimiter = ','
record_delimiter = '\n'
skip_header = 1
field_optionally_enclosed_by = '\042'
trim_space = false
error_on_column_count_mismatch = true
escape = '\134'
escape_unenclosed_field = '\134'
date_format = 'auto'
timestamp_format = 'auto'
null_if = ('\\n');

--Navigated to snowsql and put the file into the stage.
--put file://C:\Users\Owner\Downloads\final_project\%name%.csv @%name%_stage;

-- Create Raw tables
create or replace table customers_raw (
customerid string,
company_name string,
contact_name string,
contact_title string,
address string,
city string,
region string,
postal_code string,
country string,
phone string,
fax string
);

create or replace table employees_raw (
employeeid Integer,
last_name string,
first_name string,
title string,
title_of_courtesy string,
birth_date string,
hire_date string,
address string,
city string,
region string,
postal_code string,
country string,
home_phone string,
extension string,
photo string,
notes string,
reports_to string
);


create or replace table shippers_raw (
shipperid string,
company_name string,
phone string
);

create or replace table products_raw (
productid int,
product_name string,
supplierid int,
categoryid string,
quantity_per_unit string,
unit_price float,
units_in_stock float,
units_on_order float,
reorder_level float,
discontinued boolean
);

create or replace table orders_raw (
orderid int,
customerid string,
employeeid int, 
order_date string, 
required_date string,
shipped_date string, 
ship_via string, 
freight string,
ship_name string,
ship_address string,
ship_city string,
ship_region string,
ship_postal_code string,
ship_country string
);

create or replace table order_details_raw (
orderid int,
productid int,
unit_price float,
quantity float,
discount float
);

create or replace table suppliers_raw (
supplierid int,
company_name string,
contact_name string,
contact_title string,
address string,
city string,
region string,
postal_code string,
country string,
phone string,
fax string,
home_page string
);

create or replace table categories_raw (
categoryid int,
category_name string,
description string,
picture string
);

-- 11. Now, load the data from the stage into the sales_ext table using the following code: 
copy into categories_raw from @categories_stage/categories.csv.gz 
file_format = (format_name = 'csv_file_format');

copy into customers_raw from @customers_stage/customers.csv.gz 
file_format = (format_name = 'csv_file_format');

copy into employees_raw from @employees_stage/employees.csv.gz 
file_format = (format_name = 'csv_file_format');

copy into order_details_raw from @order_details_stage/order_details.csv.gz 
file_format = (format_name = 'csv_file_format');

copy into orders_raw from @orders_stage/orders.csv.gz 
file_format = (format_name = 'csv_file_format');

copy into products_raw from @products_stage/products.csv.gz 
file_format = (format_name = 'csv_file_format');

copy into shippers_raw from @shippers_stage/shippers.csv.gz 
file_format = (format_name = 'csv_file_format');

copy into suppliers_raw from @suppliers_stage/suppliers.csv.gz 
file_format = (format_name = 'csv_file_format');


--- TABLE POPULATION
use database jenson_db;

use role accountadmin;

use warehouse compute_wh;


-- Populate customer dim
select count(*)
from customers_raw;

insert into customer_dim 
(C_CUSTOMER_ID, C_COMPANY_NAME, C_CONTACT_NAME, C_CONTACT_TITLE, C_ADDRESS, C_CITY, C_REGION, 
C_POSTAL_CODE, C_COUNTRY, C_PHONE, C_FAX)
select customerid, company_name, contact_name, contact_title,
address, city, region, postal_code, country, phone, fax
from customers_raw;


-- Populate Date dim
insert into date_dim
(D_DATE_ID, D_DAY_OF_MONTH, D_MONTH, D_YEAR, D_QUARTER, D_DAY_OF_WEEK, D_WEEK_NUM)
select distinct order_date, date_part(day, order_date::date), date_part(month, order_date::date), 
date_part(year, order_date::date), date_part(quarter, order_date::date), dayname(order_date::date), 
date_part(weekofyear, order_date::date)
from orders_raw;

insert into date_dim
(D_DATE_ID, D_DAY_OF_MONTH, D_MONTH, D_YEAR, D_QUARTER, D_DAY_OF_WEEK, D_WEEK_NUM)
select distinct shipped_date, date_part(day, shipped_date::date), date_part(month, shipped_date::date), 
date_part(year, shipped_date::date), date_part(quarter, shipped_date::date), dayname(shipped_date::date),
date_part(weekofyear, shipped_date::date)
from orders_raw o FULL OUTER JOIN date_dim d 
on d.d_date_id = o.shipped_date
where d.d_date_id is null and o.shipped_date is not null;

insert into date_dim
(D_DATE_ID, D_DAY_OF_MONTH, D_MONTH, D_YEAR, D_QUARTER, D_DAY_OF_WEEK, D_WEEK_NUM)
select distinct required_date, date_part(day, required_date::date), date_part(month, required_date::date), 
date_part(year, required_date::date), date_part(quarter, required_date::date), dayname(required_date::date), 
date_part(weekofyear, required_date::date)
from orders_raw o FULL OUTER JOIN date_dim d 
on d.d_date_id = o.required_date
where d.d_date_id is null and o.required_date is not null;


-- Populate Employee
select count(*)
from employees_raw;

insert into employee_dim
(E_EMPLOYEE_ID, E_LAST_NAME, E_FIRST_NAME, E_TITLE, E_TITLE_OF_COURTESY, E_BIRTH_DATE, E_HIRE_DATE, E_ADDRESS, E_CITY, E_REGION, E_POSTAL_CODE, E_COUNTRY, E_HOME_PHONE, E_EXTENSION, E_NOTES, E_REPORTS_TO)
select EMPLOYEEID, LAST_NAME, FIRST_NAME, TITLE, TITLE_OF_COURTESY, BIRTH_DATE, HIRE_DATE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, HOME_PHONE, EXTENSION, NOTES, REPORTS_TO
from employees_raw;


-- Populate Category
select count(*)
from categories_raw;

insert into category_dim 
(CAT_CATEGORY_ID, CAT_CATEGORY_NAME, CAT_DESCRIPTION)
select categoryid, category_name, description
from categories_raw;


-- Populate Product dim
select count(*)
from products_raw;

insert into product_dim
(P_PRODUCT_ID, P_PRODUCT_NAME, P_CATEGORY_KEY, P_QUANTITY_PER_UNIT, P_UNIT_PRICE)
select productid, product_name, cat_category_key, quantity_per_unit, unit_price
from products_raw p JOIN category_dim c
on p.categoryid = c.cat_category_id;


-- Populate shipper
select count(*)
from shippers_raw;

insert into shipper_dim
(SH_SHIPPER_ID, SH_COMPANY_NAME, SH_PHONE)
select shipperid, company_name, phone
from shippers_raw;


-- Populate Suppliers
select count(*)
from suppliers_raw;

insert into supplier_dim
(S_SUPPLIER_ID, S_COMPANY_NAME, S_CONTACT_NAME, S_CONTACT_TITLE, S_ADDRESS, S_CITY, S_REGION, S_POSTAL_CODE, S_COUNTRY, S_PHONE, S_FAX, S_HOME_PAGE)
select SUPPLIERID, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE, FAX, HOME_PAGE
from suppliers_raw;


-- Populate Inventory
insert into inventory_fact
(I_PRODUCT_KEY, I_SUPPLIER_KEY, I_UNITS_IN_STOCK, I_UNITS_ON_ORDER, I_REORDER_LEVEL, I_DISCONTINUED)
select p_product_key, s.s_supplier_key, pr.units_in_stock, pr.units_on_order, pr.reorder_level, pr.discontinued
from product_dim p join products_raw pr 
    on p.p_product_id = pr.productid
    join supplier_dim s 
        on s.s_supplier_id = pr.supplierid;

        
-- Populate inbound order
select count(*)
from order_details_raw;

insert into inbound_order_fact
(IO_PRODUCT_KEY, IO_SUPPLIER_KEY, IO_UNIT_PRICE, IO_QUANTITY, IO_DISCOUNT)
select p.p_product_key, s.s_supplier_key, od.unit_price, od.quantity, od.discount
from order_details_raw od join product_dim p
    on od.productid = p.p_product_id
    join products_raw pr
        on od.productid = pr.productid
        join supplier_dim s
            on pr.supplierid = s.s_supplier_id;


-- Populate Outbound orders
select count(*)
from orders_raw;

insert into outbound_order_fact
(OO_CUSTOMER_KEY, OO_SHIPPER_KEY, OO_EMPLOYEE_KEY, OO_PRODUCT_KEY, OO_FREIGHT, OO_ORDER_DATE, OO_REQUIRED_DATE, OO_SHIP_DATE, OO_SHIP_NAME, OO_SHIP_ADDRESS, OO_SHIP_CITY, OO_SHIP_REGION, OO_SHIP_POSTAL_CODE, OO_SHIP_COUNTRY)
with orderdate_cte as 
(select o.order_date, d.d_date_key
from orders_raw o join date_dim d
on o.order_date = d.d_date_id),

shipdate_cte as 
(select o.shipped_date, d.d_date_key
from orders_raw o join date_dim d
on o.shipped_date = d.d_date_id),

requireddate_cte as 
(select o.required_date, d.d_date_key
from orders_raw o join date_dim d
on o.required_date = d.d_date_id)

select distinct c.c_customer_key, s.sh_shipper_key, e.e_employee_key, p.p_product_key, replace(o.freight, ',',''), oc.d_date_key, rc.d_date_key, sc.d_date_key, o.ship_name, o.ship_address, o.ship_city, o.ship_region, o.ship_postal_code, o.ship_country
from orders_raw o join customer_dim c
    on o.customerid = c.c_customer_id
    join employee_dim e 
        on o.employeeid = e.e_employee_id
        join shipper_dim s 
            on o.ship_via = s.sh_shipper_id
            join order_details_raw od 
                on o.orderid = od.orderid
                join product_dim p 
                    on od.productid = p.p_product_id
                    join orderdate_cte oc
                        on o.order_date = oc.order_date
                        join shipdate_cte sc
                            on o.shipped_date = sc.shipped_date
                            join requireddate_cte rc
                                on o.required_date = rc.required_date;
