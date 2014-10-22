TeX Live docker file
====================

Version: **2014**

Installation scheme: **full**

What problem does it solve? You can now install and try any **TeX Live** version you want without hassle.

Do you already know what TeX Live is? Jump to [usage](#usage) section. Otherwise keep reading the next paragraph.

Introduction
------------

This docker image provides an environment containing a full installation of **TeX Live 2014**.

So running it you will have the full set of programs that make possible to compile **TeX** and **LaTeX** documents.

There are 3 output formats (DVI, PS, PDF) available in all TeX distributions. To generate a specific output the documents have to be compiled by running one of the provided programs (see this schematic [reference](https://it.sharelatex.com/learn/Choosing_a_LaTeX_Compiler#Reference_guide) to commands).

For example, if you want to compile a file named `"ciao.tex"` you can use one of the next commands:

```
$ latex ciao.tex
```

This will create a **DVI*** document: `"ciao.dvi"`

```
$ pdflatex ciao.tex
```

This will generate a **PDF** document: `"ciao.pdf"`

In some cases, when your document includes cross-references, you must compile the source twice. It is necessary to include the correct numbers in the table of contents, list of images, reference numbers to theorems and so on.

This process can be automatized by the command `latexmk`.

For example, to create a PDF out of the `"ciao.tex"` file, run

```
$ latexmk -pdf ciao.tex
```

only once, even if the document has referenced images and bibliography.

Further info about TeX are available in the [official documentation](https://www.tug.org/texlive/doc/texlive-en/texlive-en.html).

Usage
-----

Suppose you have you **TeX** file named `sample.tex` into a `test` directory in your home.

With this docker image you can know compile it this way:

```
$ docker run -it -v $HOME/test:/test leodido/texlive:2014 pdflatex -output-directory=/test test/sample.tex
```

If compilation succeeded, into your `$HOME/test` directory you will have the resulting files (e.g., `sample.pdf`).


Installation
------------

You can clone this repository and manually build it.

```
cd dockerfiles/texlive\:2014
docker build -t leodido/texlive:2014 .
```

Otherwise you can pull this image from the docker index.

```
docker pull leodido/texlive:2014
```

---

[![Analytics](https://ga-beacon.appspot.com/UA-49657176-1/dockerfiles/texlive:2014)](https://github.com/igrigorik/ga-beacon)