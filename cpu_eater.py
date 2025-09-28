
# cpu_eater.py
# ⚠️ This program will fully load your CPU cores until stopped.
# Run at your own risk! (Ctrl+C to stop)

import multiprocessing

def burn():
    while True:
        pass  # tight loop, 100% one core

if __name__ == "__main__":
    procs = []
    for _ in range(multiprocessing.cpu_count()):
        p = multiprocessing.Process(target=burn)
        p.start()
        procs.append(p)

    try:
        for p in procs:
            p.join()
    except KeyboardInterrupt:
        print("Stopping...")
