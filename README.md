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

### Metadata API

The Metadata API is used to transfer data from a host machine to a SmartMachine 
or Virtual Machine. There are currently three scripts included with the VM Guest 
Tools which uses the Metadata API: 'set-root-authorized-keys', 'run-user-script'
and 'set-administrator-password.vbs'. 'set-root-authorized-keys' is used to set
the authorized_keys for the root user. 'run-user-script' can be used to run a 
custom script. Both scripts are started by rc.local and are only run at first 
boot. 'set-administrator-password.vbs' is used to set the administrator password 
on a windows vm. Each machine has its own Metadata store on the host and is 
configured by modifying `/zones/<zone name>/config/metadata.json`.

#### metadata.json example (linux)
    {
      "customer_metadata": {
        "root_authorized_keys": "ssh-rsa AAAAB3N...",
        "user-script": "#!/bin/bash\necho \"hello world\" > /root/hello.txt\n"
      },
    
      "internal_metadata": {}
    }

#### metadata.json example (windows)
    {
      "customer_metadata": {
        "administrator_pw": "secret"
      },
    
      "internal_metadata": {}
    }
