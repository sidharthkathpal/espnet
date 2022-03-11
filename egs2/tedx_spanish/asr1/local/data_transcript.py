#!/usr/bin/env python
# coding: utf-8

import pandas as pd
import sys

filepath = sys.argv[1] + "/tedx_spanish_corpus/"
filename = filepath + "/files/TEDx_Spanish.transcription"
data = []

with open(filename) as file:
    for line in file:
        s = line.rsplit(' ', 1)
        sentence = s[0]
        path = s[1].rstrip("\n") + ".wav"
        client_id = path.rsplit('_', 2)[0]
        gender = "female" if client_id.split('_')[1] == "F" else "male"
        data.append([client_id, path, sentence, 0, 0, None, gender, None, 'es', None])

df = pd.DataFrame(data, columns=['client_id', 'path', 'sentence', 'up_votes', 'down_votes', 'age', 'gender', 'accent', 'locale', 'segment'])

train_df = df.sample(frac=0.9, random_state=200)
test_df = df.drop(train_df.index)
dev_df = test_df.sample(frac=0.5, random_state=200)
test_df = test_df.drop(dev_df.index)

train_df.to_csv(filepath + "train.tsv", sep='\t', index=False)
dev_df.to_csv(filepath + "dev.tsv", sep='\t', index=False)
test_df.to_csv(filepath + "test.tsv", sep='\t', index=False)
