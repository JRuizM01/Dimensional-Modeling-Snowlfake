# Dimensional-Modeling-Snowlfake
Transformed a business database from a transactional database towards a data warehouse using Snowflake

**CONTEXT:**
The Jensen company is a distributor of foods around the world. They need to restructure their whole database system. To do so, I redesigned, recreated, and repopulated a data warehouse given their current database management system.
  - You can see their current database format in the **OldJensenCoDB** image (OldJensenCoDB.png)
  - You can also download **OldJensenCoDB database**, which is made of a 8-table transactional database. It is a Microsoft Access file type (JensenCo DB.accdb).

**GOAL:**
By the end of this project, the new data warehouse for Jensen Co. will be populated. As a data engineer, my job is to improve their business process and make their database more efficient and easier to use.
I will update their transactional database system and implement three start schemas, one for each business process that they would like to track:
1. Customer placing order 
2. The inventory tracking process
3. The ordering of supplies from the supplier process

These three start schemas will then be put together into one data warehouse.
The purpose will also be to move their database tool from Microsoft Access to Snowflake.


**MILESTONES:**
- Identified the necessary tables needed for the star schema of each process (See Business Matrix)
