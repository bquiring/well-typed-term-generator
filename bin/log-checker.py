
import argparse 

parser = argparse.ArgumentParser(
                    prog='TODO',
                    description='TODO',
                    epilog='TODO')

parser.add_argument("filepath")
args = parser.parse_args()
filepath = args.filepath

f = open(filepath, 'r')
lines = f.readlines()
lines = [line for line in lines if line != "====\n"]
for i in range(len(lines)//2):
    line1 = lines[2*i]
    line2 = lines[2*i+1]
    if line1 != line2:
        print(line1 + line2)
