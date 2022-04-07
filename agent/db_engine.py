from customer_variables import collect_variables
def engine(engine):
    if engine =="1":
        engine = "postgres"
        version = "13.4"
        tf_engine = "db_engine = "+ '"{}"'.format(engine)
        tf_engine_version ="db_engine_version = " + '"{}"'.format(version)
        collect_variables(tf_engine_version,tf_engine)
    if engine =="2":
        engine = "MariaDB"
        version = "10.5.13"
        tf_engine = "db_engine = "+ '"{}"'.format(engine)
        tf_engine_version = "db_engine_version = " + '"{}"'.format(version)
        collect_variables(tf_engine_version,tf_engine)