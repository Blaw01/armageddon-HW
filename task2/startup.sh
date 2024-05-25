Motivated Mind
#Thanks to Remo
#!/bin/bash
# Update and install Apache2
apt update
apt install -y apache2

# Start and enable Apache2
systemctl start apache2
systemctl enable apache2

# Set image URL
#IMAGE_URL="https://giphy.com/embed/1lSUmZQb1HsIHj6kVX" width="480" height="480" style="" frameBorder="0" class="giphy-embed" allowFullScreen></iframe><p><a href="https://giphy.com/gifs/MicrosoftCloud-microsoft-badge-certified-1lSUmZQb1HsIHj6kVX">via GIPHY</a></p>"
#IMAGE_URL="https://www.freecodecamp.org/news/content/images/size/w2000/2020/06/cloud-developer-7.png"
#$IMAGE_URL="https://rlevchenko.com/wp-content/uploads/2019/10/azure-devops-engineer-expert-600x600.png?w=450"

# GCP Metadata server base URL and header
METADATA_URL="http://metadata.google.internal/computeMetadata/v1"
METADATA_FLAVOR_HEADER="Metadata-Flavor: Google"

# Use curl to fetch instance metadata
local_ipv4=$(curl -H "${METADATA_FLAVOR_HEADER}" -s "${METADATA_URL}/instance/network-interfaces/0/ip")
zone=$(curl -H "${METADATA_FLAVOR_HEADER}" -s "${METADATA_URL}/instance/zone")
project_id=$(curl -H "${METADATA_FLAVOR_HEADER}" -s "${METADATA_URL}/project/project-id")
network_tags=$(curl -H "${METADATA_FLAVOR_HEADER}" -s "${METADATA_URL}/instance/tags")

# Create a simple HTML page and include instance details
cat <<EOF > /var/www/html/index.html
<html><body>
<h2>Thank you Motivated for all the patience </h2>
<h3>Let get these fuckin certs!!!!
<iframe src="https://giphy.com/embed/1lSUmZQb1HsIHj6kVX" width="480" height="480" style="" frameBorder="0" class="giphy-embed" allowFullScreen></iframe><p><a href="https://giphy.com/gifs/MicrosoftCloud-microsoft-badge-certified-1lSUmZQb1HsIHj6kVX">via GIPHY</a></p></h3>
<p><b>Instance Name:</b> $(hostname -f)</p>
<p><b>Instance Private IP Address: </b> $local_ipv4</p>
<p><b>Zone: </b> $zone</p>
<p><b>Project ID:</b> $project_id</p>
<p><b>Network Tags:</b> $network_tags</p>
</body></html>
EOF