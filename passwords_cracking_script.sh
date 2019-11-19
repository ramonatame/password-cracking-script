#!/bin/bash

# author: Ramona Tame

pwd_utils_dir=$1
output_dir=$2
hashlist=$3
hashcat_dir=$4
hash_mode=$5
#run example: ./password_cracking_script ../passwords_worlists_30_11_2018 ../pwd_cracking ../hashcat-3.30 hashes

# number only passwords
outfile=$output_dir/cracked_numbers
hashcat -m $hash_mode -a 3 -o $outfile $hashlist $pwd_utils_dir/rules/numbers_ruletheall.rules --remove --force

# worst, common, top 10k, leaked medium and high - dictionary attack
outfile=$output_dir/cracked_dictionary
hashcat -m $hash_mode -a 0 -o $outfile $hashlist $pwd_utils_dir/wordlists/worst/all_worst --force --remove
hashcat -m $hash_mode -a 0 -o $outfile $hashlist $pwd_utils_dir/wordlists/common/cat_all_common_words --force --remove
hashcat -m $hash_mode -a 0 -o $outfile $hashlist $pwd_utils_dir/wordlists/dict/top10k_english.txt --force --remove
hashcat -m $hash_mode -a 0 -o $outfile $hashlist $pwd_utils_dir/wordlists/leaked/final_lists/all_leaked_by_freq  --force --remove

# hybrid - rules for numbers, symbols, case, substitution
outfile=$output_dir/cracked_hybrid
hashcat -m $hash_mode -a 0 -o $outfile $hashlist $pwd_utils_dir/wordlists/worst/all_worst -r $pwd_utils_dir/rules/cat_all_custom_rules.rule --force --remove
hashcat -m $hash_mode -a 0 -o $outfile $hashlist $pwd_utils_dir/wordlists/common/cat_all_common_words -r $pwd_utils_dir/rules/cat_all_custom_rules.rule --force --remove
hashcat -m $hash_mode -a 0 -o $outfile $hashlist $pwd_utils_dir/wordlists/dict/top10k_english.txt -r $pwd_utils_dir/rules/cat_all_custom_rules.rule --force --remove
hashcat -m $hash_mode -a 0 -o $outfile $hashlist $pwd_utils_dir/wordlists/leaked/final_lists/all_leaked_by_freq -r $pwd_utils_dir/rules/cat_all_custom_rules.rule --force --remove

# brute-force up to 6
outfile=$output_dir/cracked_brute
hashcat -m $hash_mode -a 3 -o $outfile $hashlist $pwd_utils_dir/masks/all_up_to_6 --remove --force


# combined attack
outfile=$output_dir/cracked_combined
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/worst/all_worst $pwd_utils_dir/wordlists/worst/all_worst --force --remove
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/common/cat_all_common_words $pwd_utils_dir/wordlists/common/cat_all_common_words --force --remove
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/dict/top10k_english.txt $pwd_utils_dir/wordlists/dict/top10k_english.txt --force --remove
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/leaked/final_lists/all_leaked_by_freq $pwd_utils_dir/wordlists/leaked/final_lists/all_leaked_by_freq --force --remove

hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/worst/all_worst $pwd_utils_dir/wordlists/common/cat_all_common_words --force --remove
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/common/cat_all_common_words $pwd_utils_dir/wordlists/worst/all_worst --force --remove

hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/worst/all_worst $pwd_utils_dir/wordlists/leaked/all_leaked_by_freq --force --remove
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/leaked/all_leaked_by_freq $pwd_utils_dir/wordlists/worst/all_worst --force --remove

hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/common/cat_all_common_words $pwd_utils_dir/wordlists/leaked/all_leaked_by_freq --force --remove
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/leaked/all_leaked_by_freq $pwd_utils_dir/wordlists/common/cat_all_common_words --force --remove

hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/worst/all_worst $pwd_utils_dir/wordlists/dict/top10k_english.txt --force --remove
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/leaked/all_leaked_by_freq $pwd_utils_dir/wordlists/dict/top10k_english.txt --force --remove
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/common/cat_all_common_words $pwd_utils_dir/wordlists/dict/top10k_english.txt --force --remove
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/dict/top10k_english.txt $pwd_utils_dir/wordlists/worst/all_worst --force --remove
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/dict/top10k_english.txt $pwd_utils_dir/wordlists/leaked/all_leaked_by_freq --force --remove
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/dict/top10k_english.txt $pwd_utils_dir/wordlists/common/cat_all_common_words --force --remove

# combined attack with rules for numbers, symbols, case, substitution

# left
outfile=$output_dir/combined_left_hybrid
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/worst/all_worst $pwd_utils_dir/wordlists/worst/all_worst --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/common/cat_all_common_words $pwd_utils_dir/wordlists/common/cat_all_common_words --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule 
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/dict/top10k_english.txt $pwd_utils_dir/wordlists/dict/top10k_english.txt --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule 
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/leaked/final_lists/all_leaked_by_freq $pwd_utils_dir/wordlists/leaked/final_lists/all_leaked_by_freq --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule 

hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/worst/all_worst $pwd_utils_dir/wordlists/common/cat_all_common_words --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule 
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/common/cat_all_common_words $pwd_utils_dir/wordlists/worst/all_worst --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule 

hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/worst/all_worst $pwd_utils_dir/wordlists/leaked/all_leaked_by_freq --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule 
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/leaked/all_leaked_by_freq $pwd_utils_dir/wordlists/worst/all_worst --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule 

hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/common/cat_all_common_words $pwd_utils_dir/wordlists/leaked/all_leaked_by_freq --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule 
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/leaked/all_leaked_by_freq $pwd_utils_dir/wordlists/common/cat_all_common_words --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule 

hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/worst/all_worst $pwd_utils_dir/wordlists/dict/top10k_english.txt --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule 
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/leaked/all_leaked_by_freq $pwd_utils_dir/wordlists/dict/top10k_english.txt --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule 
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/common/cat_all_common_words $pwd_utils_dir/wordlists/dict/top10k_english.txt --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule 
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/dict/top10k_english.txt $pwd_utils_dir/wordlists/worst/all_worst --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule 
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/dict/top10k_english.txt $pwd_utils_dir/wordlists/leaked/all_leaked_by_freq --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule 
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/dict/top10k_english.txt $pwd_utils_dir/wordlists/common/cat_all_common_words --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule 


# right

outfile=$output_dir/combined_right_hybrid
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/worst/all_worst $pwd_utils_dir/wordlists/worst/all_worst --force --remove -k $pwd_utils_dir/rules/cat_all_custom_rules.rule
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/common/cat_all_common_words $pwd_utils_dir/wordlists/common/cat_all_common_words --force --remove -k $pwd_utils_dir/rules/cat_all_custom_rules.rule
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/dict/top10k_english.txt $pwd_utils_dir/wordlists/dict/top10k_english.txt --force --remove -k $pwd_utils_dir/rules/cat_all_custom_rules.rule
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/leaked/final_lists/all_leaked_by_freq $pwd_utils_dir/wordlists/leaked/final_lists/all_leaked_by_freq --force --remove -k $pwd_utils_dir/rules/cat_all_custom_rules.rule

hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/worst/all_worst $pwd_utils_dir/wordlists/common/cat_all_common_words --force --remove -k $pwd_utils_dir/rules/cat_all_custom_rules.rule
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/common/cat_all_common_words $pwd_utils_dir/wordlists/worst/all_worst --force --remove -k $pwd_utils_dir/rules/cat_all_custom_rules.rule

hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/worst/all_worst $pwd_utils_dir/wordlists/leaked/all_leaked_by_freq --force --remove -k $pwd_utils_dir/rules/cat_all_custom_rules.rule
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/leaked/all_leaked_by_freq $pwd_utils_dir/wordlists/worst/all_worst --force --remove -k $pwd_utils_dir/rules/cat_all_custom_rules.rule

hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/common/cat_all_common_words $pwd_utils_dir/wordlists/leaked/all_leaked_by_freq --force --remove -k $pwd_utils_dir/rules/cat_all_custom_rules.rule
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/leaked/all_leaked_by_freq $pwd_utils_dir/wordlists/common/cat_all_common_words --force --remove -k $pwd_utils_dir/rules/cat_all_custom_rules.rule

hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/worst/all_worst $pwd_utils_dir/wordlists/dict/top10k_english.txt --force --remove -k $pwd_utils_dir/rules/cat_all_custom_rules.rule
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/leaked/all_leaked_by_freq $pwd_utils_dir/wordlists/dict/top10k_english.txt --force --remove -k $pwd_utils_dir/rules/cat_all_custom_rules.rule
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/common/cat_all_common_words $pwd_utils_dir/wordlists/dict/top10k_english.txt --force --remove -k $pwd_utils_dir/rules/cat_all_custom_rules.rule
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/dict/top10k_english.txt $pwd_utils_dir/wordlists/worst/all_worst --force --remove -k $pwd_utils_dir/rules/cat_all_custom_rules.rule
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/dict/top10k_english.txt $pwd_utils_dir/wordlists/leaked/all_leaked_by_freq --force --remove -k $pwd_utils_dir/rules/cat_all_custom_rules.rule
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/dict/top10k_english.txt $pwd_utils_dir/wordlists/common/cat_all_common_words --force --remove -k $pwd_utils_dir/rules/cat_all_custom_rules.rule


# both

outfile=$output_dir/combined_both_hybrid
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/worst/all_worst $pwd_utils_dir/wordlists/worst/all_worst --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule -k $pwd_utils_dir/rules/cat_all_custom_rules.rule
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/common/cat_all_common_words $pwd_utils_dir/wordlists/common/cat_all_common_words --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule -k $pwd_utils_dir/rules/cat_all_custom_rules.rule
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/dict/top10k_english.txt $pwd_utils_dir/wordlists/dict/top10k_english.txt --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule -k $pwd_utils_dir/rules/cat_all_custom_rules.rule
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/leaked/final_lists/all_leaked_by_freq $pwd_utils_dir/wordlists/leaked/final_lists/all_leaked_by_freq --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule -k $pwd_utils_dir/rules/cat_all_custom_rules.rule

hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/worst/all_worst $pwd_utils_dir/wordlists/common/cat_all_common_words --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule -k $pwd_utils_dir/rules/cat_all_custom_rules.rule
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/common/cat_all_common_words $pwd_utils_dir/wordlists/worst/all_worst --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule -k $pwd_utils_dir/rules/cat_all_custom_rules.rule

hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/worst/all_worst $pwd_utils_dir/wordlists/leaked/all_leaked_by_freq --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule -k $pwd_utils_dir/rules/cat_all_custom_rules.rule
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/leaked/all_leaked_by_freq $pwd_utils_dir/wordlists/worst/all_worst --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule -k $pwd_utils_dir/rules/cat_all_custom_rules.rule

hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/common/cat_all_common_words $pwd_utils_dir/wordlists/leaked/all_leaked_by_freq --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule -k $pwd_utils_dir/rules/cat_all_custom_rules.rule
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/leaked/all_leaked_by_freq $pwd_utils_dir/wordlists/common/cat_all_common_words --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule -k $pwd_utils_dir/rules/cat_all_custom_rules.rule

hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/worst/all_worst $pwd_utils_dir/wordlists/dict/top10k_english.txt --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule -k $pwd_utils_dir/rules/cat_all_custom_rules.rule
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/leaked/all_leaked_by_freq $pwd_utils_dir/wordlists/dict/top10k_english.txt --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule -k $pwd_utils_dir/rules/cat_all_custom_rules.rule
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/common/cat_all_common_words $pwd_utils_dir/wordlists/dict/top10k_english.txt --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule -k $pwd_utils_dir/rules/cat_all_custom_rules.rule
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/dict/top10k_english.txt $pwd_utils_dir/wordlists/worst/all_worst --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule -k $pwd_utils_dir/rules/cat_all_custom_rules.rule
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/dict/top10k_english.txt $pwd_utils_dir/wordlists/leaked/all_leaked_by_freq --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule -k $pwd_utils_dir/rules/cat_all_custom_rules.rule
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/dict/top10k_english.txt $pwd_utils_dir/wordlists/common/cat_all_common_words --force --remove -j $pwd_utils_dir/rules/cat_all_custom_rules.rule -k $pwd_utils_dir/rules/cat_all_custom_rules.rule

# mask attack with basewords, common, worst, leaked
outfile=$output_dir/mask_basewords
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/basewords/top_basewords $pwd_utils_dir/masks/crunch-generated --force --remove
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/worst/all_worst $pwd_utils_dir/masks/crunch-generated --force --remove
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/common/cat_all_common_words $pwd_utils_dir/masks/crunch-generated --force --remove
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/dict/top10k_english $pwd_utils_dir/masks/crunch-generated --force --remove
hashcat -m $hash_mode -a 1 -o $outfile $hashlist $pwd_utils_dir/wordlists/leaked/all_leaked_by_freq $pwd_utils_dir/masks/crunch-generated --force --remove

# hashcat rules
outfile=$output_dir/hashcat_rules
hashcat -m $hash_mode -a 0 -o $outfile $hashlist $pwd_utils_dir/wordlists/worst/all_worst -r $hashcat_dir/rules/best64.rule --force --remove
hashcat -m $hash_mode -a 0 -o $outfile $hashlist $pwd_utils_dir/wordlists/common/cat_all_common_words -r $hashcat_dir/rules/best64.rule --force --remove
hashcat -m $hash_mode -a 0 -o $outfile $hashlist $pwd_utils_dir/wordlists/dict/top10k_english.txt -r $hashcat_dir/rules/best64.rule --force --remove
hashcat -m $hash_mode -a 0 -o $outfile $hashlist $pwd_utils_dir/wordlists/leaked/final_lists/all_leaked_by_freq -r $hashcat_dir/rules/best64.rule --force --remove

# brute-force 7 up to 10 - most common
outfile=$output_dir/brute_force_common
hashcat -m $hash_mode -a 3 -o $outfile $hashlist $pwd_utils_dir/masks/top_masks_less_than_8_chars --remove --force
hashcat -m $hash_mode -a 3 -o $outfile $hashlist $pwd_utils_dir/masks/top_masks_8_to_10_chars --remove --force

# brute-force up to 10 - all
outfile=$output_dir/brute_force_all
hashcat -m $hash_mode -a 3 -o $outfile $hashlist $pwd_utils_dir/masks/all_7_to_10 --remove --force