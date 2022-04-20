def output_app(uploadurl):

    print("/////////////////////////// Your Infrastructure ")
    print("///")
    print("/// _________________________________________________________________________")
    print("/// |                                                                        |")
    print("/// |  [S3-Bucket]                                                           |")
    print("/// |     ______________________ [Internet-Gateway]___________________       |")
    print("/// |    |                                  |_________                |      |")
    print("/// |    |  ____Target-Group______    _ _             |               |      |")
    print("/// |    |  |   _____Pub-VPC____  |  |  B|     _______|_________      |      |")
    print("/// |    |  |  | Subnet 1 / EC2 | |  |L A|    |   Route-Table   |     |      |")
    print("/// |    |  |  |________________| |__|O L|____|_________________|     |      |")
    print("/// |    |  |  | Subnet 2 / EC2 | |  |A A|                            |      |")
    print("/// |    |  |  |________________| |  |D N|         ________________   |      |")
    print("/// |    |  |  | Subnet 3 / EC2 | |  |- C|________|  Cloudwatch -  |  |      |")
    print("/// |    |  |  |________________| |  |  E|        |  Health-Check  |  |      |")
    print("/// |    |  |_____________________|  |_ R|        |________________|  |      |")
    print("/// |    |                                                            |      |")
    print("/// |    |____________________________________________________________|      |")
    print("/// |                                                                        |")
    print("/// |________________________________________________________________________|")
    print("/// Please upload your Data using following command: "+uploadurl)  
