import os
def output_app(uploadurl):
    estimated_cost = str(os.system("aws ce get-cost-and-usage --time-period Start=2022-04-21,End=2022-05-01 --granularity=MONTHLY  --metrics BlendedCost --query ResultsByTime[].Total.BlendedCost.[Amount] --output text"))
    print("/////////////////////////// Your Infrastructure ")
    print("///")
    print("/// _________________________________________________________________________")
    print("/// |                                                                        |")
    print("/// |  [S3-Bucket]                                                           |")
    print("/// |     ______________________ [Internet-Gateway]___________________       |")
    print("/// |    |                                  |_________                |      |")
    print("/// |    |  ____Target-Group______    _ _             |               |      |")
    print("/// |    |  |   _____Pub-VPC____  |  |  B|     _______|_________      |      |")
    print("/// |    |  |  | Subnet 1 / EC2 | |  |  A|    |   Route-Table   |     |      |")
    print("/// |    |  |  |________________| |  |L L|____|_________________|     |      |")
    print("/// |    |  |  | Subnet 2 / EC2 | |__|O A|                            |      |")
    print("/// |    |  |  |________________| |  |A N|         ________________   |      |")
    print("/// |    |  |  | Subnet 3 / EC2 | |  |D C|________|  Cloudwatch -  |  |      |")
    print("/// |    |  |  |________________| |  |  E|        |  Health-Check  |  |      |")
    print("/// |    |  |_____________________|  |  R|        |________________|  |      |")
    print("/// |    |                           |___|                            |      |")
    print("/// |    |____________________________________________________________|      |")
    print("/// |                                                                        |")
    print("/// |________________________________________________________________________|")
    print("/// Please upload your Data using following command: "+uploadurl)  
    if estimated_cost <"1":
        estimated_cost = "Thank god it`s a Sandbox!"
        print("/// This infrastructure incurs monthly costs of: " +estimated_cost)
    else: 
        print("/// This infrastructure incurs monthly costs of: " +estimated_cost+ " $")
