Here is a quick introduction to Lua and a disambiguation with MicroLua.


[TOC]


Lua
===

Quoting its [official site](http://www.lua.org/):
>  Lua is a powerful, fast, lightweight, embeddable scripting language.

Lua combines simple procedural syntax with powerful data description constructs based on associative arrays and extensible semantics. Lua is dynamically typed, runs by interpreting bytecode for a register-based virtual machine, and has automatic memory management with incremental garbage collection, making it ideal for configuration, scripting, and rapid prototyping.

It is designed, implemented and maintained at LabLua, ans is originated from Rio de Janeiro (Brazil). This is why its name is the Portuguese word for "Moon".

Lua is simple, embeddable and yet powerful and robust which makes a good choice of a language.


MicroLua is not Lua
===================

A for the disambiguation part, it can be summarized as:
> ___MicroLua is not the programming language, Lua is.___

MicroLua is an interpreter porting Lua on the Nintendo DS. To do this, it needs to modify the sources of Lua, and add to it some features specific to the embedded system, basically displaying stuff and everything which is OS-related.

We can say your script is coded 'with' or 'in' MicroLua, but do not forget the language reference is the one from Lua and that µLua does all that is needed to have it running on your console.