import os

def output_rds(uploadurl,db_name,db_region):
    estimated_cost = str(os.system("aws ce get-cost-and-usage --time-period Start=2022-04-21,End=2022-05-01 --granularity=MONTHLY  --metrics BlendedCost --query ResultsByTime[].Total.BlendedCost.[Amount] --output text"))
    print("/////////////////////////// Your Infrastructure ///////////////////////////////")
    print("///")
    print("/// ________________________________________________________________________")
    print("/// |                                                                      |")
    print("/// |  [S3-Bucket]                                                         |")
    print("/// |     ______________________[Internet-Gateway]__________________       |")
    print("/// |    |                                    |                     |      |")
    print("/// |    |                                    |                     |      |")
    print("/// |    |   _____Pub-VPC____          _______|_________            |      |")
    print("/// |    |  | Subnet 1 / EC2 |        |   Route-Table   |           |      |")
    print("/// |    |  |________________|________|_________________|           |      |")
    print("/// |    |  |    Subnet 2    |______                                |      |")
    print("/// |    |  |________________|      |          _____Priv-VPC_____   |      |")
    print("/// |    |  |    Subnet 3    |      |__________|  Subnet 1 /SQL  |  |      |")
    print("/// |    |  |________________|                 |_________________|  |      |")
    print("/// |    |                                     |     Subnet 2    |  |      |")
    print("/// |    |                                     |_________________|  |      |")
    print("/// |    |                                     |     Subnet 3    |  |      |")
    print("/// |    |                                     |_________________|  |      |")
    print("/// |    |__________________________________________________________|      |")
    print("/// |                                                                      |")
    print("/// |______________________________________________________________________|")   
    print("/// Please use this command in your terminal: " + uploadurl+ "")
    print("/// Your SQL-DB is callable at following Endpoint: "+ db_name +".cumljbg3yygv."+db_region+ ".rds.amazonaws.com")
    if estimated_cost <"1":
        estimated_cost = "Thank god it`s a Sandbox!"
        print("/// This infrastructure incurs monthly costs of: " +estimated_cost)
    else: 
        print("/// This infrastructure incurs monthly costs of: " +estimated_cost+ " $")
