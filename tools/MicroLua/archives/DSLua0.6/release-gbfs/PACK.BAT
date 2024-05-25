@echo off
echo -- Removing old builds
rmdir /s /q bundle
mkdir bundle

echo -- Packing data into a single GBFS data file
bin\gbfs.exe bundle\data.gbfs scripts\*.*
rem pause

echo -- Append GBFS data file onto end of DSLUA.NDS
copy DSLua.nds bundle\DSLua.nds.bin
bin\padbin 256 bundle\DSLua.nds.bin
copy /B bundle\DSLua.nds.bin+bundle\data.gbfs bundle\DSLUA-PACK.nds
rem pause

echo -- Append GBFS data file onto end of DSLUA.DS.GBA
copy DSLUA.DS.GBA bundle\DSLUA.DS.GBA.bin
bin\padbin 256 bundle\DSLUA.DS.GBA.bin
copy /B bundle\DSLUA.DS.GBA.bin+bundle\data.gbfs bundle\DSLUA-PACK.ds.gba
rem pause

echo -- Append GBFS data file onto end of DSLUA.sc.nds
copy DSLUA.sc.nds bundle\DSLUA.sc.nds.bin
bin\padbin 256 bundle\DSLUA.sc.nds.bin
copy /B bundle\DSLUA.sc.nds.bin+bundle\data.gbfs bundle\DSLUA-PACK.sc.nds
rem pause

rem del bundle\data.gbfs
echo on