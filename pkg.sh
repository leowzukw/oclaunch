#!/bin/sh
# A little script to create tarball, especially for Oasis2Opam

echo "Start"

# If directory doesn't exist, create it
if ! [ -e dist ]; then
    mkdir dist
fi

# If no tag, use commit SHA1
id=`git describe --abbrev=10 --candidates=50 HEAD`
name=oclaunch_${id}_src # _src emphasis the difference with binary tarballs

echo "Writing in" $name".*"
git archive HEAD --prefix=${name}/ --format=zip -o dist/${name}.zip -9
# Creating .xz .gz and .bz2 from tar archive
tar_name=${name}.tar
git archive HEAD --prefix=${name}/ --format=tar -o dist/${tar_name}
cd dist
gzip -c9 < ${tar_name} >  ${tar_name}.gz
bzip2 -c9 < ${tar_name} >  ${tar_name}.bz2
xz -c9 < ${tar_name} >  ${tar_name}.xz

