import os
import sys

if sys.argv[1] == "cwd":
    answer = os.getcwd()
elif sys.argv[1] == "public":
    answer = f"{ os.getcwd() }/public/assets"

if __name__ == "__main__":
    print(answer)