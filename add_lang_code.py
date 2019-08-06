import sys
import argparse
import os
import io
import regex

ID,FORM,LEMMA,UPOS,XPOS,FEATS,HEAD,DEPREL,DEPS,MISC=range(10)

parser = argparse.ArgumentParser()
parser.add_argument('--lcode',default="uni",help='Prepend this language code to every token in conllu. Default: %(default)s')
args = parser.parse_args()

for line in sys.stdin:
    line=line.rstrip("\n")
    if not line or line.startswith("#"):
        print(line)
        continue
    cols=line.split("\t")
    cols[FORM]="^"+args.lcode+":"+cols[FORM]
    cols[LEMMA]="^"+args.lcode+":"+cols[LEMMA]
    print(*cols,sep="\t")
    
