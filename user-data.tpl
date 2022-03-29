 #!/bin/bash
sudo yum install -y httpd mysql php
sudo chkconfig httpd on
sudo service httpd start