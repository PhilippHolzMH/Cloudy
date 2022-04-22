import os

def output_dyn(uploadurl):
    estimated_cost = str(os.system("aws ce get-cost-and-usage --time-period Start=2022-04-21,End=2022-05-01 --granularity=MONTHLY  --metrics BlendedCost --query ResultsByTime[].Total.BlendedCost.[Amount] --output text"))
    print("/////////////////////////// Your Infrastructure ")
    print("///")
    print("/// ________________________________________________________________________")
    print("/// |                                                                      |")
    print("/// |  [S3-Bucket]________________________________________[Lambda]         |")
    print("/// |     ______________________[Internet-Gateway]__________|_______       |")
    print("/// |    |                                    |             |       |      |")
    print("/// |    |                                    |             |       |      |")
    print("/// |    |   _____Pub-VPC____          _______|_________    |       |      |")
    print("/// |    |  | Subnet 1 / EC2 |        |   Route-Table   |   |       |      |")
    print("/// |    |  |________________|________|_________________|   |       |      |")
    print("/// |    |  |    Subnet 2    |        |                     |       |      |")
    print("/// |    |  |________________|        |        _____________|___    |      |")
    print("/// |    |  |    Subnet 3    |        |________|  Dynamo-DB     |   |      |")
    print("/// |    |  |________________|                 |________________|   |      |")
    print("/// |    |                                                          |      |")
    print("/// |    |                                                          |      |")
    print("/// |    |__________________________________________________________|      |")
    print("/// |                                                                      |")
    print("/// |______________________________________________________________________|")   
    print("/// Please upload your CSV-File to the S3-Bucket using following command: " + uploadurl+"  ")
    if estimated_cost <"1":
        estimated_cost = "Thank god it`s a Sandbox!"
        print("/// This infrastructure incurs monthly costs of: " +estimated_cost)
    else: 
        print("/// This infrastructure incurs monthly costs of: " +estimated_cost+ " $")
