# runkernelviacoderunstartup

Run kernel image and/or initrd using coderunstartup feature

compile steps:

1- make sure you have arm64 compilation tools (aarch64-linux-gnu)

2- 
```
cd code
./make.sh
mv code.text ../code.text
cd ..

./makefile.sh [kernel file] [ramdisk file] [output file]

```