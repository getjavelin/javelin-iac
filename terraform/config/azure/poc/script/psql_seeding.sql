-- -- * PGPASSWORD=<PASSWORD> psql --set=sslmode=disable -h <Host> -p <Port> -U <Username> -d <Database> -f <Sql_Script>
-- -- *
-- -- * Create PostgreSQL users
-- -- *
-- -- * 

-- DO $$
-- BEGIN
--    IF EXISTS (
--       SELECT FROM pg_catalog.pg_user
--       WHERE  usename = 'javelin_customers') THEN

--       RAISE NOTICE 'Skipping : User "javelin_customers" already exists';
--    ELSE
--       CREATE USER javelin_customers LOGIN PASSWORD '${javelin_customers_password}';
--    END IF;
-- END $$;


-- DO $$
-- BEGIN
--    IF EXISTS (
--       SELECT FROM pg_catalog.pg_user
--       WHERE  usename = 'javelin_admins') THEN

--       RAISE NOTICE 'Skipping : User "javelin_admins" already exists';
--    ELSE
--       CREATE USER javelin_admins LOGIN PASSWORD '${javelin_admin_password}';
--    END IF;
-- END $$;


-- -- *
-- -- *
-- -- * Create PostgreSQL roles
-- -- *
-- -- *
-- DO $$
-- BEGIN
--    IF EXISTS (
--       SELECT FROM pg_catalog.pg_roles
--       WHERE  rolname = 'customer_admin') THEN

--       RAISE NOTICE 'Skipping : Role "customer_admin" already exists';
--    ELSE
--       CREATE ROLE customer_admin;
--    END IF;
-- END $$;


-- DO $$
-- BEGIN
--    IF EXISTS (
--       SELECT FROM pg_catalog.pg_roles
--       WHERE  rolname = 'customer_member') THEN

--       RAISE NOTICE 'Skipping : Role "customer_member" already exists';
--    ELSE
--       CREATE ROLE customer_member;
--    END IF;
-- END $$;


-- DO $$
-- BEGIN
--    IF EXISTS (
--       SELECT FROM pg_catalog.pg_roles
--       WHERE  rolname = 'admin_super') THEN

--       RAISE NOTICE 'Skipping : Role "admin_super" already exists';
--    ELSE
--       CREATE ROLE admin_super;
--    END IF;
-- END $$;


-- -- *
-- -- *
-- -- * Grant roles to users
-- -- *
-- -- *
-- GRANT customer_admin TO javelin_customers;
-- -- GRANT customer_member TO javelin_customers;
-- GRANT admin_super TO javelin_admins;

-- -- * Grant privileges to customer_admin role
-- GRANT CREATE ON SCHEMA public TO customer_admin;
-- GRANT USAGE ON SCHEMA public TO customer_admin;
-- GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO customer_admin;
-- ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT USAGE, SELECT ON SEQUENCES TO customer_admin;
-- ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO customer_admin;

-- -- * Grant privileges to customer_member role, update role as necessary
-- GRANT CREATE ON SCHEMA public TO customer_member;
-- GRANT USAGE ON SCHEMA public TO customer_member;
-- GRANT SELECT ON ALL TABLES IN SCHEMA public TO customer_member;
-- ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT USAGE, SELECT ON SEQUENCES TO customer_member;
-- ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO customer_member;

-- -- * Grant all privileges to admin_super role
-- GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin_super;
-- ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO admin_super;
-- ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON SEQUENCES TO admin_super;
-- ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON FUNCTIONS TO admin_super;

-- -- *
-- -- *
-- -- * Create policies for row level security
-- -- *
-- -- *
-- DO $$
-- DECLARE
--     table_record RECORD;
-- BEGIN
--     FOR table_record IN SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'
--     LOOP
--         BEGIN
--             EXECUTE format(
--                 'CREATE POLICY tenant_access_policy ON %I.%I ' ||
--                 'FOR ALL TO customer_admin ' ||
--                 'USING (account_id = current_setting(''javelin.account_id'') AND gateway_id = current_setting(''javelin.gateway_id''));',
--                 'public', table_record.table_name
--             );
--         EXCEPTION WHEN others THEN
--             RAISE NOTICE 'Skipping : tenant_access_policy already exists on %', table_record.table_name;
--         END;
--     END LOOP;
-- END $$;

-- DO $$
-- DECLARE
--     table_record RECORD;
-- BEGIN
--     FOR table_record IN SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'
--     LOOP
--         BEGIN
--             EXECUTE format(
--                 'CREATE POLICY member_access_policy ON %I.%I ' ||
--                 'FOR ALL TO customer_member ' ||
--                 'USING (account_id = current_setting(''javelin.account_id'') AND gateway_id = current_setting(''javelin.gateway_id''));',
--                 'public', table_record.table_name
--             );
--         EXCEPTION WHEN others THEN
--             RAISE NOTICE 'Skipping : member_access_policy already exists on %', table_record.table_name;
--         END;
--     END LOOP;
-- END $$;

-- DO $$
-- DECLARE
--     table_record RECORD;
-- BEGIN
--     FOR table_record IN SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'
--     LOOP
--       BEGIN
--         EXECUTE format(
--             'CREATE POLICY admin_access_policy ON %I.%I ' ||
--             'FOR ALL TO admin_super ' ||  -- Add other admin roles if necessary
--             'USING (true);',
--             'public', table_record.table_name
--         );
--       EXCEPTION WHEN others THEN
--          RAISE NOTICE 'Skipping : admin_access_policy already exists on %', table_record.table_name;
--       END;
--     END LOOP;
-- END $$;


-- -- *
-- -- *
-- -- * Enable Row Level Security on tables
-- -- *
-- -- *
-- DO $$
-- DECLARE
--     table_record RECORD;
-- BEGIN
--     FOR table_record IN SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'
--     LOOP
--         EXECUTE format('ALTER TABLE %I.%I ENABLE ROW LEVEL SECURITY', 'public', table_record.table_name);
--     END LOOP;
-- END $$;

-- DO $$
-- DECLARE
--     table_record RECORD;
-- BEGIN
--     FOR table_record IN SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'
--     LOOP
--         EXECUTE format('ALTER TABLE %I.%I OWNER TO javelin_customers;', 'public', table_record.table_name);
--     END LOOP;
-- END $$;