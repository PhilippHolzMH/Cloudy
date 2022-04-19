from customer_variables import write_into_tfvars
def get_db_engine(engine):
    if engine =="1":
        engine = "postgres"
        version = "13.4"
        tf_engine = "db_engine = "+ '"{}"'.format(engine)
        tf_engine_version ="db_engine_version = " + '"{}"'.format(version)
        write_into_tfvars(tf_engine_version,tf_engine)
    if engine =="2":
        engine = "MariaDB"
        version = "10.5.13"
        tf_engine = "db_engine = "+ '"{}"'.format(engine)
        tf_engine_version = "db_engine_version = " + '"{}"'.format(version)
        write_into_tfvars(tf_engine_version,tf_engine)