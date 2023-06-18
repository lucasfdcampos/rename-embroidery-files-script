import os
import random
import string

PENDRIVE_DIR = "/home/lucas/tmp/matrizes"


def generate_random_name(length):
    letters = string.ascii_lowercase
    return ''.join(random.choice(letters) for _ in range(length))


def main():
    print("Starting python script")

    for filename in os.listdir(PENDRIVE_DIR):
        filepath = os.path.join(PENDRIVE_DIR, filename)
        if os.path.isfile(filepath) and filename.lower().endswith('.pes'):
            print("File:", filename)
            new_filename = generate_random_name(24) + ".pes"

            new_filepath = os.path.join(PENDRIVE_DIR, new_filename)
            while os.path.exists(new_filepath):
                new_filename = generate_random_name(24) + ".pes"
                new_filepath = os.path.join(PENDRIVE_DIR, new_filename)

            os.rename(filepath, new_filepath)
            print(f"Arquivo renomeado com sucesso: {filename} -> {new_filename}")


if __name__ == "__main__":
    main()
