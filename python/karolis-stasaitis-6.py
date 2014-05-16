#!/usr/bin/python

from operator import itemgetter

keyboard_layout = ["qwertyuiop", "asdfghjkl", "zxcvbnm"];

def search(word):
	coords = [];
	for i in range(len(word)):
		for j in range(len(keyboard_layout)):
			for k in range (len(keyboard_layout[j])):
				if keyboard_layout[j][k] == word[i]:
					coords.insert(i,[j,k])
	return coords

def print_results(file, counted_words):
	for i in range(len(counted_words)):
		file.write(counted_words[i][0])
		file.write(" ")
		file.write(str(counted_words[i][1]))
		file.write(" ")
	file.write("\n")

infile = open("in.txt", "r")
outfile = open("out.txt", "w")
test_case_count = int(infile.readline().strip())
assert test_case_count > 0 and test_case_count < 20
for i in range(test_case_count):
	test_case = infile.readline().strip().split(" ")
	original_word = test_case[0]
	original_word_coords = search(original_word)

	suggested_word_count = int(test_case[1])
	assert suggested_word_count > 0 and suggested_word_count < 10

	counted_words = []
	for y in range(suggested_word_count):
		suggested_word = test_case[y+2]
		suggested_word_coords = search(suggested_word)
		result = 0;
		for k in range(len(suggested_word_coords)):
			result += abs(original_word_coords[k][0] - suggested_word_coords[k][0]) + abs(original_word_coords[k][1] - suggested_word_coords[k][1])
		counted_words.append([suggested_word, result])

	counted_words = sorted(counted_words, key=itemgetter(1,0))
	print_results(outfile, counted_words)

infile.close()
outfile.close()