-- you can also use env variable in changeset as below or as you like in changesets

CREATE FILE FORMAT "${SNOWFLAKE_DB}"."${SNOWFLAKE_SCHEMA}"."sample_test_CSV_FF"
    TYPE = CSV
    COMPRESSION = AUTO;
