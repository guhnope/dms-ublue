#!/bin/bash

# Add users with UID >= 1000 to greetd group
echo "Adding users with UID >= 1000 to greetd..."
for u in $(awk -F: '$3 >= 1000 {print $1}' /etc/passwd); do
    usermod -aG greetd "$u"
done

# Add users with home directories under /var/home to greetd group
echo "Adding users with home directories in /var/home to greetd..."
for u in $(awk -F: '$6 ~ /^\/var\/home/ {print $1}' /etc/passwd); do
    usermod -aG greetd "$u"
done

# Create the greeter user (used by greetd for the greeter session)
echo "Creating greeter user..."
groupadd -r greeter 2>/dev/null || true
useradd -r -M -d /var/lib/greeter -s /sbin/nologin -G video,render,input greeter 2>/dev/null || true

mkdir -p /var/lib/greeter /var/cache/greeter
chown greeter:greeter /var/lib/greeter /var/cache/greeter
chmod 0755 /var/lib/greeter /var/cache/greeter

echo "greeter user created."

echo "All relevant users added to greetd."
