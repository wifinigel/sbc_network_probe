
target_dir="/usr/local/bin"

echo "Installing command files to ${target_dir}..."
sudo cp ./sbc_* ${target_dir}

echo "Setting command file permissions in ${target_dir}..."
sudo chmod +x ${target_dir}/sbc_*

echo "Complete."
