-- Qno.1: Write a query to fetch all columns from the vendors table.
SELECT *  -- retrieve all the columns from the vendor table
FROM vendors
ORDER BY vendor_id;

-- Qno.2: Write a query to fetch the vendor_name, vendor_phone, and vendor_city from the vendors table for vendors 
-- located in the state of 'CA'. Output Columns: vendor_name, vendor_phone, vendor_city. Order By: vendor_name
SELECT vendor_name, vendor_city, vendor_phone 
FROM vendors
WHERE vendor_state = 'CA'  -- fetching only if the vendor state matches
ORDER BY vendor_name;

-- Qno.3: Write a query to fetch the invoice_id, invoice_total, and invoice_date from the invoices table, sorted by invoice_total 
-- in descending order. Output Columns: invoice_id, invoice_total, invoice_date.
SELECT invoice_id, invoice_total, invoice_date
FROM invoices
ORDER BY invoice_total DESC;    -- ordering the result in descending order with DESC

-- Qno.4: Limiting Results: Write a query to fetch the invoices with the 3rd to 9th lowest invoice_total from the invoices table.
-- Output Columns: invoice_id, invoice_total. Order By: invoice_total
SELECT invoice_id, invoice_total
FROM invoices
ORDER BY invoice_total 
LIMIT 2, 7; -- fetching 7 rows starting from the 3rd row

--  Qno.5: Write a query to fetch the invoice_id, invoice_total, and the remaining balance (calculated as invoice_total - payment_total) 
-- for all invoices in the invoices table. Output Columns: invoice_id, invoice_total, Remaining Balance. Order By: invoice_id
SELECT invoice_id, invoice_total, invoice_total - payment_total AS remaining_balance
FROM invoices
ORDER BY invoice_id;

-- FETCHING DATA FROM MULTIPLE TABLES
-- Qno.6: Write a query to fetch the invoice_id, invoice_total, vendor_name, and vendor_phone for all invoices. Use an inner join 
-- between the invoices and vendors tables. Output Columns: invoice_id, invoice_total, vendor_name, vendor_phone. Order By: Invoice_id
SELECT  -- Select all the columns we want to retrieve
    i.invoice_id,
    i.invoice_total,
    v.vendor_name,
    v.vendor_phone
FROM 
    invoices i
-- Join the invoices table with the vendors table based on the vendor_id
INNER JOIN 
    vendors v ON i.vendor_id = v.vendor_id
ORDER BY
	i.invoice_id;
    
-- Qno.7: Outer Join: Write a query to fetch all vendor_name values along with the invoice_id. Include vendors who do not have any invoices.
SELECT v.vendor_name, i.invoice_id
FROM vendors v
-- Join the vendors table with the invoices table based on the vendor_id
LEFT OUTER JOIN invoices i ON v.vendor_id = i.vendor_id -- LEFT OUTER JOIN ensures that all vendors are included in the result,  
														-- even if they do not have any corresponding invoices
ORDER BY v.vendor_name;

-- Qno.8:  Using the ex database; write a query to fetch all department_name values along with the employees last_name for each department.
-- Include employees that do not have a matching department.
SELECT 
	d.department_name, 
    e.last_name AS employee_last_name
FROM 
	departments d
-- Join the departments table with the employees table based on the department_number
LEFT OUTER JOIN 
	employees e ON d.department_number = e.department_number
-- Order the results by the department names
ORDER BY 
	d.department_name;

-- Qno.9 Using CONCAT Write a query to fetch a single column combining the first_name and last_name (formatted as "FirstName LastName") 
-- along with their vendor_name. Use the vendor_contacts and vendors tables.
SELECT 
    CONCAT(vc.first_name, ' ', vc.last_name) AS combined_contact_name,
    v.vendor_name
FROM 
    vendor_contacts vc
INNER JOIN 
    vendors v ON vc.vendor_id = vendors.vendor_id
ORDER BY
	combined_contact_name;

-- Qno.10 Union: using the ex database; Write a query to fetch all unique first_name values from both the employees and sales_reps tables.
SELECT first_name
FROM employees
UNION
SELECT rep_first_name
FROM sales_reps
ORDER BY first_name;

-- Qno.11: Complex Query with Multiple Joins Write a query to fetch the invoice_id, invoice_total, vendor_name, and terms_description for 
-- all invoices. Use appropriate joins between the invoices, vendors, and terms tables.
SELECT 
    i.invoice_id,
    i.invoice_total,
    v.vendor_name,
    t.terms_description
FROM 
    invoices i
-- Join the invoices table with the vendors table based on the vendor_id
INNER JOIN 
    vendors v ON i.vendor_id = v.vendor_id
-- Join the invoices table with the terms table based on the terms_id
INNER JOIN 
    terms t ON i.terms_id = t.terms_id
ORDER BY 
    i.invoice_id;
