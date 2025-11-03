ip addr | grep -oP 'inet \K[\d.]+' | grep -v '^127\.'
