# SmartOS VM Guest Tools

The VM Guest tools contains scripts and drivers that are used to create
virtualized machine images in SmartOS.

## Installing

You can run './bin/build-image' which will create an ISO, ZIP and TAR archives
for the tools. The tools include both the Windows and Linux tools. The reason
they are created this way is so you can use an ISO to load Windows drivers
during install time, and a tarball or zipfile after a system is up and running.

## Windows

The windows directory contains signed VirtIO drivers, as well as some scripts
and binaries that are used to retrieve metadata from the metadata API. In
addition, sample sysprep files are provided that you can use to create your own
windows images. 

## Linux

The linux directory contains the 'mdata-get' tool, as well as several other
scripts for formatting a secondary disk, setting up networking, and fetching
user-scripts. There is also a 'prepare-image' tool that is used to clean up a
machine prior to turning it into an image.

## FreeBSD

The freebsd directory contains the 'mdata-get' tool, as well as several other
scripts for formatting a secondary disk, setting up networking, and fetching
user-scripts. There is also a 'prepare-image' tool that is used to clean up a
machine prior to turning it into an image. Those scripts can be used while
opening a shell from the installer so the machine does not need to complete a
full bootup.




