# Fix CSW pkgutil
rm -rf /etc/opt/csw/pkgutil.conf
echo 'mirror=http://mirror.opencsw.org/opencsw/stable' > /etc/opt/csw/pkgutil.conf

# Update CSW
pkgutil -U
pkgutil -y -u

# Install software
pkgutil -y -i gnulinks CSWruby18-gcc4 CSWruby18-dev CSWruby18 rubygems git vim

# Configure runtime linking environment
/usr/bin/crle -u -l /opt/csw/lib

