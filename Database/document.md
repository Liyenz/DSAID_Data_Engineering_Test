I attempted to do this section with first design the Postgres database tables based on the description given in the test.
I identified there is at least four main tables: <br>
*SalesPerson<br>
*Customer<br>
*Car<br>
*PurchaseOrder<br>
<br>

Based on the given information, I drafted the table structure. In a proper data modelling, I shall start with using the data modelling tool such as ERStudio to design the tables and set the keys and relationship.
I am unable to do so in this section because of limited time, therefore, I design the table structure directly in the Postgres database.
Usually, once we have the data model designed, we will able to see the table relationships, and we can generate the DDL of the create table statements.
This SQL statement allows us to create tables in the Postgres database.
<br>

In the Postgre database, I have a database called Postgres. I have created the tables with primary keys.
These tables have the foreign keys that take references of the tables ID columns. 
This ensures that the PurchaseOrder table has the correct input from the sales person with the car information and customer detail.
However, due to time constrainst, I am not able to finished up this portion before the due date, 22 June 2020, 12 noon.
I will continue to enhance it.
