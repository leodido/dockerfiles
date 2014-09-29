# TreeTagger docker image 

This repo is a docker image which packages a ready to use [TreeTagger](http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/) instance (**latest version**).

Once installed it you will not have to manually install TreeTagger.

What it is
----------

TreeTagger is a tool for annotating text with part-of-speech ([POS tagging](http://en.wikipedia.org/wiki/Part-of-speech_tagging)) and lemma information.

TreeTagger consists of two programs:

1. `train-tree-tagger`

    used to create a parameter file from a lexicon and a handtagged corpus. 
    
2. `tree-tagger` 

    used to annotate the text with part-of-speech tags, given a parameter file and a text file as arguments.

Primary files contained in this package are:

- training program at `bin/train-tree-tagger`

- tagger program at `bin/tree-tagger`       

- program for tokenization (used by the shell scripts) at `bin/separate-punctuation`

- shell scripts which simplify tagging at `cmd` directory:

    e.g., `tree-tagger-italian`, `tree-tagger-german`, `tagger-chunker-english`, ...
    
- parameter files, chunker parameter files, and abbreviations, installed into the `lib` directory

- docs about TreeTagger is in `doc` directory

- some of the language tagsets are in the `tagsets` directory

See yourself the content of `treetagger-3.2` directory inside the docker image:

```bash
docker run -i -t leodido/treetagger:latest ls treetagger-3.2
```

Already trained (and so supported) languages are:

1. Bulgarian
2. Dutch
3. English
4. Estonian
5. Finnish
6. French
7. Galician
8. German
9. Italian
10. Latin
11. Polish
12. Russian
13. Slovak
14. Spanish
15. Swahili
16. Mongolian (only parameter file provided, no scripts)


Installation
------------

You can clone this repository and manually build it.

```
cd dockerfiles/treetagger\:latest
docker build -t leodido/treetagger:latest .
```

Otherwise you can pull this image from the docker index.

```
docker pull leodido/treetagger:latest
```

Usage
-----

### Tagging

Suppose you want to (tokenize and) tag an Italian text. The script to use is `cmd/tree-tagger-italian <file>*`.

It expects UTF8 encoded input files as arguments. If no files have been specified, input from stdin is expected.

```bash
echo 'Proviamo semplicemente a eseguire un test di prova.' | docker run -i leodido/treetagger:latest tree-tagger-italian
```

Outputs:

```
Proviamo	VER:pres	provare
semplicemente	ADV	semplicemente
a	PRE	a
eseguire	VER:infi	eseguire
un	DET:indef	un
test	NOM	test
di	PRE	di
prova	NOM	prova
.	SENT	.
```

### Chunking

Suppose you want to tokenize, tag and annotate a German text with nominal and verbal chunks.

```bash
echo 'Das ist ein Test.' | docker run -i leodido/treetagger:latest tagger-chunker-german
```

Outputs:

```xml
<NC>
Das	PDS	die
</NC>
<VC>
ist	VAFIN	sein
</VC>
<NC>
ein	ART	eine
Test	NN	Test
</NC>
.	$.	.
```

Todos
---------

- Add support for Chinese, Spoken French, and Portuguese.
- Train other chunkers for major languages (e.g., italian, spanish)

Credits
-------

- Helmut Schmid, University of Stuttgart, Germany 

_Last update: 29/09/2014_

---

[![Analytics](https://ga-beacon.appspot.com/UA-49657176-1/dockerfiles/treetagger:latest)](https://github.com/igrigorik/ga-beacon)
