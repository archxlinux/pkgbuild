#!/bin/bash

for package_dir in */; do

    [ -d "$package_dir" ] || continue

    # Move into the package directory
    cd "$package_dir"

    pkgname=$(grep -m1 "^pkgname=" PKGBUILD | cut -d= -f2 | tr -d "'")
    pkgver=$(grep -m1 "^pkgver=" PKGBUILD | cut -d= -f2 | tr -d "'")
    pkgrel=$(grep -m1 "^pkgrel=" PKGBUILD | cut -d= -f2 | tr -d "'")

    # Rebuild and install the package with makepkg -s
    yes|makepkg -s -f -c -C --sign --key DA6BDDD08D26A04AAC997968C79769BC07914012 

    find . -maxdepth 1 -type f -name "*.tar.*" -exec mv {} /tmp/cache/ \;

    # Move back to the parent directory for the next iteration
    cd ..
done

cd /tmp/cache

repo-add --verify --sign -k DA6BDDD08D26A04AAC997968C79769BC07914012 -n -R archx_repo.db.tar.gz *.pkg.tar.zst


