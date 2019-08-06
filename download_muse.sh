# mkdir -p vectors

# for lang in $(cat language_map.csv | cut -f 2 -d, | cut -f 1 -d "-")
# do
#     echo wget https://dl.fbaipublicfiles.com/arrival/vectors/wiki.multi.$lang.vec -O vectors/$lang.vec
# done


# ######

# python3 merge_vectors.py --count 1000000 vectors/fi.vec vectors/en.vec vectors/sv.vec vectors/cs.vec > fi-en-sv-cs.vec
# python3 merge_vectors.py --count 1000000 vectors/*.vec > universal.vec

# ######

rm uni_uni-ud-*.conllu
for TB in $(cat language_map.csv | cut -f 1,3 -d, --output-delimiter "-")
do
    cat ud-treebanks-v2.4/UD_$TB/*-train*.conllu >> uni_uni-ud-train.conllu
    cat ud-treebanks-v2.4/UD_$TB/*-dev*.conllu >> uni_uni-ud-dev.conllu
    cat ud-treebanks-v2.4/UD_$TB/*-test*.conllu >> uni_uni-ud-test.conllu
done
