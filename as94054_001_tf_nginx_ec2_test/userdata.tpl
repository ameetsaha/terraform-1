#!/bin/bash
sudo apt update -y &&
sudo apt install -y nginx
cat << EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
<title>Page Title</title>
</head>
<body>

<h1>This Web Service is running in an EC2 Instance under AWS Services.</h1>


<p>You can download the Terraform codes from the below link<br><br>

Regards,<br>
<a href="https://github.com/ameetsaha">Amit Saha</a>

</body>
</html>

EOF

#echo "This is an NGINX Service Running in an EC2 Instance" > /var/www/html/index.html
