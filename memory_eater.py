
# memory_eater.py
# ⚠️ This program will intentionally try to eat all your RAM.
# Run at your own risk! (recommended inside a terminal you can kill with Ctrl+C)

import time

data = []
try:
    while True:
        # Allocate ~10 MB chunks repeatedly
        data.append(" " * (100 * 1024 * 1024))
        print(f"Allocated {len(data)*100} MB")
        time.sleep(0.1)
except KeyboardInterrupt:
    print("Stopped by user")
