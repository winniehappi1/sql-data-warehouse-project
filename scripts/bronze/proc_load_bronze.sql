/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

USE DataWarehouse;
GO

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    BEGIN TRY
        
        PRINT '--------------------------------------';
        PRINT 'Loading Bronze Layer';
        PRINT '--------------------------------------';

        PRINT '--------------------------------------';
        PRINT 'Loading CRM Tables';
        PRINT '--------------------------------------';


        PRINT '>> Truncating Table: bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT '>>Inserting. Data Into: bronze.crm_cust_info';
        BULK INSERT bronze.crm_cust_info
        FROM '/var/opt/mssql/cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\r\n',
            TABLOCK
        );


        PRINT '>> Truncating Table: bronze.crm_sales_details ';
        TRUNCATE TABLE bronze.crm_sales_details;

        PRINT '>>Inserting. Data Into: bronze.crm_sales_details ';
        BULK INSERT bronze.crm_sales_details
        FROM '/var/opt/mssql/sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );


        PRINT '>> Truncating Table: bronze.crm_prd_info ';
        TRUNCATE TABLE bronze.crm_prd_info;

        PRINT '>>Inserting. Data Into: bronze.crm_prd_info ';   
        BULK INSERT bronze.crm_prd_info
        FROM '/var/opt/mssql/prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0A',
            TABLOCK
        );

        PRINT '--------------------------------------';
        PRINT 'Loading ERP Tables';
        PRINT '--------------------------------------';


        PRINT '>> Truncating Table: bronze.erp_cust_az12 ';
        TRUNCATE TABLE bronze.erp_cust_az12;

        PRINT '>>Inserting. Data Into: bronze.erp_cust_az12';
        BULK INSERT bronze.erp_cust_az12
        FROM '/var/opt/mssql/cust_az12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0A',
            TABLOCK
        );



        PRINT '>> Truncating Table: bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101;

        PRINT '>>Inserting. Data Into: bronze.erp_loc_a101';
        BULK INSERT bronze.erp_loc_a101
        FROM '/var/opt/mssql/loc_a101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0A',
            TABLOCK
        );


        PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2 ';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        PRINT '>>Inserting. Data Into: bronze.erp_px_cat_g1v2 ';
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM '/var/opt/mssql/px_cat_g1v2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0A',
            TABLOCK
        );
    END TRY
    BEGIN CATCH
    
        PRINT 'Error Message' + ERROR_MESSAGE();
        PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);  

    END CATCH
END
