#!/bin/bash

remove_previous_packages() {
    pkgname=$1
    pkgver=$2
    pkgrel=$3

    # Use find to locate the package files
    find . -maxdepth 1 -type f -name "$pkgname-$pkgver-$pkgrel-*.pkg.tar.*" -exec rm {} \;
}

copy_package_to_repo() {
    pkgname=$1
    pkgver=$2
    pkgrel=$3

    # Use find to locate the new package files and copy them to the repository
    find . -maxdepth 1 -type f -name "*.pkg.tar.*" -exec mv {} /tmp/cache/ \;
}

for package_dir in */; do

    [ -d "$package_dir" ] || continue

    # Move into the package directory
    cd "$package_dir"

    pkgname=$(grep -m1 "^pkgname=" PKGBUILD | cut -d= -f2 | tr -d "'")
    pkgver=$(grep -m1 "^pkgver=" PKGBUILD | cut -d= -f2 | tr -d "'")
    pkgrel=$(grep -m1 "^pkgrel=" PKGBUILD | cut -d= -f2 | tr -d "'")

    remove_previous_packages "$pkgname" "$pkgver" "$pkgrel"

    # Rebuild and install the package with makepkg -s
    yes|makepkg -S -s -f -C -c --sign --key DA6BDDD08D26A04AAC997968C79769BC07914012 

    copy_package_to_repo "$pkgname" "$pkgver" "$pkgrel"

    # Move back to the parent directory for the next iteration
    cd ..
done

