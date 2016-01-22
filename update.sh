#!/bin/bash

# update sphinxsearch versions

set -eo pipefail

google_re_version='2015-11-01'
dictionaries=('http://sphinxsearch.com/files/dicts/ru.pak' 'http://sphinxsearch.com/files/dicts/en.pak' 'http://sphinxsearch.com/files/dicts/de.pak')

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

versions=( "$@" )
if [ ${#versions[@]} -eq 0 ]; then
	versions=( sphinxsearch\:*[0-9a]/ )  # version numbers, beta, but not "latest"
fi
versions=( "${versions[@]%/}" )
versions=( "${versions[@]#sphinxsearch:}" )

# fetch dictionaries into temporary folder, but only if newer
mkdir -p .dicts
for dict_url in "${dictionaries[@]}"; do
	filename="${dict_url##*/}"
	curl -s -z ".dicts/$filename" -o ".dicts/$filename" "$dict_url"
done

for version in "${versions[@]}"; do
	(
		if [[ $version == *"beta"* ]]; then
			sphinx_release_type='beta'
		else
			sphinx_release_type='release'			
		fi

		set -x
		cp indexall.sh "sphinxsearch:$version/"
		cp searchd.sh "sphinxsearch:$version/"

		mkdir -p "sphinxsearch:$version/dicts/"
		cp .dicts/* "sphinxsearch:$version/dicts/"

		sed 's/%%SPHINX_VERSION%%/'${version%-beta}'/g; s/%%SPHINX_RELEASE%%/'$sphinx_release_type'/g; s/%%GOOGLE_RE_VERSION%%/'$google_re_version'/g' Dockerfile.template > "sphinxsearch:$version/Dockerfile"
		sed 's/%%SPHINX_VERSION%%/'${version%-beta}'/g; s/%%SPHINX_RELEASE%%/'$sphinx_release_type'/g; s/%%GOOGLE_RE_VERSION%%/'$google_re_version'/g' README.template.md > "sphinxsearch:$version/README.md"
	)
done

