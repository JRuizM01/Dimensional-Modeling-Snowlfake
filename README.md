# Dimensional-Modeling-Snowlfake
Transformed a business database from a transactional database towards a data warehouse using Snowflake

**CONTEXT:**
The Jensen company is a distributor of foods around the world. They need to restructure their whole database system. To do so, I redesigned, recreated, and repopulated a data warehouse given their current database management system.
  - You can see their current database format in the **OldJensenCoDB** image (OldJensenCoDB.png)
  - You can also download **OldJensenCoDB database**, which is made of a 8-table transactional database. It is a Microsoft Access file type (JensenCo DB.accdb).

**GOAL:**
By the end of this project, the new data warehouse for Jensen Co. will be populated. As a data engineer, my job is to improve their business process and make their database more efficient and easier to use.
I will update their transactional database system and implement three start schemas, one for each business process that they would like to track:
1. Customer placing order (Inbound Order)
2. The inventory tracking process (Inventory)
3. The ordering of supplies from the supplier process (Outbound Order)

These three start schemas will then be put together into one data warehouse.
The purpose will also be to move their database tool from Microsoft Access to Snowflake.


**MILESTONES:**
- Identified the necessary tables needed for the star schema of each process (See Business Matrix --> Business Matrix JensenCo.png)
- Created a star schema ERD through LucidChart for each business process:
      - You can see each ERDs (in png format) for Inbound Order, Outbound Order, and Inventory
- Put all the new star-schema ERDs together to form a snowflake-shaped common ERD (see NewSnowflakeERDJCo.png)
    **SNOWFLAKE CODE (SnowSQL):** (See Full_SnowSQL_JCo_/C
ode)
1. Created all the new tables, facts, and dimensions that' would be useful for the new JensonCo data warehouse
   - Set all the table names and table relationships (PK, FK) according to the ERD
   - Set all the field names and data types
   - Important: defined the tables so that when new data was added, the PKs and FKs would react accordingly and with no issue
2. Imported all the data from the Microsoft Access old JensonCo database
   - Created raw empty tables with the corresponding data types
   - Copied the csv files into the Snowflake raw empty tables
3. Populated the new JensonCo data warehouse with the copied imported tables
   - Used INSERT INTO commands
4. Now that the data is fully operational, it can be used for data analysis, and other data inputs
  
