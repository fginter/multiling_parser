import sys
import argparse
import os
import io

parser = argparse.ArgumentParser()
parser.add_argument('--count',type=int,default=1000000,help='How many vectors to keep? This will be divided by the number of embedding files, which will tell how many vectors per language. Default: %(default)d')
parser.add_argument("sources",nargs="+",help="source vector files")
args = parser.parse_args()

max_per_lang=int(args.count/len(args.sources))
counter=0
buff=io.StringIO()
global_dim=None
for fname in args.sources:
    lang=os.path.basename(fname).split(".")[0]
    with open(fname) as f:
        first=f.readline()
        lines,dim=first.strip().split()
        assert global_dim is None or global_dim==dim
        global_dim=dim
        for idx,line in enumerate(f):
            if idx+1>=max_per_lang:
                break
            print("^",lang,":",line,sep="",end="",file=buff)
            counter+=1
print(counter,global_dim)
print(buff.getvalue(),end="")

            
