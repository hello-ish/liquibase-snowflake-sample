# liquibase-snowflake-sample
Liquibase using maven for snowflake database

Liquibase (database change management tool) is an open-source solution for managing revisions of your database schema scripts. Developers define their desired database changes in various file formats to create, update or drop database objects rather than writing SQL directly against the database.

# How Liquibase Works!
The repositorty/org/liquibase contains the liquibase plugin dependencies to run liquibase using maven for snowflake db.

NB: You can define liquibase.properties file separately and define database credentials there but in my case I have defined it directly in POM.

You define all those missing environment variable in POM through export or through CI tools pipelines such as drone io, jenkins, etc.

Bruce who is the original author of https://github.com/bruce-szalwinski/liquibase-snowflake has just upgraded the liquibase version of plugin to support liquibase 3.8.5 which supports using environment variable in chagesets and runs smoothly. (Many thanks to him)

  - In the Liquibase world, a change is called a changeSet.
  - Each changeSet tag is uniquely identified by the combination of the “id” tag, the “author”   tag and the changelog file classpath.
  - Liquibase executes the databaseChangeLog, which is an XML file where changeSet files are     listed. It reads the changeSets in the same order these changes are mentioned in the         changelog.
  - Liquibase checks the databaseChangeLog table to see if the combination of id/author/         filepath has been run.
  - Liquibase will insert a new row with the id/author/filepath along with an md5sum of the      changeSet in the databaseChangeLog table.
  - Liquibase checks if a file was executed or not by using its [md5sum hash](https://searchsecurity.techtarget.com/definition/MD5). **Executed changes should not be                  touched, as this can mess up the schema version and tracking changes. To make a change in    the database, always create a new changeSet. If an old executing file is changed, then       the tool will fail to run.**

*Liquibase offers a rollback feature. This gives you the control to roll back but               didnt' work as expected but feel free to add and try. For rollback we came with approach described below.*


**ChangeSet**

ChangeSets are scripts used to manage the changes to our DB. ChangeSets files can be in various formats including XML, JSON, YAML and SQL. **Our case we are using SQL**.

**NB: Each ChangeSets need to be included into dbchangelog.xml for it to be reflected in the Snowflake database.**

# How to use Liquibase

   - Make your changes through sql scripts in sql folder, 
    
   - Add the changeSet to dbchangelog.xml as an example below:

         <changeSet id="001" author="test-user">
         <sqlFile encoding="utf8" path="sql/001-changeset-1.sql"/>
         </changeSet> 

Or if wanting to include rollback then below's an example using negate: make sure to include negate change of sql scripts before executing dbchangelog.

        <changeSet id="001-negate" author="test-user">
        <sqlFile encoding="utf8" path="sql/001-negate-changeset-1.sql"/>
        </changeSet> 


**Database ChangeLog File**

The root of all liquibase changes is the databaseChangeLog file. In our case it's dbchangelog.xml.

## Useful Info
[For more info](http://www.liquibase.org/documentation/databasechangelog.html)

[Liquibase FAQ](http://www.liquibase.org/faq.html)

[Liquibase Documentation](http://www.liquibase.org/documentation/)

Liquibase commands:

Update

     mvn install




References:

https://github.com/bruce-szalwinski/liquibase-snowflake

https://github.com/bruce-szalwinski/liquibase-snowflake-sample

https://dzone.com/articles/introduction-to-liquibase-and-managing-your-databa

https://www.smaato.com/blog/how-to-execute-database-migrations-with-liquibase/

https://hub.docker.com/_/maven


