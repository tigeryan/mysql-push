<cfquery name="getData" datasource="#application.datasource#">
    SELECT *
    FROM products
    ORDER BY product_id
</cfquery>


<cfdump var="#getData#">
