# mkdir -p vectors

# for lang in $(cat language_map.csv | cut -f 2 -d, | cut -f 1 -d "-")
# do
#     echo wget https://dl.fbaipublicfiles.com/arrival/vectors/wiki.multi.$lang.vec -O vectors/$lang.vec
# done


# ######

# python3 merge_vectors.py --count 1000000 vectors/fi.vec vectors/en.vec vectors/sv.vec vectors/cs.vec > fi-en-sv-cs.vec
# python3 merge_vectors.py --count 1000000 vectors/*.vec > universal.vec

# ######

UD=2.2
UD_DIR=ud-treebanks-v$UD

rm uni_uni-ud-*.conllu
for L in $(cat language_map-$UD.csv)
do
    #L is Finnish,fi,TDT
    #what is the lcode?
    TB=$(echo $L | cut -f 1,3 -d, --output-delimiter "-") #Finnish-TDT
    LCODE=$(echo $L | cut -f 2 -d,)
    cat $UD_DIR/UD_$TB/*-train*.conllu | python3 add_lang_code.py --lcode $LCODE >> uni_uni-ud-train-lcodes-$UD.conllu
    cat $UD_DIR/UD_$TB/*-train*.conllu >> uni_uni-ud-train-nolcodes-$UD.conllu
    
    cat $UD_DIR/UD_$TB/*-dev*.conllu | python3 add_lang_code.py --lcode $LCODE >> uni_uni-ud-dev-lcodes-$UD.conllu
    cat $UD_DIR/UD_$TB/*-dev*.conllu >> uni_uni-ud-dev-nolcodes-$UD.conllu
    
    cat $UD_DIR/UD_$TB/*-test*.conllu >> uni_uni-ud-test-$UD.conllu
done
